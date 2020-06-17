//
//  Course+CoreDataProperties.h
//  objC_CoreData
//
//  Created by kluv on 02/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "Course+CoreDataClass.h"
#import "University+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Course (CoreDataProperties)

+ (NSFetchRequest<Course *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Student *> *students;
@property (nullable, nonatomic, retain) University *university;
@property (nullable, nonatomic, retain) NSArray *bestStudents;
@property (nullable, nonatomic, retain) NSArray *studentsWithmanyCourses;

@end

@interface Course (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet<Student *> *)values;
- (void)removeStudents:(NSSet<Student *> *)values;

@end

NS_ASSUME_NONNULL_END
