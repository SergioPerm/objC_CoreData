//
//  Object+CoreDataProperties.m
//  objC_CoreData
//
//  Created by kluv on 26/05/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "Object+CoreDataProperties.h"

@implementation Object (CoreDataProperties)

+ (NSFetchRequest<Object *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"Object"];
}


@end
