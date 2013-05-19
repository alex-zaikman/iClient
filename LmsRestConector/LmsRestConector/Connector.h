//
//  LmsRestConector.h
//  LmsRestConector
//
//  Created by alex zaikman on 5/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalableLmsClient.h"
@interface Connector : NSObject



- (void) sendGetTo: (NSString*)url withVariable:(NSDictionary*)var callBack:(id<CalableLmsClient>) callback;

- (void) sendPostTo: (NSString*)url withVariable:(NSDictionary*)var callBack:(id<CalableLmsClient>) callback;

//- (void) sendPutTo: (NSString*)url withVariable:(NSDictionary*)var callBack:(id<CalableLmsClient>) callback;

@end
