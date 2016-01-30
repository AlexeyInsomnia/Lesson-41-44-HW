//
//  APCourses+CoreDataProperties.h
//  Lesson 41-44 HW
//
//  Created by Alex on 29.01.16.
//  Copyright © 2016 Alex. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "APCourses.h"

NS_ASSUME_NONNULL_BEGIN

@interface APCourses (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *industry;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *object;
@property (nullable, nonatomic, retain) NSSet<APStudents *> *students;
@property (nullable, nonatomic, retain) APTeachers *teacher;

@end

@interface APCourses (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(APStudents *)value;
- (void)removeStudentsObject:(APStudents *)value;
- (void)addStudents:(NSSet<APStudents *> *)values;
- (void)removeStudents:(NSSet<APStudents *> *)values;

@end

NS_ASSUME_NONNULL_END
