//
//  LeyendaGalleryViewController.h
//  Leyenda
//
//  Created by Daniel Rodriguez on 6/5/13.
//  Copyright (c) 2013 Daniel Rodriguez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeyendaModel.h"

@interface LeyendaGalleryViewController : UICollectionViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) LeyendaModel *leyendaModel;
//@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end