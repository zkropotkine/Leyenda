//
//  Displaying_Pins_on_a_Map_ViewViewController.m
//  Leyenda
//
//  Created by Daniel Rodriguez on 1/13/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import "Displaying_Pins_on_a_Map_ViewViewController.h"
#import "MyAnnonation.h"

@interface Displaying_Pins_on_a_Map_ViewViewController ()

@end

@implementation Displaying_Pins_on_a_Map_ViewViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    /* Create a map as big as our view */
    self.myMapView = [[MKMapView alloc]
                      initWithFrame:self.view.bounds];
    
    
    //self.myMapView.delegate = self;
    /* Set the map type to Standard */
    self.myMapView.mapType = MKMapTypeStandard;
    self.myMapView.showsUserLocation=YES;
    
    self.myMapView.autoresizingMask =
    UIViewAutoresizingFlexibleWidth |
    UIViewAutoresizingFlexibleHeight;
    
    /* Add it to our view */
    [self.view addSubview:self.myMapView];
    
    /* This is just a sample location */
    CLLocationCoordinate2D location =
    CLLocationCoordinate2DMake(50.82191692907181, -0.13811767101287842);
    
    /* Create the annotation using the location */
    MyAnnonation *annotation =
    [[MyAnnonation alloc] initWithCoordinates:location
                                        title:@"My Title"
                                     subTitle:@"My Sub Title"];
    
    /* And eventually add it to the map */
    [self.myMapView addAnnotation:annotation];
    
    
    if ([CLLocationManager locationServicesEnabled]){
        self.myLocationManager = [[CLLocationManager alloc] init];
        self.myLocationManager.delegate = self;
        
        self.myLocationManager.purpose = @"To provide functionality based on user's current location.";
        [self.myLocationManager startUpdatingLocation];
        NSLog(@"Deberia de jalar");
    } else {
        /* Location services are not enabled.
         Take appropriate action: for instance, prompt the
         user to enable location services */
        NSLog(@"Location services are not enabled");
    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation
:(UIInterfaceOrientation)interfaceOrientation{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [locations lastObject];
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation{
    
    /* We received the new location */
    
    NSLog(@"Latitude = %f", newLocation.coordinate.latitude);
    NSLog(@"Longitude = %f", newLocation.coordinate.longitude);
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];

}

@end
