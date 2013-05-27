//
//  LmsClientLessonOverviewWebViewController.m
//  LmsClient
//
//  Created by alex zaikman on 23/05/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientLessonOverviewWebViewController.h"

@interface LmsClientLessonOverviewWebViewController ()

+(NSURLRequest *)createRequestToUrl:(NSString*)url method:(NSString*)method withVars:(NSDictionary*)vars andBodyData:(NSString*)bodydata;


@end

@implementation LmsClientLessonOverviewWebViewController

@synthesize webView=_webView;

@synthesize url=_url;
@synthesize vars=_vars;
@synthesize bodyData=_bodyData;
@synthesize method=_method;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.webView loadRequest:[LmsClientLessonOverviewWebViewController createRequestToUrl:self.url method:self.method withVars:self.vars andBodyData:self.bodyData]];
    
    [self.view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


+(NSURLRequest *)createRequestToUrl:(NSString*)url method:(NSString*)method withVars:(NSDictionary*)vars andBodyData:(NSString*)bodydata{
    
    if(url == nil){
      //  @throw [[NSException alloc]init];
        url=@"http://www.ynet.co.il";
    }
    
    
    if(vars!=nil){
        NSMutableString *getVars = [[NSMutableString alloc]init];
        
        [getVars appendString:@"?"];
        
        NSEnumerator *it = [vars keyEnumerator];
        
        for(NSString *aKey in it) {
            getVars = [[getVars stringByAppendingString:aKey]mutableCopy];
            getVars = [[getVars stringByAppendingString:@"="]mutableCopy];
            getVars = [[getVars stringByAppendingString:[vars valueForKey:aKey]]mutableCopy];
            getVars = [[getVars stringByAppendingString:@"&"]mutableCopy];
        }
        
        [getVars substringToIndex:[getVars length] - 1];
        
        url = [url stringByAppendingString:getVars];
    }
    
    
    NSMutableURLRequest * request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:90.0];
    
    
    [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    if(method!=nil){
        [request setHTTPMethod:method];
    }
    
    if(bodydata!=nil){
        [request setHTTPBody:[NSData dataWithBytes:[bodydata UTF8String] length:[bodydata length]]];
    }
    
    return request;
    
    
}


@end
