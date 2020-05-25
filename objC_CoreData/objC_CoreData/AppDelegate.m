//
//  AppDelegate.m
//  objC_CoreData
//
//  Created by kluv on 21/05/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "AppDelegate.h"
#import "Student+CoreDataClass.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (NSArray *)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"names" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (NSDate *)generateRandomDateWithinDaysBeforeSpecDay:(NSUInteger)daysBack {
    
    NSUInteger day = arc4random_uniform((u_int32_t)daysBack);  // explisit cast
    NSUInteger hour = arc4random_uniform(23);
    NSUInteger minute = arc4random_uniform(59);
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:31];
    [comps setMonth:12];
    [comps setYear:2010];
    NSDate *dateTo = [[NSCalendar currentCalendar] dateFromComponents:comps];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *offsetComponents = [NSDateComponents new];
    [offsetComponents setDay:(day * -1)];
    [offsetComponents setHour:hour];
    [offsetComponents setMinute:minute];
    
    NSDate *randomDate = [gregorian dateByAddingComponents:offsetComponents
                                                    toDate:dateTo
                                                   options:0];
    
    return randomDate;
    
}

- (Student*)addRandomStudent {
    
    NSArray* testNames = [self JSONFromFile];
        
    int count = (int)[testNames count] - 1;
    
    NSDictionary* nameDict = testNames[count];
        
    NSString* fullName = [nameDict objectForKey:@"name"];
    
    NSArray* fullNameArr = [fullName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.persistentContainer.viewContext];
    student.firstName = fullNameArr[0];
    student.lastName = fullNameArr[1];
    
    NSUInteger rndValue = 5 + arc4random() % ((365*25) - 5);
    student.dateBirth = [self generateRandomDateWithinDaysBeforeSpecDay:rndValue];
    
    student.score = (float)arc4random_uniform(201) / 200.f + 2.f;
    
    return student;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //NSDictionary *entities = [self.persistentContainer.managedObjectModel entitiesByName];
    
//    NSManagedObject *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.persistentContainer.viewContext];
//
//    [student setValue:@"Sergio" forKey:@"firstName"];
//    [student setValue:@"Lechini" forKey:@"lastName"];
//    [student setValue:[NSDate dateWithTimeIntervalSinceNow:0] forKey:@"dateBirth"];
//    [student setValue:@4.5 forKey:@"score"];
//
//    NSError *error = nil;
//    if (![self.persistentContainer.viewContext save:&error]) {
//        NSLog(@"%@",[error localizedDescription]);
//    }
    
//    Student *student = [self addRandomStudent];
//
    NSError *error = nil;
//    if (![student.managedObjectContext save:&error]) {
//        NSLog(@"%@", [error localizedDescription]);
//    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    
    //[request setResultType:NSDictionaryResultType];
    
    NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    } else {
        
        for(Student *student in resultArray) {
            
            NSLog(@"%@ %@ - %@", student.firstName,
                  student.lastName,
                  student.dateBirth);
            
            [self.persistentContainer.viewContext deleteObject:student];
            
//            NSLog(@"%@ %@ - %@", [object valueForKey:@"firstName"],
//                  [object valueForKey:@"lastName"],
//                  [object valueForKey:@"score"]);
            
        }
        
        [self.persistentContainer.viewContext save:nil];
        
    }
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"objC_CoreData"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
