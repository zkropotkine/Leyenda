//
//  LeyendaAppDelegate.h
//  Leyenda
//
//  Created by Daniel Rodriguez on 1/12/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeyendaAppDelegate : UIResponder <UIApplicationDelegate>
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) UIWindow *window;

@end
