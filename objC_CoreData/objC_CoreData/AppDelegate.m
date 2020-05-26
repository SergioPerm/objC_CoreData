//
//  AppDelegate.m
//  objC_CoreData
//
//  Created by kluv on 21/05/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "AppDelegate.h"
#import "Student+CoreDataClass.h"
#import "Car+CoreDataClass.h"
#import "University+CoreDataClass.h"

@interface AppDelegate ()

@end

static NSString *carModelNames[] = {
    @"Lada 112", @"BMW 320i", @"Ford Raprtor F150", @"Honda Civic", @"Honda Accord", @"Niva",@"UAZ",@"KIA"
};

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

- (University*)addUniversity {
    
    University *university = [NSEntityDescription insertNewObjectForEntityForName:@"University" inManagedObjectContext:self.persistentContainer.viewContext];
    
    university.name = @"PGU";
    
    return university;
    
}

- (Car*)addRandomCar {
    
    Car *car = [NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:self.persistentContainer.viewContext];
    
    car.model = carModelNames[arc4random_uniform(7)];
    
    return car;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    University *univer = [self addUniversity];
//
//    for (int i = 0; i < 30; i++) {
//
//        Student *student = [self addRandomStudent];
//
//        if (arc4random_uniform(1000) < 500) {
//            Car *car = [self addRandomCar];
//            student.studentCar = car;
//        }
//
//        //[univer addStudentsObject:student];
//
//        student.university = univer;
//
//    }
//
//    NSError *error = nil;
//
//    if (![self.persistentContainer.viewContext save:&error])
//        NSLog(@"%@", [error localizedDescription]);
    
//    Student *student1 = [self addRandomStudent];
//    Car *car1 = [self addRandomCar];
//
//    student1.studentCar = car1;
//
//    NSError *error = nil;
//
//    if (![self.persistentContainer.viewContext save:&error])
//        NSLog(@"%@", [error localizedDescription]);
      
    NSError *error = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"University"];

    NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];

    if ([resultArray count] > 0) {

        University *univer = [resultArray firstObject];

        [self.persistentContainer.viewContext deleteObject:univer];
        [self.persistentContainer.viewContext save:nil];

    }
        
    [self printAllObjects];
    
    return YES;
}

-(NSArray*)getAllObjects {
    
    NSError *error = nil;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Object"];
    
    return [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    
}

-(void)deleteAllObjects {
        
    NSArray *resultArray = [self getAllObjects];
    
    for(id object in resultArray) {
        
        [self.persistentContainer.viewContext deleteObject:object];
        
    }
    
    if ([resultArray count] > 0)
        [self.persistentContainer.viewContext save:nil];
    
    
}

-(void)printAllObjects {
        
    NSArray *resultArray = [self getAllObjects];
        
    for(id object in resultArray) {
        
        if ([object isKindOfClass:[Student class]]) {
            
            Student *student = (Student*)object;
    
            NSLog(@"Student name: %@; car: %@; Univer: %@", [NSString stringWithFormat:@"%@ %@",student.firstName,student.lastName], student.studentCar.model, student.university.name);
            
        } else if ([object isKindOfClass:[Car class]]) {
            
            Car *car = (Car*)object;
            
            NSLog(@"Car model: %@",car.model);
            
        } else if ([object isKindOfClass:[University class]]) {
            
            University *university = (University*)object;
            
            NSLog(@"University %@ Students %lu",university.name,(unsigned long)[university.students count]);
            
        }
                
    }
    
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
