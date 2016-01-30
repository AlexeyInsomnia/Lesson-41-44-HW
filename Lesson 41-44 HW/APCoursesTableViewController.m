//
//  APCoursesTableViewController.m
//  Lesson 41-44 HW
//
//  Created by Alex on 30.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//

#import "APCoursesTableViewController.h"
#import "APCourses.h"
#import "APAddCourseTableViewController.h"

@interface APCoursesTableViewController ()

@end

@implementation APCoursesTableViewController

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
    NSEntityDescription* description = [NSEntityDescription entityForName:@"APCourses"
                                                   inManagedObjectContext:self.managedObjectContext];
    
    [fetchRequest setEntity:description];
    NSSortDescriptor* nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:@[nameDescriptor]];
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
    
    APCourses* course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [super configureCell:cell atIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", course.name];
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", ]
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    APAddCourseTableViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"APAddCourseTableViewController"];
    
    APCourses *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    vc.course = course;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}




- (IBAction)addBarButtonAction:(UIBarButtonItem *)sender {
    
    APAddCourseTableViewController *vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"APAddCourseTableViewController"];
    
    [self.navigationController pushViewController:vc animated:YES];
}
 
 
@end
 
