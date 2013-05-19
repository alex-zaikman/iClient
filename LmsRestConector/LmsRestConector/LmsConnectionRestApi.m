//
//  LmsConnectionRestApi.m
//  LmsRestConector
//
//  Created by alex zaikman on 5/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsConnectionRestApi.h"
#import "Connector.h"

@interface LmsConnectionRestApi()



@end

@implementation LmsConnectionRestApi

static Connector* connection;

+ (void) lmsGetAppDataFrom:(NSString*)domain dictionaryModified:(NSNumber*)modified callBackTarget:(id<CalableLmsClient>)target{
    
    if(!connection)
            connection = [[Connector alloc]init];
    
    //call get request with api suffix
  NSDictionary* vars=nil;
  
  if(modified!=nil)
      vars = [[NSDictionary alloc]initWithObjectsAndKeys:@"dictionaryModified", [modified stringValue] , nil];
    
  NSString *url = [domain stringByAppendingString:@"/lms/rest/appdata"];
 [connection sendGetTo:url withVariable:vars callBack:target];
    
}

///schools/8/images/7
+ (void) lmsGetImageFrom:(NSString*)domain withSchoolId:(NSNumber*)schoolid andImageId:(NSNumber*)imageid callBackTarget:(id<CalableLmsClient>)target{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    [url appendString:domain];
    [url appendString:@"/lms/rest/schools/"];
    [url appendString:[schoolid stringValue]];
    [url appendString:@"/images"];
    [url appendString:[imageid stringValue]];

    [connection sendGetTo:url withVariable:nil callBack:target];
}



+ (void) lmsGetTeacherStudyClassesFrom:(NSString*)domain teacherId:(NSNumber*)teacherid callBackTarget:(id<CalableLmsClient>)target{
    NSMutableString *url = [[NSMutableString alloc]init];
   
    [url appendString:domain];
    [url appendString:@"/lms/rest/teachers/"];
    [url appendString:[teacherid stringValue]];
    [url appendString:@"/studyclasses"];
    
    [connection sendGetTo:url withVariable:nil callBack:target];
}

+ (void) lmsGetStudentStudyClassesFrom:(NSString*)domain studentId:(NSNumber*)studentid callBackTarget:(id<CalableLmsClient>)target{
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/students/"];
    [url appendString:[studentid stringValue]];
    [url appendString:@"/studyclasses"];
    
    [connection sendGetTo:url withVariable:nil callBack:target];
}

+ (void) lmsGetCoursesListFrom:(NSString*)domain byQuery:(NSString*)query callBackTarget:(id<CalableLmsClient>)target{
    
    NSDictionary* vars =  [[NSDictionary alloc]initWithObjectsAndKeys:@"query", query , nil];
    
    NSString *url = [domain stringByAppendingString:@"/lms/rest/appdata"];
    [connection sendGetTo:url withVariable:vars callBack:target];
    
}

+ (void) lmsGetCoursesListFrom:(NSString*)domain BySchoolId:(NSNumber*)schoolid callBackTarget:(id<CalableLmsClient>)target{
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/schools/"];
    [url appendString:[schoolid stringValue]];
    [url appendString:@"/courseinfos"];
    
    [connection sendGetTo:url withVariable:nil callBack:target];
}


//* schools/{schoolId}/catalog/course?overwrite={overwrite}
//
//+ (void) lmsAssociateCourseToSchoolFrom:(NSString*)domain toSchoolId:(NSNumber*)schoolid overwrite:(BOOL)overwrite GCRArtifact:(NSString*)jsonArtifact callBackTarget:(id<CalableLmsClient>)target{
//    
//    NSMutableString *url = [[NSMutableString alloc]init];
//    
//    [url appendString:domain];
//    [url appendString:subDomain];
//    [url appendString:@"/rest/schools/"];
//    [url appendString:[schoolid stringValue]];
//    [url appendString:@"/catalog/course"];
//    
//    NSDictionary* vars =  [[NSDictionary alloc]initWithObjectsAndKeys:@"overwrite", overwrite?@"true":@"false" ,@"GCRArtifact" , jsonArtifact , nil];
//    
//    [connection sendPutTo:url withVariable:vars callBack:target];
//    
//}
//
//
//+ (void) lmsAssociateCourseToSchoolFrom:(NSString*)domain toSchoolId:(NSNumber*)schoolid asociatecourseId:(NSNumber*)asociatecoursed callBackTarget:(id<CalableLmsClient>)target{
//    
//     NSMutableString *url = [[NSMutableString alloc]init];
//    
//    [url appendString:domain];
//    [url appendString:subDomain];
//    [url appendString:@"/rest/schools/"];
//    [url appendString:[schoolid stringValue]];
//    [url appendString:@"/courses"];
//    [url appendString:[asociatecoursed stringValue]];
//    
//    [connection sendPutTo:url withVariable:nil callBack:target];
//    
//}



+ (void) lmsGetCoursesInfosFrom:(NSString*)domain userId:(NSNumber*)userid callBackTarget:(id<CalableLmsClient>)target{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/users/"];
    [url appendString:[userid stringValue]];
    [url appendString:@"/usercourseinfos"];
    
    [connection sendGetTo:url withVariable:nil callBack:target];
    
}


//+ (void) lmsCopyCourseToTeacherFrom:(NSString*)domain userId:(NSNumber*)userid courseId:(NSNumber*)courseid callBackTarget:(id<CalableLmsClient>)target{
//    
//    NSMutableString *url = [[NSMutableString alloc]init];
//    
//    [url appendString:domain];
//    [url appendString:subDomain];
//    [url appendString:@"/rest/users/"];
//    [url appendString:[userid stringValue]];
//    [url appendString:@"/courses"];
//    [url appendString:[courseid stringValue]];
//    
//    [connection sendPutTo:url withVariable:nil callBack:target];
//}

+ (void) lmsGetCourseManifestFrom:(NSString*)domain courseId:(NSNumber*)courseid callBackTarget:(id<CalableLmsClient>)target{
 
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/userlibrary/courses/"];
    [url appendString:[courseid stringValue]];
    
    [connection sendGetTo:url withVariable:nil callBack:target];

}

+ (void) lmsGetCourseLessonFrom:(NSString*)domain courseId:(NSNumber*)courseid lessonCid:(NSNumber*)lessonCid  callBackTarget:(id<CalableLmsClient>)target{
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    [url appendString:domain];
    [url appendString:@"/lms/rest/userlibrary/courses/"];
    [url appendString:[courseid stringValue]];
    [url appendString:@"lessons/"];
    [url appendString:[lessonCid stringValue]];
    
    [connection sendGetTo:url withVariable:nil callBack:target];
}





@end
