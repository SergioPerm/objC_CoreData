//
//  University+CoreDataProperties.m
//  objC_CoreData
//
//  Created by kluv on 26/05/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "University+CoreDataProperties.h"

@implementation University (CoreDataProperties)

+ (NSFetchRequest<University *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"University"];
}

@dynamic name;
@dynamic students;
@dynamic courses;

@end
