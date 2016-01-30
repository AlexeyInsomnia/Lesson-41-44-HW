//
//  APCoreDataViewController.h
//  Lesson 41-44 HW
//
//  Created by Alex on 29.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "APSharedManager.h"


@interface APCoreDataViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext* managedObjectContext;

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;



@end
