//
//  LeyendaDetailViewController.h
//  Leyenda
//
//  Created by Daniel Rodriguez on 2/4/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeyendaModel.h"

@interface LeyendaDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UINavigationItem *leyendaTitle;
@property (strong, nonatomic) IBOutlet UITextView *leyendaText;
@property (strong, nonatomic) NSString *photoPath;
@property (strong, nonatomic) LeyendaModel *leyendaModel;

-(IBAction)galleryAction:(id)sender;
-(IBAction)locationAction:(id)sender;
@end
