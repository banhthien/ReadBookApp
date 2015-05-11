//
//  ViewController.m
//  BookPDF
//
//  Created by iOSx New on 5/5/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize pageCount;
@synthesize book;
@synthesize webView;
- (void)viewDidLoad {
    [super viewDidLoad];
    if(book){
        AppDelegate *apdelegate = [[UIApplication sharedApplication] delegate];
        _managedObjectContext = [apdelegate managedObjectContext];
        NSString *path;
        NSLog(@"%@", book.localfile);
        if([book.localfile isEqualToString:@"AFNetWorking"]){
            path = [[NSBundle mainBundle] pathForResource:book.localfile ofType:@"pdf"];
        }
        else {
            NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString  *documentsDirectory = [paths objectAtIndex:0];
           
            path= [NSString stringWithFormat:@"%@/%@.pdf", documentsDirectory, book.localfile];
        }
        
        
        NSURL *url = [NSURL fileURLWithPath:path];
        CGPDFDocumentRef document = CGPDFDocumentCreateWithURL((CFURLRef)url);
        pageCount = CGPDFDocumentGetNumberOfPages(document);
       
        self.maximunPage.text= [NSString stringWithFormat:@"/ %zu",pageCount];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
        [webView loadRequest:urlRequest];
        webView.scalesPageToFit = YES;
        self.numberOfLastPageRead.text = [NSString stringWithFormat:@"Last page read %i", [book.currentpage intValue]];
        self.pageTxt.text=[NSString stringWithFormat:@"%i", [book.currentpage intValue]];
        self.title= book.title;
      
        
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)movePageClick:(id)sender {
    if([self.pageTxt.text integerValue] <=pageCount-1){
        [self movePage:[self.pageTxt.text intValue]-1];
        }
    else {
        //out of range
    }
}

-(void)movePage:(int)currentpage{
    CGFloat contentHeight = self.webView.scrollView.contentSize.height;
    float pdfPageHeight = contentHeight / pageCount;
    float y = pdfPageHeight * (currentpage);
    
    [[webView scrollView] setContentOffset:CGPointMake(0,y) animated:NO];

}
- (IBAction)savePageClick:(id)sender {
    CGFloat contentHeight = self.webView.scrollView.contentSize.height;
    float pdfPageHeight = contentHeight / pageCount;
    float halfScreenHeight = (self.webView.frame.size.height / 2);
    float verticalContentOffset = self.webView.scrollView.contentOffset.y;
    int pageNumber = ceilf((verticalContentOffset + halfScreenHeight) /pdfPageHeight);
    
    book.currentpage = [NSNumber numberWithInt:pageNumber];
    
    NSError *error;
    if(![_managedObjectContext save:&error]){
        NSLog(@"co loi , %@", [error localizedDescription]);
    }
    self.numberOfLastPageRead.text = [NSString stringWithFormat:@"Last page read %i", [book.currentpage intValue]];
    
    
//    NSString *stringURL = @"https://www.adobe.com/enterprise/accessibility/pdfs/acro6_pg_ue.pdf";
//    NSURL  *url = [NSURL URLWithString:stringURL];
//    NSData *urlData = [NSData dataWithContentsOfURL:url];
//    if ( urlData )
//    {
//        NSArray       *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString  *documentsDirectory = [paths objectAtIndex:0];
//        NSLog(@"%@",documentsDirectory);
//        NSString  *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"acro.pdf"];
//        [urlData writeToFile:filePath atomically:YES];
//    }

}
@end
