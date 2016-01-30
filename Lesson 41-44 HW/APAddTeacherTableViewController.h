//
//  APAddTeacherTableViewController.h
//  Lesson 41-44 HW
//
//  Created by Alex on 30.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "APCoreDataViewController.h"

@class APTeachers;

@interface APAddTeacherTableViewController : APCoreDataViewController


@property (strong, nonatomic) APTeachers* teacher;

- (IBAction)cancelBarButtonAction:(UIBarButtonItem *)sender;
- (IBAction)saveBarButtonAction:(UIBarButtonItem *)sender;

@end
