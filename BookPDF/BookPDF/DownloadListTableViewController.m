//
//  DownloadListTableViewController.m
//  BookPDF
//
//  Created by iOSx New on 5/5/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "DownloadListTableViewController.h"
#import "AFNetWorking.h"
#import "Book.h"

@interface DownloadListTableViewController ()

@end

@implementation DownloadListTableViewController
@synthesize data;
@synthesize listBook;
@synthesize managedObjectContext = _managedObjectContext;
- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *apdelegate = [[UIApplication sharedApplication] delegate];
    _managedObjectContext = [apdelegate managedObjectContext];

    [self refreshData];
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma DataFuntion
-(void) refreshData{
    NSString *string = [NSString stringWithFormat:@"http://www.json-generator.com/api/json/get/chMstzWNpe?indent=2"];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        listBook = [NSMutableArray array];
        
        NSArray* dataPost = [responseObject valueForKeyPath:@"data"];
        
        for (NSDictionary *dict in dataPost)
        {
            
            //NSString *image =[dict objectForKey:@"image"];
            //NSString *localfile= [dict objectForKey:@"url"];
            Book *book= [[Book alloc] init];//[NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:_managedObjectContext];
            book.image= [dict objectForKey:@"image"];
            book.localfile= [dict objectForKey:@"url"];
            book.title=[dict objectForKey:@"title"];
            book.type=[dict objectForKey:@"type"];
            //book.favorite=FALSE;
            book.currentpage=0;
            [self.listBook addObject:book];
//            if (![self.listBook containsObject:book]) {
//            }
            NSLog(@"self.list:%@", self.listBook);
        }
    
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    [operation start];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return listBook.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DownloadCell" forIndexPath:indexPath];
    
    
    Book *book = [listBook objectAtIndex:indexPath.row];
    // show text
    NSURL *url = [NSURL URLWithString:book.image];
    NSData *urlimage = [NSData dataWithContentsOfURL:url];
    UIImage * image = [UIImage imageWithData:urlimage];
    
    cell.imageView.image=image;
    cell.textLabel.text= book.title;
    
    //cell.nameLabel.font = [UIFont boldSystemFontOfSize:16.0f];
    //cell.postLabel.text = post.post;
    //cell.nameLabel.text = post.name;

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
