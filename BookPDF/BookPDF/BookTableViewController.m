//
//  BookTableViewController.m
//  BookPDF
//
//  Created by iOSx New on 5/5/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "BookTableViewController.h"

@interface BookTableViewController ()

@end

@implementation BookTableViewController
@synthesize listBook;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *apdelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = [apdelegate managedObjectContext];
    //
//    Book *book= [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:_managedObjectContext];
//    book.title=@"afNetWorking";
//    book.image=@"Help.png";
//    book.localfile=@"AFNetWorking";
//    book.currentpage=[NSNumber numberWithInt:10];
//    //book.favorite=true;
//    book.type = @"IT";
//
//    NSError *error;
//    if(![_managedObjectContext save:&error]){
//    NSLog(@"co loi , %@", [error localizedDescription]);
//
//    }
    // get list student
    NSFetchRequest *fetch= [[NSFetchRequest alloc] init];
    NSEntityDescription *entity=[NSEntityDescription entityForName:@"Book" inManagedObjectContext:_managedObjectContext];
    [fetch setEntity:entity];
    NSError *error;
    listBook =[[_managedObjectContext executeFetchRequest:fetch error:&error] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
   return listBook.count;
//    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellindentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellindentifier];
    //show list
    Book *obj= [listBook objectAtIndex:indexPath.row];
    cell.textLabel.text = obj.title;
    UIImage *image = [UIImage imageNamed:obj.image];
    cell.imageView.image = image;
    return cell;
    
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //delete a object
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_managedObjectContext deleteObject:[listBook objectAtIndex:indexPath.row]];
        NSError *error = nil;
        if([_managedObjectContext save:&error]){
            
        }
        [listBook removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"ViewBook"]){
        Book *selected = [listBook objectAtIndex:[[self.tableView indexPathForSelectedRow] row] ];
        // send student to viewController
        ViewController *view = [segue destinationViewController];
        
        view.book = selected;
    }
}



@end
