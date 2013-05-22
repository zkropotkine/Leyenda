//
//  LeyendaModel.h
//  Leyenda
//
//  Created by Daniel Rodriguez on 2/28/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LeyendaModel : NSObject
@property(strong, nonatomic) NSString *description;
@property(strong, nonatomic) NSString *title;
@property(assign, nonatomic) CLLocationCoordinate2D location;

-(id)initWithDescription:(NSString *)descr title:(NSString *)title location:(CLLocationCoordinate2D)location;
@end
