//
//  LeyendaDetailViewController.m
//  Leyenda
//
//  Created by Daniel Rodriguez on 2/4/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import "LeyendaDetailViewController.h"
#import "Displaying_Pins_on_a_Map_ViewViewController.h"

@interface LeyendaDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LeyendaDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.leyendaText.text = self.leyendaModel.description;
    self.leyendaTitle.title = self.leyendaModel.title;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"mapDetailSegue" sender:indexPath];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {    
    Displaying_Pins_on_a_Map_ViewViewController *controller = segue.destinationViewController;
    
    controller.location = self.leyendaModel.location;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

@end