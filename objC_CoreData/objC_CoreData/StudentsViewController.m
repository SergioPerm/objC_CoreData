//
//  StudentsViewController.m
//  objC_CoreData
//
//  Created by kluv on 17/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "StudentsViewController.h"
#import "Student+CoreDataClass.h"

@interface StudentsViewController ()

@end

@implementation StudentsViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSFetchedResultsController<Student*> *)fetchedResultsController {
        
    [NSFetchedResultsController deleteCacheWithName:@"Master"];
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Student"];
    
    //NSFetchRequest<Course *> *fetchRequest = Course.fetchRequest;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"course contains %@", self.course];
    
    [fetchRequest setPredicate:predicate];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<Student *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    aFetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
    
}

- (void)configureCell:(UITableViewCell *)cell withObject:(id)dataObject {
    
    Student *student = (Student*)dataObject;
        
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.lastName, student.firstName];
    cell.detailTextLabel.text = student.studentCar.model;
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
