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
    //self.leyendaText.text = self.leyendaModel.description;
    self.leyendaTitle.title = self.leyendaModel.title;
    
    NSArray* paragraphs = [self.leyendaModel.description componentsSeparatedByString: @"\n\n"];

    NSMutableAttributedString *formatedText = [[NSMutableAttributedString alloc] init];
    
    for (NSString *paragrahp in paragraphs) {
        UIColor *_black=[UIColor blackColor];
        UIFont *font=[UIFont fontWithName:@"Helvetica-Bold" size:20.0f];
        
        NSMutableAttributedString *formatedParagraph=[[NSMutableAttributedString alloc] initWithString:paragrahp];
        
        [formatedParagraph addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, 1)];
        [formatedParagraph addAttribute:NSForegroundColorAttributeName value:_black range:NSMakeRange(0, 1)];
        [formatedParagraph appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@"\n\n"]];
        
        [formatedText appendAttributedString:formatedParagraph];
    }
    
    self.leyendaText.attributedText = formatedText;
    
    UIBarButtonItem *ubicacion = [[UIBarButtonItem alloc] initWithTitle:@"Ubicacíon" style:UIBarButtonSystemItemDone target:self action:@selector(locationAction:)];
    
    UIBarButtonItem *gallery = [[UIBarButtonItem alloc] initWithTitle:@"Gallería" style:UIBarButtonSystemItemDone target:self action:@selector(galleryAction:)];
    
    
    NSArray *buttons = [[NSArray alloc] initWithObjects:ubicacion, gallery, nil];
    
    self.navigationItem.rightBarButtonItems = buttons;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"mapDetailSegue" sender:indexPath];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%@", NSStringFromClass([[segue destinationViewController] class]));
    NSLog(@"%@", [segue identifier]);

    
    if ([[segue identifier] isEqualToString:@"locationSegue"]) {
        Displaying_Pins_on_a_Map_ViewViewController *controller = segue.destinationViewController;
        controller.location = self.leyendaModel.location;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

-(IBAction)galleryAction:(id)sender {
    NSLog(@"Gallery Action");
    [self performSegueWithIdentifier:@"holaSegue" sender:self];
}

-(IBAction)locationAction:(id)sender {
    NSLog(@"Location Action");
    [self performSegueWithIdentifier:@"locationSegue" sender:self];
}

@end