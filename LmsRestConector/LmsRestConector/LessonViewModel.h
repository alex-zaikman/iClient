//
//  LessonViewModel.h
//  LmsRestConector
//
//  Created by alex zaikman on 23/05/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LessonViewModel : NSObject

-(void)getDataQueryDomain:(NSString*)domain forUserId: (NSNumber*)userid withCourseId:(NSString*)courseid andLessonId:(NSString*)lessonid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure;

@end


