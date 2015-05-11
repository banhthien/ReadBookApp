//
//  Book.h
//  BookPDF
//
//  Created by iOSx New on 5/5/15.
//  Copyright (c) 2015 BanhThien. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Book : NSManagedObject <NSObject>

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * localfile;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * currentpage;
@property (nonatomic) bool  *favorite;

@end
