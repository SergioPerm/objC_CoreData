//
//  Student+CoreDataProperties.m
//  objC_CoreData
//
//  Created by kluv on 26/05/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic dateBirth;
@dynamic firstName;
@dynamic lastName;
@dynamic score;
@dynamic studentCar;
@dynamic university;
@dynamic course;

@end
