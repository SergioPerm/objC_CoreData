//
//  UniversityViewController.m
//  objC_CoreData
//
//  Created by kluv on 08/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import "UniversityViewController.h"
#import "University+CoreDataClass.h"
#import "CoursesViewController.h"

@interface UniversityViewController ()


@end

@implementation UniversityViewController
@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSArray * urls = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
//    NSLog(@"%@",[urls description]);
    
    //[[DataManager shareManager] generateAndAddUniversity];
    
    //[[DataManager shareManager] printAllObjects];
    
    self.navigationItem.title = @"Universities";

}

- (NSFetchedResultsController<University*> *)fetchedResultsController {
    
    //_fetchedResultsController = nil;
    
    [NSFetchedResultsController deleteCacheWithName:@"Master"];
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest<University *> *fetchRequest = University.fetchRequest;
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];

    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController<University *> *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
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
    
    University *universityObject = (University*)dataObject;
    
    cell.textLabel.text = universityObject.name;
    cell.detailTextLabel.text = @"university";
    //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    University *university = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    CoursesViewController *courseView = [[CoursesViewController alloc] init];
    courseView.university = university;
    
    [self.navigationController pushViewController:courseView animated:YES];
    
}

@end
