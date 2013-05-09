//
//  MKViewController.m
//  Leyenda
//
//  Created by Daniel Rodriguez on 2/4/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import "MKViewController.h"
#import "LeyendaPhotoCell.h"

@interface MKViewController ()

@end

@implementation MKViewController

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
	// Do any additional setup after loading the view.
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
    return 100;
}

// The cell that is returned must be retrieved from a call to

// -dequeueReusableCellWithReuseIdentifier:forIndexPath:

- (UICollectionViewCell *)collectionView:(UICollectionView *)

collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    LeyendaPhotoCell *cell = (LeyendaPhotoCell*)
    
    [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell"
     
                                              forIndexPath:indexPath];
    
    return cell;
    
}

@end
