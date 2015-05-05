//
//  ViewController.h
//  BookPDF
//
//  Created by iOSx New on 5/5/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"
#import "AppDelegate.h"

@interface ViewController : UIViewController
{
    IBOutlet UIWebView *webView;
}
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property size_t pageCount;
@property (nonatomic, retain) IBOutlet UIWebView *webView;
- (IBAction)movePageClick:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *pageTxt;
@property (strong, nonatomic) IBOutlet UILabel *maximunPage;
- (IBAction)savePageClick:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *numberOfLastPageRead;
@property (strong) Book *book;
@end

