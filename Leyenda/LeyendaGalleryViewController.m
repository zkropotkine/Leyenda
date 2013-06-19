//
//  LeyendaGalleryViewController.m
//  Leyenda
//
//  Created by Daniel Rodriguez on 6/5/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import "LeyendaGalleryViewController.h"
#import "LeyendaPhotoCell.h"
#import "LeyendaGalleryDetailViewController.h"
#import "LeyendaModel.h"
#import "LeyendaCollectionHeaderView.h"

@interface LeyendaGalleryViewController ()
@property (strong, nonatomic) NSArray *photosList;
@property (strong, nonatomic) NSMutableDictionary *photosCache;
@property (strong, nonatomic) LeyendaModel *leyendaModel;
- (IBAction)returnHomePage:(id)sender;
@end

@implementation LeyendaGalleryViewController

-(NSString*) photosDirectory {
    return [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Photos/Galeria"];
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
    NSArray *photosToShow = [photosArray filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self beginswith[c] '1_'"]];
    
    
    self.photosCache = [NSMutableDictionary dictionary];
    self.photosList = nil;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.photosList = photosToShow;
            [self.collectionView reloadData];
        });
    });
    
    self.title = @"Galleria";
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
    cell.nameLabel.font = [UIFont boldSystemFontOfSize:13.0];
    cell.nameLabel.numberOfLines = 0;
    
    __block UIImage* thumbImage = [self.photosCache objectForKey:photoName];
    cell.photoView.image = thumbImage;
    
    if(!thumbImage) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            
            UIImage *image = [UIImage imageWithContentsOfFile:photoFilePath];
            
            UIGraphicsBeginImageContext(CGSizeMake(150.0f, 150.0f));
            
            [image drawInRect:CGRectMake(0, 0, 150.0f, 150.0f)];
            
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

}

- (IBAction)returnHomePage:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

