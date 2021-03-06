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
- (IBAction)returnHomePage:(id)sender;
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
    
    NSLog(@"User's latitude is: %f", self.location.latitude );
    NSLog(@"User's longitude is: %f", self.location.longitude );
    
    
    CLLocationCoordinate2D maplocation;
    if (self.location.latitude != 0 && self.location.longitude != 0) {
        maplocation = self.location;
    
        /* Create the annotation using the location */
        MyAnnonation *annotation =
        [[MyAnnonation alloc] initWithCoordinates:maplocation
                                            title:@"My Title"
                                         subTitle:@"My Sub Title"];
        
        /* And eventually add it to the map */
        [self.myMapView addAnnotation:annotation];
    } else {
        NSString *stringsPath = [[NSBundle mainBundle] pathForResource:@"Coordinates" ofType:@"strings"];
        NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:stringsPath];
        NSMutableArray *annotations = [[NSMutableArray alloc] init];
        
        for(id key in dictionary) {
            NSString *keyName = key;
            NSString *location = [dictionary objectForKey:key];
            NSLog(@"key=%@ value=%@", keyName, location);
            
            NSString *locationName = [[keyName componentsSeparatedByString:@"Coord"] objectAtIndex:0];
            NSString *latitude = [[location componentsSeparatedByString:@","] objectAtIndex:0];
            NSString *longitude = [[location componentsSeparatedByString:@","] objectAtIndex:1];
            
            NSLog(@"%@",latitude);
            NSLog(@"%@",longitude);
            
            maplocation = CLLocationCoordinate2DMake([latitude doubleValue], [longitude doubleValue]);
            
            MyAnnonation *annotation =
            [[MyAnnonation alloc] initWithCoordinates:maplocation
                                                title:locationName
                                                subTitle:locationName];
            
            [annotations addObject:annotation];
        }
        
        /* And eventually add it to the map */
        [self.myMapView addAnnotations:annotations];
    }
    
    
    if ([CLLocationManager locationServicesEnabled]){
        self.myLocationManager = [[CLLocationManager alloc] init];
        self.myLocationManager.delegate = self;
        
        [self.myLocationManager startUpdatingLocation];
        // 500 meters x 500 meters
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(maplocation, 500, 500);
        MKCoordinateRegion adjustedRegion = [self.myMapView regionThatFits:viewRegion];
        [self.myMapView setRegion:adjustedRegion animated:YES];
        self.myMapView.showsUserLocation = YES;
        NSLog(@"Deberia de jalar");
    } else {
        /* Location services are not enabled.
         Take appropriate action: for instance, prompt the
         user to enable location services */
        NSLog(@"Location services are not enabled");
    }
    
    self.title = @"Mapa";
    self.navigationItem.hidesBackButton = false;
    
    UIBarButtonItem *btn=[[UIBarButtonItem alloc]init];
    btn.title=@"Back";
    
    self.navigationItem.backBarButtonItem=btn;
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


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    /* We received the new location */
    
    NSLog(@"Latitude = %f", newLocation.coordinate.latitude);
    NSLog(@"Longitude = %f", newLocation.coordinate.longitude);
    
    
    CLLocationCoordinate2D newcordinate =   CLLocationCoordinate2DMake(20.715336, -103.36146);
    CLLocationCoordinate2D oldcordinate =   CLLocationCoordinate2DMake(20.718869,-103.360675);
    
    MKMapPoint * pointsArray =
    malloc(sizeof(CLLocationCoordinate2D)*2);
    
    pointsArray[0]= MKMapPointForCoordinate(oldcordinate);
    pointsArray[1]= MKMapPointForCoordinate(newcordinate);
    
    MKPolyline *  routeLine = [MKPolyline polylineWithPoints:pointsArray count:2];
    free(pointsArray);
    
    [self.myMapView addOverlay:routeLine]; 
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];

}

- (IBAction)returnHomePage:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
