//
//  LugarGridViewController.m
//  Leyenda
//
//  Created by Daniel Rodriguez on 5/11/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import "LugarGridViewController.h"
#import "LeyendaPhotoCell.h"
#import "LeyendaDetailViewController.h"
#import "LeyendaModel.h"

@interface LugarGridViewController ()
@property (strong, nonatomic) NSArray *photosList;
@property (strong, nonatomic) NSMutableDictionary *photosCache;
@property (strong, nonatomic) LeyendaModel *leyendaModel;
- (IBAction)returnHomePage:(id)sender;
@end

@implementation LugarGridViewController

-(NSString*) photosDirectory {
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Photos/Lugares"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSArray * photosArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[self photosDirectory] error:nil];
    self.photosCache = [NSMutableDictionary dictionary];
    self.photosList = nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photosList = photosArray;
            [self.collectionView reloadData];
        });
    });
    
    self.title = @"Lugares";
    self.navigationItem.hidesBackButton = false;
    
    
    UIBarButtonItem *btn=[[UIBarButtonItem alloc]init];
    btn.title=@"Back";
    self.navigationItem.backBarButtonItem=btn;
    self.navigationController.navigationItem.backBarButtonItem = btn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *) collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *) collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photosList count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *) collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LeyendaPhotoCell *cell = (LeyendaPhotoCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    NSString *photoName = [self.photosList objectAtIndex:indexPath.row];
    
    NSString *photoFilePath = [[self photosDirectory] stringByAppendingPathComponent:photoName];
    
    cell.nameLabel.text =[photoName stringByDeletingPathExtension];
    
    __block UIImage* thumbImage = [self.photosCache objectForKey:photoName];
    cell.photoView.image = thumbImage;
    
    if(!thumbImage) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            UIImage *image = [UIImage imageWithContentsOfFile:photoFilePath];
            
            UIGraphicsBeginImageContext(CGSizeMake(128.0f, 128.0f));
            
            [image drawInRect:CGRectMake(0, 0, 128.0f, 128.0f)];
            
            thumbImage = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.photosCache setObject:thumbImage forKey:photoName];
                cell.photoView.image = thumbImage;
            });
        });
    }
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UICollectionReusableView *)collectionView:(UICollectionView*)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *SupplementaryViewIdentifier = @"LegendHeader";
    
    return [collectionView
            
            dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
            
            withReuseIdentifier:SupplementaryViewIdentifier
            
            forIndexPath:indexPath];
    
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"detailLeyendSegue" sender:indexPath];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *selectedIndexPath = sender;
    
    NSString *photoName = [self.photosList objectAtIndex:selectedIndexPath.row];
    
    NSString *photoNameSimple = [[photoName componentsSeparatedByString:@"."] objectAtIndex:0];
    
    NSMutableString *locationKey = [NSMutableString stringWithString:photoNameSimple];
    [locationKey appendString:@"Coord"];
    
    
    NSLog(@"%@", locationKey);
    
    NSString* finish = [[locationKey componentsSeparatedByCharactersInSet:[[NSCharacterSet letterCharacterSet] invertedSet]] componentsJoinedByString:@""];
    
    NSLog(@"finish %@", finish);
    
    
    NSString *leyendaText = NSLocalizedString(photoNameSimple, @"");
    NSString *leyendaLocation = NSLocalizedStringFromTable(locationKey, @"Coordinates", @"");
    //NSString *leyendaLocation = NSLocalizedString(locationKey, @"");
    
    CLLocationCoordinate2D location;
    
    if (leyendaLocation != locationKey) {
        NSString *latitude = [[leyendaLocation componentsSeparatedByString:@","] objectAtIndex:0];
        NSString *longitude = [[leyendaLocation componentsSeparatedByString:@","] objectAtIndex:1];
        
        NSLog(@"%@",leyendaLocation);
        NSLog(@"%@",latitude);
        NSLog(@"%@",longitude);
        
        location = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
    } else {
        location = CLLocationCoordinate2DMake(20.675672, -103.348861);
    }
    
    LeyendaDetailViewController *controller = segue.destinationViewController;
    
    controller.leyendaModel = [[LeyendaModel alloc] initWithDescription:leyendaText title:photoNameSimple location:location];
    //controller.photoPath = [[self photosDirectory] stringByAppendingPathComponent:photoName];
}

- (IBAction)returnHomePage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
