//
//  LmsRestConector.m
//  LmsRestConector
//
//  Created by alex zaikman on 5/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "Connector.h"

@interface Connector() <NSURLConnectionDelegate>

@property (nonatomic,strong)  NSURLConnection* connection;
@property (nonatomic,strong) id<CalableLmsClient> callback;

@end


@implementation Connector

@synthesize connection=_connection;
@synthesize callback=_callback;



//api func

//- (void) sendPutTo: (NSString*)url withVariable:(NSDictionary*)var callBack:(id<CalableLmsClient>) callback{
//    self.callback = callback;
//    
//    NSMutableURLRequest * postRequest= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
//    
//     if(var!=nil){
//        
//         
//         NSString *bodyData =@"";
//         
//         NSEnumerator *it = [var keyEnumerator];
//    
//         for(NSString *aKey in it) {
//             bodyData = [bodyData stringByAppendingString:aKey];
//             bodyData = [bodyData stringByAppendingString:@"="];
//             bodyData = [bodyData stringByAppendingString:[var valueForKey:aKey]];
//             bodyData = [bodyData stringByAppendingString:@"&"];
//         }
//    
//         if ( [bodyData length] > 0)
//             bodyData = [bodyData substringToIndex:[bodyData length] - 1];
//    
//         [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:[bodyData length]]];
//    }
//    
//    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
//    
//    [postRequest setHTTPMethod:@"PUT"];
//    
//    
//    self.connection = [[NSURLConnection alloc]initWithRequest:postRequest delegate:self startImmediately:YES];
//}
//

-(void) sendGetTo: (NSString*)url withVariable:(NSDictionary*) var callBack:(id<CalableLmsClient>) callback{
    
    self.callback = callback;
    
    NSString *bodyData =@"?";
    
    NSEnumerator *it = [var keyEnumerator];
    
    for(NSString *aKey in it) {
        bodyData = [bodyData stringByAppendingString:aKey];
        bodyData = [bodyData stringByAppendingString:@"="];
        bodyData = [bodyData stringByAppendingString:[var valueForKey:aKey]];
        bodyData = [bodyData stringByAppendingString:@"&"];
    }
    
    if ( [bodyData length] > 1){
        bodyData = [bodyData substringToIndex:[bodyData length] - 1];
        url = [url stringByAppendingString:bodyData];
    }
    
    NSMutableURLRequest * getRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]
                                                        cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                         timeoutInterval:90.0];
    
    [getRequest addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [getRequest setHTTPMethod:@"GET"];
    
    self.connection = [[NSURLConnection alloc]initWithRequest:getRequest delegate:self startImmediately:YES];
}


-(void) sendPostTo: (NSString*)url withVariable:(NSDictionary*) var callBack:(id<CalableLmsClient>) callback{
    
    
    self.callback = callback;
    
    NSMutableURLRequest * postRequest= [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    
    if(var!=nil){
        
        NSString *bodyData =@"";
        
        NSEnumerator *it = [var keyEnumerator];
        
        for(NSString *aKey in it) {
            bodyData = [bodyData stringByAppendingString:aKey];
            bodyData = [bodyData stringByAppendingString:@"="];
            bodyData = [bodyData stringByAppendingString:[var valueForKey:aKey]];
            bodyData = [bodyData stringByAppendingString:@"&"];
        }
        
        if ( [bodyData length] > 0)
            bodyData = [bodyData substringToIndex:[bodyData length] - 1];
        
        [postRequest setHTTPBody:[NSData dataWithBytes:[bodyData UTF8String] length:[bodyData length]]];
    }
    
    [postRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [postRequest setHTTPMethod:@"POST"];
    
    self.connection = [[NSURLConnection alloc]initWithRequest:postRequest delegate:self startImmediately:YES];
}

//events

-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
        [self.callback didReceiveResponse:response];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
        [self.callback didFailWithError:error];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
        [self.callback didReceiveData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
        [self.callback didFinishLoading];
}

@end
