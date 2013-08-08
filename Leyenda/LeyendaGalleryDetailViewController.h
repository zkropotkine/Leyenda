//
//  LeyendaGalleryDetailViewController.h
//  Leyenda
//
//  Created by Daniel Rodriguez on 6/19/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeyendaModel.h"

@interface LeyendaGalleryDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UINavigationItem *leyendaTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSString *photoPath;
@property (strong, nonatomic) LeyendaModel *leyendaModel;
@end
