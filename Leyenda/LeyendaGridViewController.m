//
//  LeyendaGridViewController.m
//  Leyenda
//
//  Created by Daniel Rodriguez on 2/4/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import "LeyendaGridViewController.h"
#import "LeyendaPhotoCell.h"
#import "LeyendaDetailViewController.h"
#import "LeyendaModel.h"
#import "LeyendaCollectionHeaderView.h"

@interface LeyendaGridViewController ()
@property (strong, nonatomic) NSArray *photosList;
@property (strong, nonatomic) NSMutableDictionary *photosCache;
@property (strong, nonatomic) LeyendaModel *leyendaModel;
- (IBAction)returnHomePage:(id)sender;
@end

@implementation LeyendaGridViewController

-(NSString*) photosDirectory {
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Photos/Leyendas"];
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
    
    self.title = @"Leyendas";
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
    
    NSString *string = [photoName stringByDeletingPathExtension];
    
    NSLog(@"string == %@", string);
    
    NSRange rangeToSearch = NSMakeRange(0, [string length]); // get a range without the space character
    NSRange rangeOfSecondToLastSpace = [string rangeOfString:@" " options:NSBackwardsSearch range:rangeToSearch];
    
    if (rangeOfSecondToLastSpace.length > 0 && rangeOfSecondToLastSpace.location < rangeToSearch.length) {
        NSString *spaceReplacement = @"\n";
        NSString *result = [string stringByReplacingCharactersInRange:rangeOfSecondToLastSpace withString:spaceReplacement];
    
        NSLog(@"replacedString == %@", result);
        
        string = result;
    }

    cell.nameLabel.text = string;
    //cell.nameLabel.font = [UIFont fontWithName:@"GeezaPro-Bold" size:13.0];
    cell.nameLabel.font = [UIFont boldSystemFontOfSize:13.0];
    cell.nameLabel.numberOfLines = 0;
        
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
    
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Frame.png"]];
    
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UICollectionReusableView *)collectionView:(UICollectionView*)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *SupplementaryViewIdentifier = @"HeaderView";
    
    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                           withReuseIdentifier:SupplementaryViewIdentifier forIndexPath:indexPath];
    
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"detailLeyendSegue" sender:indexPath];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *selectedIndexPath = sender;
    
    NSString *photoName = [self.photosList objectAtIndex:selectedIndexPath.row];

    NSString *photoNameSimple = [[photoName componentsSeparatedByString:@"."] objectAtIndex:0];
    
    NSData *data = [photoNameSimple dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *cleanPhotoName = [[[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding] stringByReplacingOccurrencesOfString:@"?" withString:@""];
    NSLog(@"%@", cleanPhotoName);
    
    NSMutableString *locationKey = [NSMutableString stringWithString:cleanPhotoName];
    [locationKey appendString:@"Coord"];
    
    NSLog(@"%@", locationKey);
    
    NSString *leyendaText = NSLocalizedString(cleanPhotoName, @"");
    NSString *leyendaLocation = NSLocalizedStringFromTable(locationKey, @"Coordinates", @"");

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
}

- (IBAction)returnHomePage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
