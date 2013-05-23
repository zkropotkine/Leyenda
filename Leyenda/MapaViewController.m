//
//  MapaViewController.m
//  Leyenda
//
//  Created by Daniel Rodriguez on 5/22/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import "MapaViewController.h"

@interface MapaViewController ()
- (IBAction)returnHomePage:(id)sender;
@end

@implementation MapaViewController

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

- (IBAction)returnHomePage:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
