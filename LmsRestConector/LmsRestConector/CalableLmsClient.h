//
//  CalableLmsClient.h
//  LmsRestConector
//
//  Created by alex zaikman on 5/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CalableLmsClient <NSObject>

- (void) didReceiveData:(NSData *)data;

- (void) didFailWithError:(NSError *)error;

- (void) didReceiveResponse:(NSURLResponse *)response;

- (void) didFinishLoading;

@end
