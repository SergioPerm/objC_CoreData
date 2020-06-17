//
//  DataManager.h
//  objC_CoreData
//
//  Created by kluv on 08/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

+(DataManager*) shareManager;

-(void)generateAndAddUniversity;
-(void)printAllObjects;

@end

NS_ASSUME_NONNULL_END
