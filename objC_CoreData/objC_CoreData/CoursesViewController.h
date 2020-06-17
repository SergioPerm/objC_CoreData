//
//  CoursesViewController.h
//  objC_CoreData
//
//  Created by kluv on 15/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class University;

@interface CoursesViewController : CoreDataTableViewController

@property (strong, nonatomic) University *university;

- (id)initWithUniversity:(University*) university;

@end

NS_ASSUME_NONNULL_END
