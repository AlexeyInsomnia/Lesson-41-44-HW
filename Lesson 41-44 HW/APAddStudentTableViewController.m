//
//  APAddStudentTableViewController.m
//  Lesson 41-44 HW
//
//  Created by Alex on 29.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "APAddStudentTableViewController.h"
#import "APStudents.h"
#import "APSharedManager.h"
#import "APChooseCourseTableViewController.h"

@interface APAddStudentTableViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, APChooseCourseTableViewControllerDelegate>

@property (strong, nonatomic) UITextField* firstNameTextField;
@property (strong, nonatomic) UITextField* lastNameTextField;
@property (strong, nonatomic) UITextField* emailTextField;



@end

@implementation APAddStudentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)]; [self.tableView addGestureRecognizer:gestureRecognizer];*/
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.firstNameTextField = [self createTextField:UIReturnKeyNext andWithKeyboardType:UIKeyboardTypeDefault];
    self.lastNameTextField = [self createTextField:UIReturnKeyNext andWithKeyboardType:UIKeyboardTypeDefault];
    self.emailTextField = [self createTextField:UIReturnKeyDone andWithKeyboardType:UIKeyboardTypeEmailAddress];
    self.firstNameTextField.delegate = self;
    self.lastNameTextField.delegate = self;
    self.emailTextField.delegate = self;
    
    if (self.student != nil) {
        self.firstNameTextField.text = self.student.firstName;
        self.lastNameTextField.text = self.student.lastName;
        self.emailTextField.text = self.student.email;
        
    } else {
        self.student = [NSEntityDescription insertNewObjectForEntityForName:@"APStudents"
                                                     inManagedObjectContext:[[APSharedManager sharedManager] managedObjectContext]];
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
        
    } else {
        return [[self.student courses] count] + 1;
        
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"User info";
        
    } else  {
        return @"User courses";
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* indentifier = @"Cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
    }
    
    UILabel* label = [[UILabel alloc] init];
    label.frame = CGRectMake(10, 6, 100, 30);
    label.font = [UIFont fontWithName:@"Avenir" size:17.f];
    label.textColor = UIColorFromRGB(0x5c6f7a);
    label.textAlignment = NSTextAlignmentRight;
    
    if (indexPath.section == 0 && indexPath.row == 0 ) {
        label.text = @"First name";
        
        [cell addSubview:label];
        [cell addSubview:self.firstNameTextField];
        
    } else if (indexPath.section == 0 && indexPath.row == 1 ) {
        label.text = @"Last name";
        
        [cell addSubview:label];
        [cell addSubview:self.lastNameTextField];
        
    } else if (indexPath.section == 0 && indexPath.row == 2 ) {
        label.text = @"Email";
        
        [cell addSubview:label];
        [cell addSubview:self.emailTextField];
        
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = @"Add course";
        
    } else if (indexPath.section == 1) {
        NSArray* tempArray = [[self.student courses] allObjects];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [[tempArray objectAtIndex:indexPath.row - 1] name]];
        
    }
    return cell;
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return NO;
        
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        return NO;
        
    } else {
        return YES;
        
    }
}

//?
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (indexPath.section == 1 && indexPath.row != 0) {
            
            NSArray *tempArray = [self.student.courses allObjects];
            NSMutableArray *tempMutableArray = [NSMutableArray arrayWithArray:tempArray];
            [tempMutableArray removeObject:[tempArray objectAtIndex:indexPath.row - 1]];
            
            [self.student setCourses:[NSSet setWithArray:tempMutableArray]];
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
        }
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        NSLog(@"pressed 1 row");
        APChooseCourseTableViewController* vc = [[self storyboard] instantiateViewControllerWithIdentifier:@"APChooseCourseTableViewController"];
        vc.delegate = self;
        vc.data = self.student;
        vc.typeEntity = APCoursesType;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}





# pragma mark - Actions

- (IBAction)cancelBarButtonAction:(UIBarButtonItem *)sender {
    
    [[[APSharedManager sharedManager] managedObjectContext] rollback];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)saveBarButtonAction:(UIBarButtonItem *)sender {
    
    self.student.firstName = self.firstNameTextField.text;
    self.student.lastName = self.lastNameTextField.text;
    self.student.email = self.emailTextField.text;
    
    NSError* error = nil;
    
    if (![[[APSharedManager sharedManager] managedObjectContext] save:&error]) {
        NSLog(@"%@", [error localizedDescription]);
        
    } else {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}


#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.firstNameTextField) {
        [self.lastNameTextField becomeFirstResponder];
        
    } else if (textField == self.lastNameTextField)  {
        [self.emailTextField becomeFirstResponder];
        
    } else {
        [textField resignFirstResponder];
        
    }
    return YES;
}



#pragma mark - APChooseCourseTableViewControllerDelegate

- (void) chooseDataArray:(NSMutableArray*)datatArray andType:(APDataType)entityType {
    
    if (entityType == APCoursesType) {
        [self.student setCourses:[NSSet setWithArray:datatArray]];
        
    }
    [self.tableView reloadData];
    
}



#pragma mark - Methods


- (UITextField*) createTextField:(UIReturnKeyType)ReturnKeyType andWithKeyboardType:(UIKeyboardType)keyboardType {
    UITextField* textField = [[UITextField alloc]init];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.returnKeyType = ReturnKeyType;
    textField.keyboardType = keyboardType;
    textField.frame = CGRectMake(130, 7, 220, 30);
    
    return textField;
    
}


/*- (void) hideKeyboard {
 [self.firstNameTextField resignFirstResponder];
 [self.lastNameTextField resignFirstResponder];
 [self.emailTextField resignFirstResponder];
 
 }*/

- (void) dealloc {
    NSLog(@"APAddStudentTableTableViewController deallocated");
    
}

@end
