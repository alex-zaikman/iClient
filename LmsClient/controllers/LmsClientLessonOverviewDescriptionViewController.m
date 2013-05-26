//
//  LmsClientLessonOverviewDescriptionViewController.m
//  LmsClient
//
//  Created by alex zaikman on 23/05/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientLessonOverviewDescriptionViewController.h"

@interface LmsClientLessonOverviewDescriptionViewController ()



@end

@implementation LmsClientLessonOverviewDescriptionViewController



@synthesize objectives=_objectives;
@synthesize descripthion=_descripthion;
@synthesize lessonName=_lessonName;
@synthesize content=_content;



-(void)viewDidLoad{
    self.lessonName.text = (NSString*)[self.content valueForKey:@"name"];
    
    self.objectives.text = (NSString*)[self.content valueForKey:@"objectives"];
    self.descripthion.text = (NSString*)[self.content valueForKey:@"description"];
    
    [self.view setNeedsDisplay];
    
}


@end
