//
//  Object+CoreDataProperties.h
//  objC_CoreData
//
//  Created by kluv on 26/05/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "Object+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Object (CoreDataProperties)

+ (NSFetchRequest<Object *> *)fetchRequest;


@end

NS_ASSUME_NONNULL_END
