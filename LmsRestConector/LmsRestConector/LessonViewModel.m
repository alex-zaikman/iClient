//
//  LessonViewModel.m
//  LmsRestConector
//
//  Created by alex zaikman on 23/05/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LessonViewModel.h"
#import "CalableLmsClient.h"
#import "LmsConnectionRestApi.h"

@interface LessonViewModel()<CalableLmsClient>


@property (nonatomic,strong) NSDictionary *data;
@property (nonatomic,strong) NSString *domain;
@property (nonatomic,strong) NSString *courseid;
@property (nonatomic,strong) NSString *lessonid;
@property (nonatomic,strong) NSNumber *userid;

typedef enum{
    APP_DATA,
    LESSON_DATA,
    SEQ_DATA
}State;

@property (nonatomic,assign) State state;





- (void) proccessAppData:(NSData *)data;
- (void) proccessLessonData:(NSData *)data;
- (void) proccessSeqData:(NSData *)data;

@end
@implementation LessonViewModel

@synthesize data=_data;
@synthesize domain=_domain;
@synthesize courseid=_courseid;
@synthesize lessonid=_lessonid;
@synthesize userid=_userid;
@synthesize state=_state;


void (^fnsuccess)(NSDictionary *);
void (^fnfaliure)(NSError *);

//api func

-(void)getDataQueryDomain:(NSString*)domain forUserId: (NSNumber*)userid withCourseId:(NSString*)courseid andLessonId:(NSString*)lessonid OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{
    
    self.domain=domain;
    fnsuccess=success;
    self.userid=userid;
    fnfaliure=faliure;
    self.lessonid=lessonid;
    self.courseid=courseid;
    
    self.data = [[NSMutableDictionary alloc]init];
    
    [self.data setValue:courseid forKey:@"courseId"];

    [self.data setValue:lessonid forKey:@"lessonId"];
    
    self.state=APP_DATA;
    
    [LmsConnectionRestApi lmsGetAppDataFrom:self.domain dictionaryModified:nil callBackTarget:self ];
}

// event funcs

- (void) didReceiveData:(NSData *)data{
    
    if(self.state==APP_DATA){
        
        [self proccessAppData:data];
        
        self.state=LESSON_DATA;
        
        [LmsConnectionRestApi lmsCourseDataFrom:self.domain withId:self.courseid callBackTarget:self];
      
    }else if(self.state==LESSON_DATA){
        
        [self proccessLessonData:data];
        
        self.state=SEQ_DATA;
        
        [LmsConnectionRestApi lmsGetCourseLessonFrom:self.domain courseId:self.courseid lessonCid:self.lessonid  callBackTarget:self];
   
    }else/*if(self.state==SEQ_DATA)*/{
    
     [self proccessSeqData:data];
    
     fnsuccess(self.data);
    }
    
}

- (void) didFailWithError:(NSError *)error{
     fnfaliure(error);
}

- (void) didReceiveResponse:(NSURLResponse *)response{
    
}

- (void) didFinishLoading{
    
}

//data proccecing - h funcs 
- (void) proccessAppData:(NSData *)data{
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
    
    
    [self.data setValue:user forKeyPath:@"user"];
    
   
}

- (void) proccessLessonData:(NSData *)data{
    
    NSError *error;
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers error:&error];
    
    NSDictionary *tocDic = [[(NSDictionary*)dic valueForKey:@"data"] valueForKey:@"toc" ];
    
    NSArray *chapters = [tocDic valueForKey:@"tocItems"];
    
    //can be optimized by passing chapter id from the client     
    for(NSDictionary* chapter in chapters){
        
    NSArray *lessons = [chapter valueForKey:@"lessons"];
    
    for(NSDictionary *lesson in lessons)
        {
            if([self.lessonid isEqualToString:[lesson valueForKey:@"cid"]])
            {
                [self.data setValue:[lesson valueForKey:@"title"] forKey:@"lessonTitle"];
            
                NSString * overview  = [lesson valueForKey:@"overview"];
                [self.data setValue:overview?overview:@"non" forKey:@"lessonOverview"];
            }
        }
    }
}

- (void) proccessSeqData:(NSData *)data{
    NSError *error;
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    
    NSArray *resources = [[dic valueForKey:@"data"] valueForKey:@"resources" ];
    
    NSArray *learningObjects = [[dic valueForKey:@"data"] valueForKey:@"learningObjects" ];
    
    NSMutableArray *sequencesToAdd=[[NSMutableArray alloc]init];
    
    for (NSDictionary* lo in learningObjects){
    
    
    NSArray *sequences =[lo valueForKey:@"sequences"];
    
    for(NSDictionary* seq in sequences){
        
        NSMutableDictionary* seqToAdd=[[NSMutableDictionary alloc]init];
        
        [seqToAdd setValue:[seq valueForKey:@"cid"] forKey:@"cid"];
        [seqToAdd setValue:[seq valueForKey:@"title"] forKey:@"title"];
        
        //array of res
        [seqToAdd setValue:[seq valueForKey:@"resourceRefId"] forKey:@"resourceRefId"];
        
        NSString* thumbnailRef = [seq objectForKey:@"thumbnailRef"];
        
        NSMutableString* subUrl=[[NSMutableString alloc]init];
        
        [subUrl appendString:self.domain];
        
        [subUrl appendString:@"/persistent/data/shared/cms/courses/"];
        
        [subUrl appendString:self.courseid];

        for(NSDictionary* res in resources){
            if([[res valueForKey:@"href"]isEqualToString:thumbnailRef]){
                [subUrl appendString:@"/"];
                [subUrl appendString:[res valueForKey:@"resId"]];
                break;
            }
        }
        
        [seqToAdd setValue:subUrl forKey:@"thumbnailUrl"];
        
        [sequencesToAdd addObject:seqToAdd];
    }

}
[self.data setValue:sequencesToAdd forKey:@"sequences"];
}


@end
