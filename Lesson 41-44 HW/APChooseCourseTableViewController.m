//
//  APChooseCourseTableViewController.m
//  Lesson 41-44 HW
//
//  Created by Alex on 29.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "APChooseCourseTableViewController.h"
#import "APStudents.h"
#import "APCourses.h"
#import "APTeachers.h"

@interface APChooseCourseTableViewController ()

@end

@implementation APChooseCourseTableViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    [self.tableView setEditing:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Methods

- (NSString*) entityName:(APDataType)dataType {
    if (self.typeEntity == APStudentsType) {
        return @"APStudents";
        
    } else if (self.typeEntity == APCoursesType) {
        return @"APCourses";
        
    } else if (self.typeEntity == APTeachersType) {
        return @"APTeachers";
        
    }
    return nil;
    
}


- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:[self entityName:self.typeEntity]
                                                   inManagedObjectContext:self.managedObjectContext];
    
    
    [fetchRequest setEntity:description];
    
    if (self.typeEntity != APCoursesType) {
        NSSortDescriptor* firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
        NSSortDescriptor* lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
        [fetchRequest setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
        
    } else {
        NSSortDescriptor* name = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        [fetchRequest setSortDescriptors:@[name]];
        
    }
    
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                managedObjectContext:self.managedObjectContext
                                                                                                  sectionNameKeyPath:nil
                                                                                                           cacheName:nil];
    
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
        
    }
    return _fetchedResultsController;
    
}



#pragma mark - UITableViewDataSource


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    if (self.typeEntity == APStudentsType) {
        APStudents* student = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        
        APCourses* course = self.data;
        if ([[course students] containsObject:student]) {
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
            
        }
        
    } else if (self.typeEntity == APCoursesType) {
        APCourses* course = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.textLabel.text = course.name;
        APStudents* student = self.data;
        
        if ([[student courses] containsObject:course]) {
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
            
        }
        
    } else if (self.typeEntity == APTeachersType) {
        APTeachers* teacher = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", teacher.firstName, teacher.lastName];
        APCourses* course = self.data;
        
        if ([[course teacher] isEqual:teacher]) {
            [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
            
        }
    }
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.typeEntity == APTeachersType) {
        if ([[self.tableView indexPathsForSelectedRows] count] == 2) {
            [tableView deselectRowAtIndexPath:[[self.tableView indexPathsForSelectedRows] firstObject] animated:YES];
            
        }
    }
}



#pragma mark - Actions




- (IBAction)cancelBarButtonAction:(UIBarButtonItem *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)savebarButtonAction:(UIBarButtonItem *)sender {
    
    NSArray* selectedRowsArray = [self.tableView indexPathsForSelectedRows];
    NSMutableArray* selectedItems = [NSMutableArray new];
    
    for (NSIndexPath* numberSelectionRow in selectedRowsArray) {
        [selectedItems addObject:[self.fetchedResultsController objectAtIndexPath:numberSelectionRow]];
        
    }
    [self.delegate chooseDataArray:selectedItems andType:self.typeEntity];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
