//
//  HomeViewModel.h
//  LmsRestConector
//
//  Created by alex zaikman on 5/19/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HomeViewModel : NSObject
-(void)getDataQueryDomain:(NSString*)domain OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;
@end
