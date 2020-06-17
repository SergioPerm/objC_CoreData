//
//  DataManager.m
//  objC_CoreData
//
//  Created by kluv on 08/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "DataManager.h"
#import "Student+CoreDataClass.h"
#import "Car+CoreDataClass.h"
#import "University+CoreDataClass.h"
#import "Course+CoreDataClass.h"

static NSString *carModelNames[] = {
    @"Lada 112", @"BMW 320i", @"Ford Raprtor F150", @"Honda Civic", @"Honda Accord", @"Niva",@"UAZ",@"KIA"
};

@implementation DataManager

+(DataManager*) shareManager {
    
    static DataManager* manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataManager alloc] init];
    });
    
    return manager;
    
}

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
    
    NSDictionary* nameDict = testNames[arc4random_uniform(count)];
        
    NSString* fullName = [nameDict objectForKey:@"name"];
    
    NSArray* fullNameArr = [fullName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.persistentContainer.viewContext];
    student.firstName = fullNameArr[0];
    student.lastName = fullNameArr[1];
    
    NSUInteger rndValue = 5 + arc4random() % ((365*25) - 5);
    student.dateBirth = [self generateRandomDateWithinDaysBeforeSpecDay:rndValue];
    
    student.score = (float)arc4random_uniform(201) / 100.f + 2.f;
    
    return student;
    
}

- (University*)addUniversity {
    
    University *university = [NSEntityDescription insertNewObjectForEntityForName:@"University" inManagedObjectContext:self.persistentContainer.viewContext];
    
    university.name = @"PSTU";
    
    return university;
    
}

- (Course*)addCourseWithName:(NSString*)nameCourse {
    
    Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:self.persistentContainer.viewContext];
    
    course.name = nameCourse;
    
    return course;
    
}

- (Car*)addRandomCar {
    
    Car *car = [NSEntityDescription insertNewObjectForEntityForName:@"Car" inManagedObjectContext:self.persistentContainer.viewContext];
    
    car.model = carModelNames[arc4random_uniform(7)];
    
    return car;
    
}

-(void)generateAndAddUniversity {

//NSArray * urls = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
//
//    NSLog(@"%@",[urls description]);
    
    NSArray *courses = @[[self addCourseWithName:@"iOS"],
                         [self addCourseWithName:@"Android"],
                         [self addCourseWithName:@"PHP"],
                         [self addCourseWithName:@"C#"],
                         [self addCourseWithName:@"Java"],
                         [self addCourseWithName:@"JS"],
                         [self addCourseWithName:@"Design"]];



    University *univer = [self addUniversity];

    [univer addCourses:[NSSet setWithArray:courses]];

    for (int i = 0; i < 99; i++) {

        Student *student = [self addRandomStudent];

        if (arc4random_uniform(1000) < 500) {
            Car *car = [self addRandomCar];
            student.studentCar = car;
        }

        NSInteger number = arc4random_uniform(5) + 1;

        while ([student.course count] < number) {

            Course *course = [courses objectAtIndex:arc4random_uniform(5)];

            if (![student.course containsObject:course]) {
                [student addCourseObject:course];
            }

        }

        student.university = univer;

    }

    NSError *error = nil;

    if (![self.persistentContainer.viewContext save:&error])
        NSLog(@"%@", [error localizedDescription]);
    
//    Student *student1 = [self addRandomStudent];
//    Car *car1 = [self addRandomCar];
//
//    student1.studentCar = car1;
//
//    NSError *error = nil;
//
//    if (![self.persistentContainer.viewContext save:&error])
//        NSLog(@"%@", [error localizedDescription]);
//
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"University"];
//
//    NSError *error = nil;
//    NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
//
//    if ([resultArray count] > 0) {
//
//        University *univer = [resultArray firstObject];
//
//        [self.persistentContainer.viewContext deleteObject:univer];
//        [self.persistentContainer.viewContext save:nil];
//
//    }
        
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Course"];
//    [request setRelationshipKeyPathsForPrefetching:@[@"students"]];
    
    //[request setFetchBatchSize:20];
    //[request setRelationshipKeyPathsForPrefetching:@[@"course"]];

//    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
//    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
//
//    [request setSortDescriptors:@[firstNameDescriptor, lastNameDescriptor]];
//
//    NSArray *valideNames = @[@"Justin",@"Camilla",@"Ursula"];
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"score > %f AND score <= %f AND course.@count >= 3 AND firstName IN %@", 3.0, 3.5, valideNames];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SUBQUERY(students, $student, $student.studentCar.model == %@).@count > %f", @"BMW 320i", 2.0f];
//
//    [request setPredicate:predicate];
    
//    [request setFetchOffset:10];
//    [request setFetchLimit:35];

//    NSError *error = nil;
//    NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
//
//    [self printArray:resultArray];
    
//    NSFetchRequest *request = [self.persistentContainer.managedObjectModel fetchRequestTemplateForName:@"FetchStudents"];
//
//    NSError *error = nil;
//    NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    
    //[self printArray:resultArray];
    
//    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Course"];
//    [request setRelationshipKeyPathsForPrefetching:@[@"students"]];
//    
//    NSError *error = nil;
//    NSArray *resultArray = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
//    
//    for (Course *course in resultArray) {
//        
//        NSLog(@"COURSE %@", course.name);
//        NSLog(@"BEST STUDENTS:");
//        [self printArray:course.bestStudents];
//        NSLog(@"MANY COURSES:");
//        [self printArray:course.studentsWithmanyCourses];
//        
//    }
    
    //[self printAllObjects];
    
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

-(void)printArray:(NSArray*) array {
    
    for(id object in array) {
        
        if ([object isKindOfClass:[Student class]]) {
            
            Student *student = (Student*)object;
    
            NSLog(@"Student name: %@; Score %1.2f; COURSES %lu", [NSString stringWithFormat:@"%@ %@",student.firstName,student.lastName], student.score, (unsigned long)[student.course count]);
            
        } else if ([object isKindOfClass:[Car class]]) {
            
            Car *car = (Car*)object;
            
            NSLog(@"Car model: %@",car.model);
            
        } else if ([object isKindOfClass:[University class]]) {
            
            University *university = (University*)object;
            
            NSLog(@"University %@ Students %lu",university.name,(unsigned long)[university.students count]);
            
        } else if ([object isKindOfClass:[Course class]]) {
            
            Course *course = (Course*)object;
            
            NSLog(@"Course %@ Students %lu; AVERAGE SCORE %1.2f", course.name, [course.students count], [[course.students valueForKeyPath:@"@avg.score"] floatValue]);
            
        }
                
    }
    
}

-(void)printAllObjects {
        
    NSArray *resultArray = [self getAllObjects];
        
    [self printArray:resultArray];
    
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
