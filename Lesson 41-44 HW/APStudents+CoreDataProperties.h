//
//  APStudents+CoreDataProperties.h
//  Lesson 41-44 HW
//
//  Created by Alex on 29.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "APStudents.h"

NS_ASSUME_NONNULL_BEGIN

@interface APStudents (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSSet<APCourses *> *courses;

@end

@interface APStudents (CoreDataGeneratedAccessors)

- (void)addCoursesObject:(APCourses *)value;
- (void)removeCoursesObject:(APCourses *)value;
- (void)addCourses:(NSSet<APCourses *> *)values;
- (void)removeCourses:(NSSet<APCourses *> *)values;

@end

NS_ASSUME_NONNULL_END
