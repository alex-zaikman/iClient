//
//  LmsClientCourseViewController.m
//  LmsClient
//
//  Created by alex zaikman on 5/20/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientCourseViewController.h"

@interface LmsClientCourseViewController ()

@property (weak, nonatomic) IBOutlet UITextView *debug;
@end

@implementation LmsClientCourseViewController

@synthesize data=_data;

@synthesize debug=_debug;


-(void)viewDidLoad{
    NSError* error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:self.data
                                                       options:NSJSONWritingPrettyPrinted error:&error];
    NSString* newStr = [[NSString alloc] initWithData:jsonData
                                              encoding:NSUTF8StringEncoding];


    self.debug.text=newStr;
}

@end
