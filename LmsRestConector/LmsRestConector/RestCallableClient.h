//
//  RestCallableClient.h
//  LmsRestConector
//
//  Created by alex zaikman on 5/16/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RestCallableClient <NSObject>

-(void) faildWith: (NSError *)error;

-(void) sucsses: (NSDictionary *)result;

@end
