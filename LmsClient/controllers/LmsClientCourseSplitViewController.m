//
//  LmsClientCourseSplitViewController.m
//  LmsClient
//
//  Created by alex zaikman on 5/21/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientCourseSplitViewController.h"

@interface LmsClientCourseSplitViewController ()

@end

@implementation LmsClientCourseSplitViewController

@synthesize data=_data;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[[self viewControllers] objectAtIndex:0] performSelector:@selector(setData:)
                                                   withObject:self.data];
    
    [[[self viewControllers] objectAtIndex:1]performSelector:@selector(setData:)
withObject:self.data];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
