//
//  Car+CoreDataProperties.h
//  objC_CoreData
//
//  Created by kluv on 26/05/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "Car+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Car (CoreDataProperties)

+ (NSFetchRequest<Car *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *model;
@property (nullable, nonatomic, retain) Student *owner;

@end

NS_ASSUME_NONNULL_END
