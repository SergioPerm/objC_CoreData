//
//  Student+CoreDataProperties.h
//  objC_CoreData
//
//  Created by kluv on 21/05/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSDate *dateBirth;
@property (nonatomic) float score;

@end

NS_ASSUME_NONNULL_END
