//
//  LmsClientChapterOverviewViewController.m
//  LmsClient
//
//  Created by alex zaikman on 5/21/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientChapterOverviewViewController.h"

@interface LmsClientChapterOverviewViewController ()

@end

@implementation LmsClientChapterOverviewViewController

@synthesize overviewOut=_overviewOut;
@synthesize overview=_overview;


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.overviewOut.text = self.overview;
    
}

-(void)setOverviewText:(NSString *)overview{

    self.overview = overview;
    
    
}
@end
