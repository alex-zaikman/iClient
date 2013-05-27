//
//  LmsClientLessonOverviewWebViewController.h
//  LmsClient
//
//  Created by alex zaikman on 23/05/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LmsClientLessonOverviewWebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSDictionary *vars;
@property (nonatomic,strong) NSString *bodyData;
@property (nonatomic,strong) NSString *method;

@end
