//
//  DownloadListTableViewController.h
//  BookPDF
//
//  Created by iOSx New on 5/5/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface DownloadListTableViewController : UITableViewController
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(strong) NSDictionary *data;
@property (strong) NSMutableArray *listBook;

@end
