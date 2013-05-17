//
//  LmsConnectionRestApi.h
//  LmsRestConector
//
//  Created by alex zaikman on 5/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalableLmsClient.h"

@interface LmsConnectionRestApi : NSObject

/**
 *
 * Returns initial common data for application, such as user info, school info, translations. 
 * User will be retrieved from session on the server therefore login is a prerequisite.
 * 
 * dictionaryModified is optional
 */
+ (void) lmsGetAppDataFrom:(NSString*)domain dictionaryModified:(NSNumber*)modified callBackTarget:(id<CalableLmsClient>)target;

/**
 * Get dynamic image stored on server db (such as school logo, study class icon)
 */
+ (void) lmsGetImageFrom:(NSString*)domain withSchoolId:(NSNumber*)schoolid andImageId:(NSNumber*)imageid callBackTarget:(id<CalableLmsClient>)target;
/*
 * Get study classes assigned to the teacher
*/
+ (void) lmsGetTeacherStudyClassesFrom:(NSString*)domain teacherId:(NSNumber*)teacherid callBackTarget:(id<CalableLmsClient>)target;

/*
 * Get study classes of a student
 */
+ (void) lmsGetStudentStudyClassesFrom:(NSString*)domain studentId:(NSNumber*)studentid callBackTarget:(id<CalableLmsClient>)target;


/*
 * Returns a list of Courses info from GCR. 
 */
+ (void) lmsGetCoursesListFrom:(NSString*)domain byQuery:(NSString*)query callBackTarget:(id<CalableLmsClient>)target;

/*
 * Returns a list of Courses info associated to the school.
 * A Course info contains headers without TOC
 */
+ (void) lmsGetCoursesListFrom:(NSString*)domain BySchoolId:(NSNumber*)schoolid callBackTarget:(id<CalableLmsClient>)target;

/*
 * Associate Course to School (Admin)
 */
//+ (void) lmsAssociateCourseToSchoolFrom:(NSString*)domain toSchoolId:(NSNumber*)schoolid overwrite:(BOOL)overwrite  GCRArtifact:(NSString*)jsonArtifact callBackTarget:(id<CalableLmsClient>)target;

/*
 * Associate Course to School (Admin)
 */
//+ (void) lmsAssociateCourseToSchoolFrom:(NSString*)domain toSchoolId:(NSNumber*)schoolid asociatecourseId:(NSNumber*)asociatecourseid callBackTarget:(id<CalableLmsClient>)target;

/*
 * Returns a list of Courses Infos associated to a teacher.
 * A Course info contains headers without TOC and list of study classes associated to the course
 */
+ (void) lmsGetCoursesInfosFrom:(NSString*)domain userId:(NSNumber*)userid callBackTarget:(id<CalableLmsClient>)target;


/*
 * Copy Course to Teacher
 * Returns a list of Courses Infos associated to a teacher.
 * A Course info contains headers without TOC and list of study classes associated to the course
 */
//+ (void) lmsCopyCourseToTeacherFrom:(NSString*)domain userId:(NSNumber*)userid courseId:(NSNumber*)courseid callBackTarget:(id<CalableLmsClient>)target;

/*
 * Returns the full Course manifest associated to the user. 
 */
+ (void) lmsGetCourseManifestFrom:(NSString*)domain courseId:(NSNumber*)courseid callBackTarget:(id<CalableLmsClient>)target;

/*
 * Returns the full course lesson. 
 */
+ (void) lmsGetCourseLessonFrom:(NSString*)domain courseId:(NSNumber*)courseid lessonCid:(NSNumber*)lessonCid  callBackTarget:(id<CalableLmsClient>)target;







//TODO add the rest of the rest api...
@end
