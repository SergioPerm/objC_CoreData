//
//  StudentsViewController.h
//  objC_CoreData
//
//  Created by kluv on 17/06/2020.
//  Copyright © 2020 com.kluv.hw24. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "Course+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface StudentsViewController : CoreDataTableViewController

@property (strong, nonatomic) Course *course;

@end

NS_ASSUME_NONNULL_END
