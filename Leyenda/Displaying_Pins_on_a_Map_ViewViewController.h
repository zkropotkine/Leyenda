//
//  Displaying_Pins_on_a_Map_ViewViewController.h
//  Leyenda
//
//  Created by Daniel Rodriguez on 1/13/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "LeyendaModel.h"

@interface Displaying_Pins_on_a_Map_ViewViewController : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet MKMapView *myMapView;
@property (strong, nonatomic) CLLocationManager *myLocationManager;
@property(assign, nonatomic) CLLocationCoordinate2D location;

@end
