//
//  APChooseCourseTableViewController.h
//  Lesson 41-44 HW
//
//  Created by Alex on 29.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "APCoreDataViewController.h"
typedef enum {
    APStudentsType,
    APCoursesType,
    APTeachersType
    
} APDataType;

@protocol APChooseCourseTableViewControllerDelegate;

@interface APChooseCourseTableViewController : APCoreDataViewController

@property (weak, nonatomic) id <APChooseCourseTableViewControllerDelegate> delegate;
@property (strong, nonatomic) id data;
@property (assign, nonatomic) APDataType typeEntity;

- (IBAction)cancelBarButtonAction:(UIBarButtonItem *)sender;

- (IBAction)savebarButtonAction:(UIBarButtonItem *)sender;

@end


@protocol APChooseCourseTableViewControllerDelegate

- (void) chooseDataArray:(NSMutableArray*)datatArray andType:(APDataType)entityType;

@end
