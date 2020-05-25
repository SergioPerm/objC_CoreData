//
//  Student+CoreDataProperties.m
//  objC_CoreData
//
//  Created by kluv on 21/05/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Student"];
}

@dynamic firstName;
@dynamic lastName;
@dynamic dateBirth;
@dynamic score;

@end
