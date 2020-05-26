//
//  Object+CoreDataClass.m
//  objC_CoreData
//
//  Created by kluv on 26/05/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//
//

#import "Object+CoreDataClass.h"

@implementation Object

- (BOOL)validateForDelete:(NSError *__autoreleasing  _Nullable *)error {
    
    NSLog(@"%@ validate for delete", NSStringFromClass([self class]));
    
    return YES;
    
}

@end
