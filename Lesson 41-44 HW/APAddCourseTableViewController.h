//
//  APAddCourseTableViewController.h
//  Lesson 41-44 HW
//
//  Created by Alex on 29.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "APCoreDataViewController.h"

@class APCourses;

@interface APAddCourseTableViewController : APCoreDataViewController

@property (strong, nonatomic) APCourses* course;

- (IBAction)cancelBarButtonAction:(UIBarButtonItem *)sender;

- (IBAction)saveBarButtonAction:(UIBarButtonItem *)sender;

@end
