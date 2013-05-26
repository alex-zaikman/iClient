//
//  LmsClientLessonOverviewDescriptionViewController.h
//  LmsClient
//
//  Created by alex zaikman on 23/05/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LmsClientLessonOverviewDescriptionViewController : UIViewController

@property (nonatomic,strong) NSDictionary *content;


@property (weak, nonatomic) IBOutlet UILabel *lessonName;


@property (weak, nonatomic) IBOutlet UITextView *objectives;


@property (weak, nonatomic) IBOutlet UITextView *descripthion;



-(void)setContent:(NSDictionary*)content;


@end
