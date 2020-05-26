//
//  Student+CoreDataProperties.h
//  objC_CoreData
//
//  Created by kluv on 26/05/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "Student+CoreDataClass.h"
#import "Car+CoreDataClass.h"
#import "University+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *dateBirth;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nonatomic) float score;
@property (nullable, nonatomic, retain) Car *studentCar;
@property (nullable, nonatomic, retain) University *university;

@end

NS_ASSUME_NONNULL_END
