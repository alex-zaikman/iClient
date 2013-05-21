//
//  CourseViewModel.h
//  LmsRestConector
//
//  Created by alex zaikman on 5/20/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseViewModel : NSObject

/*
 *  !!!!! if there is NO ASSOSIATED course this function WILL CALL SUCCESS WITH NIL !!!!
 */
-(void)getDataQueryDomain:(NSString*)domain curentUserId:(NSNumber*)userId forClassId:(NSNumber*)classId OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;
@end
