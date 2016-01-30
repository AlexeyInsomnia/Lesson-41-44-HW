//
//  APAddStudentTableViewController.h
//  Lesson 41-44 HW
//
//  Created by Alex on 29.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>


@class APStudents;



@interface APAddStudentTableViewController : UITableViewController

@property (strong, nonatomic) APStudents* student;




- (IBAction)cancelBarButtonAction:(UIBarButtonItem *)sender;

- (IBAction)saveBarButtonAction:(UIBarButtonItem *)sender;

@end

