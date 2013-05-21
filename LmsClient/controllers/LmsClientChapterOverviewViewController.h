//
//  LmsClientChapterOverviewViewController.h
//  LmsClient
//
//  Created by alex zaikman on 5/21/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LmsClientChapterOverviewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *overviewOut;
@property (strong,nonatomic) NSString* overview;
-(void)setOverviewText:(NSString *)overview;
@end
