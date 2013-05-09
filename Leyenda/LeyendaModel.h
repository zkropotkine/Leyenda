//
//  LeyendaModel.h
//  Leyenda
//
//  Created by Daniel Rodriguez on 2/28/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeyendaModel : NSObject
@property(strong, nonatomic) NSString *description;
@property(strong, nonatomic) NSString *title;

-(id)initWithDescription:(NSString *)descr title:(NSString *)title;
@end
