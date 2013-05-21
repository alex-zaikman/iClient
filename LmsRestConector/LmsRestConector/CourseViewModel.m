//
//  CourseViewModel.m
//  LmsRestConector
//
//  Created by alex zaikman on 5/20/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "CourseViewModel.h"
#import "CalableLmsClient.h"
#import "LmsConnectionRestApi.h"


@interface CourseViewModel()<CalableLmsClient>

@property (nonatomic,strong) NSNumber *userid;
@property (nonatomic,strong) NSNumber *classid;
@property (nonatomic,strong) NSString *domain;
@property (nonatomic,strong) NSMutableDictionary* data;

typedef enum{
    APP_DATA,
    USERS_DATA,
    COURSE_DATA
}State;

@property (nonatomic,assign) State state;

@end

@implementation CourseViewModel

@synthesize userid=_userid;
@synthesize classid=_classid;
@synthesize domain=_domain;
@synthesize data=_data;
@synthesize state=_state;


void (^fnsuccess)(NSDictionary *);
void (^fnfaliure)(NSError *);




-(void)getDataQueryDomain:(NSString*)domain curentUserId:(NSNumber*)userId forClassId:(NSNumber*)classId OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{

    self.state=APP_DATA;
    self.domain=domain;
    fnsuccess=success;
    fnfaliure=faliure;
    self.userid=userId;
    self.classid=classId;
    self.data = [[NSMutableDictionary alloc]init];
    
    
    [self.data setValue:classId forKey:@"classesId"];
    
    [LmsConnectionRestApi lmsGetAppDataFrom:self.domain dictionaryModified:nil callBackTarget:self ];
    
    
    
}





- (void) didReceiveData:(NSData *)data{

    if(self.state==APP_DATA)
    {
        //collect user data
        NSError *error;
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers error:&error];
        
        NSMutableDictionary* user = [[NSMutableDictionary alloc]initWithCapacity:6];
        
        [user setValue:[[dic valueForKey:@"user"] valueForKey:@"id"] forKey:@"userId"];
        
        [user setValue:[[dic valueForKey:@"user"] valueForKey:@"userName"] forKey:@"username"];
        
        [user setValue:[[dic valueForKey:@"user"] valueForKey:@"firstName"] forKey:@"firstName"];
        
        [user setValue:[[dic valueForKey:@"user"] valueForKey:@"lastName"] forKey:@"lastName"];
        
        [user setValue:[[[dic valueForKey:@"user"] valueForKey:@"role"]objectAtIndex:0 ]forKey:@"role"];
        
        [user setValue:[dic valueForKey:@"logoutUrl"] forKey:@"logoutURL"];
        
    
        
        [self.data setValue:user forKey:@"user"];
      
        
        self.state=USERS_DATA;
        
        [LmsConnectionRestApi lmsAssociateCourseToUserFrom:self.domain toUserId:self.userid  callBackTarget:self];
        
    }else if(self.state==USERS_DATA)
    {
        NSString *courseId=@"nil";
       //check if ther is assosiated course
        
        NSError *error;
        NSArray* arr = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers error:&error];
        
        
        for(NSDictionary *dic in arr){
            //if found get the courseId and breack
            if([((NSNumber*)[dic valueForKey:@"studyClassId"])isEqualToNumber:self.classid])
            {
                courseId = [dic valueForKey:@"courseId"];
                break;
            }
        }
        
        
        //if no assosiated course fount return nil
       if((courseId==nil)||[courseId isEqualToString:@"nil"] ){
           fnsuccess(nil);
        }
        //if there is assosiated course
        else{
            [self.data setValue:courseId forKey:@"courseId"];
            
            //call next rest
            self.state=COURSE_DATA;
            
            [LmsConnectionRestApi lmsCourseDataFrom:self.domain withId:courseId callBackTarget:self];
        }
        
    }else if(self.state==COURSE_DATA)
    {
        //parce the course data
        NSError *error;
        NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers error:&error];
        NSDictionary *tocDic = [[(NSDictionary*)dic valueForKey:@"data"] valueForKey:@"toc" ];
        
        [self.data setValue:[tocDic valueForKey:@"title"] forKey:@"title"];
       
        
        [self.data setValue:[tocDic valueForKey:@"overview"] forKey:@"overview"];
        
        NSMutableArray *chaptersToAdd = [[NSMutableArray alloc]init];
      ///////////////////////////////////////////////////////////
        
        NSMutableArray *chapters = [tocDic valueForKey:@"tocItems"];
        for(NSDictionary* chapter in chapters){
            //get chapter data
            
            NSMutableDictionary *chapterToAdd = [[NSMutableDictionary alloc]init];

            [chapterToAdd setValue:[chapter valueForKey:@"cid"] forKey:@"cid"];
            [chapterToAdd setValue:[chapter valueForKey:@"title"] forKey:@"title"];
            [chapterToAdd setValue:[chapter valueForKey:@"overview"] forKey:@"overview"];
            
           
            NSMutableArray *lessonsToAdd = [[NSMutableArray alloc]init];
            
            NSArray *lessons = [chapter valueForKey:@"lessons"];
            for(NSDictionary *lesson in lessons)
            {
                NSMutableDictionary *lessonToAdd = [[NSMutableDictionary alloc]init];
                
                [lessonToAdd setValue:[lesson valueForKey:@"cid"] forKey:@"cid"];
                [lessonToAdd setValue:[lesson valueForKey:@"title"] forKey:@"title"];
                
                [lessonsToAdd addObject:lessonToAdd];
            }
            
            [chapterToAdd setValue:lessonsToAdd forKey:@"lessons"];
            
            
            [chaptersToAdd addObject:chapterToAdd];
        }
        
        //////////////////////////////////////////////////////////////
        [self.data setValue:chaptersToAdd forKey:@"chapters"];
        
        fnsuccess(self.data);
    }
    
}

- (void) didFailWithError:(NSError *)error{
    
    fnfaliure(error);
}

- (void) didReceiveResponse:(NSURLResponse *)response{
    //
}

- (void) didFinishLoading{
    //
}

@end
