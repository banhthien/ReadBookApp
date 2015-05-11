//
//  BookTableViewController.h
//  BookPDF
//
//  Created by iOSx New on 5/5/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "AppDelegate.h"
#import "CoreData/CoreData.h"
#import "ViewController.h"

@interface BookTableViewController : UITableViewController
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property NSMutableArray *listBook;
@end
