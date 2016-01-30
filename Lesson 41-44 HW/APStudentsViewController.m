//
//  APStudentsViewController.m
//  Lesson 41-44 HW
//
//  Created by Alex on 29.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "APStudentsViewController.h"
#import "APStudents.h"
#import "APAddStudentTableViewController.h"

@interface APStudentsViewController ()

@end

@implementation APStudentsViewController
@synthesize fetchedResultsController = _fetchedResultsController;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"APStudents"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    NSSortDescriptor* firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor* lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    [fetchRequest setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
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
    
    APStudents* student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [super configureCell:cell atIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    APAddStudentTableViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"APAddStudentTableViewController"];
    
    APStudents *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    vc.student = student;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Actions

- (IBAction)addStudentAction:(UIBarButtonItem *)sender {
    
    
    APAddStudentTableViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"APAddStudentTableViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
     
     
    
}
@end
