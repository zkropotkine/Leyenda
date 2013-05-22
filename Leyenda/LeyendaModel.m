//
//  LeyendaModel.m
//  Leyenda
//
//  Created by Daniel Rodriguez on 2/28/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import "LeyendaModel.h"

@implementation LeyendaModel

-(id)initWithDescription:(NSString *)descr title:(NSString *)title location:(CLLocationCoordinate2D)location
{
    self = [super init];
    if (self)
    {
        self.description = descr;
        self.title = title;
        self.location = location;
    }
    return self;
}


@end
