//
//  UserModel.m
//  LmsRestConector
//
//  Created by alex zaikman on 5/16/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "UserModel.h"
#import "LmsConnectionRestApi.h"
#import "CalableLmsClient.h"

@interface UserModel ()<CalableLmsClient>

typedef enum{
    APP_DATA,
    STUDY_CLASSES
    
    
}ControlState;

@property (nonatomic,assign) ControlState state;

-(void)parseAppData;

@end

@implementation UserModel




@synthesize sureName=_sureName;
@synthesize familyName=_familyName;
@synthesize userid=_userid;
//@synthesize courses=_courses;
@synthesize title=_title;
@synthesize role=_role;
@synthesize logouturl=_logouturl;
@synthesize domain=_domain;
@synthesize state=_state;
@synthesize userName=_userName;
@synthesize schoolid=_schoolid;
@synthesize schoolName = _schoolName;
@synthesize districtid =_districtid;


-(id)initWithDomin: (NSString *)dom{

if(self = [super init]){
    
    _domain=dom;
    
    [self parseAppData];
    
    return self;
}else{
    return nil;
    }
}





-(void)parseAppData{
    
    self.state = APP_DATA;
    [LmsConnectionRestApi lmsGetAppDataFrom:self.domain dictionaryModified:nil callBackTarget:self ];   

}



- (void) didReceiveData:(NSData *)data;{
   
    if(self.state==APP_DATA){
        
        NSError *error;
        NSDictionary * appdatajson = [NSJSONSerialization JSONObjectWithData:data
                            options:NSJSONReadingMutableContainers error:&error] ;
        
        self.logouturl = [appdatajson valueForKey:@"logoutUrl"];
        
        
        NSDictionary * user = [appdatajson valueForKey:@"user"];
        
        
        self.userid = [user objectForKey:@"id"];
        
        self.title = [user objectForKey:@"title"];
        
        self.sureName = [user objectForKey:@"firstName"];
        
        self.familyName=[user objectForKey:@"lastName"];

        //self.courses=;

        self.role=[user objectForKey:@"roles"];

        self.userName=[user objectForKey:@"userName"];
        
        self.schoolid=[user objectForKey:@"schoolId"];
        
        NSDictionary * school = [appdatajson valueForKey:@"school"];
        
        self.schoolName =  [school objectForKey:@"name"];
        
        self.districtid =  [school objectForKey:@"districtId"];
        
    }
    
    
    
    
    
}

- (void) didFailWithError:(NSError *)error{
    
}

- (void) didReceiveResponse:(NSURLResponse *)response{
    
}

- (void) didFinishLoading{
    
}
@end
