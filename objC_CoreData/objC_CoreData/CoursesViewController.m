//
//  CoursesViewController.m
//  objC_CoreData
//
//  Created by kluv on 15/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "CoursesViewController.h"
#import "Course+CoreDataClass.h"
#import "University+CoreDataClass.h"
#import "StudentsViewController.h"

@interface CoursesViewController ()

@end

@implementation CoursesViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (instancetype)initWithUniversity:(University*) university
{
    self = [super init];
    if (self) {
        _university = university;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSFetchedResultsController<Course*> *)fetchedResultsController {
        
    [NSFetchedResultsController deleteCacheWithName:@"Master"];
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Course"];
    
    //NSFetchRequest<Course *> *fetchRequest = Course.fetchRequest;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"university == %@", self.university];
    
    [fetchRequest setPredicate:predicate];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<Course *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
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
    
    Course *course = (Course*)dataObject;
    
    int countStudents = (int)[course.students count];
    
    cell.textLabel.text = course.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", countStudents];
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Course *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    StudentsViewController *studentsView = [[StudentsViewController alloc] init];
    studentsView.course = course;
    
    [self.navigationController pushViewController:studentsView animated:YES];
    
}

@end
