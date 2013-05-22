//
//  HomeViewModel.m
//  LmsRestConector
//
//  Created by alex zaikman on 5/19/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "HomeViewModel.h"
#import "CalableLmsClient.h"
#import "LmsConnectionRestApi.h"



@interface HomeViewModel()<CalableLmsClient>

typedef enum{
    APP_DATA,
    CLASSES
}State;

 
@property (nonatomic,assign) State state;
@property (nonatomic,strong) NSString *domain;
@property (nonatomic,strong) NSMutableDictionary* data;



@end

@implementation HomeViewModel

void (^fnsuccess)(NSDictionary *);
void (^fnfaliure)(NSError *);

@synthesize state=_state;
//@synthesize fnsuccess=_fnsuccess;
//@synthesize fnfaliure=_fnfaliure;
@synthesize data=_data;
@synthesize domain=_domain;


-(void)getDataQueryDomain:(NSString*)domain OnSuccessCall:(void (^)(NSDictionary *)) success onFailureCall:(void (^)(NSError*)) faliure{

    self.domain=domain;
    fnsuccess=success;
    fnfaliure=faliure;
    
    self.data = [[NSMutableDictionary alloc]init];
    self.state =APP_DATA;
    
    [LmsConnectionRestApi lmsGetAppDataFrom:self.domain dictionaryModified:nil callBackTarget:self ];
    
    
}



- (void) didReceiveData:(NSData *)data{
    
    if(self.state==APP_DATA){
        
        //parce first responce... 
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
        
        
        self.state=CLASSES;
        
        [LmsConnectionRestApi lmsGetTeacherStudyClassesFrom:self.domain teacherId:[[self.data valueForKey:@"user"]valueForKey:@"userId"] callBackTarget:self];
        
        
    }
    else if(self.state==CLASSES){
    
        
        
        
        NSError *error;
        NSArray* arr = [NSJSONSerialization JSONObjectWithData:data
                                                            options:NSJSONReadingMutableContainers error:&error];
        
        NSMutableArray* classes = [[NSMutableArray alloc]initWithCapacity:[arr count]];

        
        for(NSDictionary* dic in arr){
          
            NSMutableDictionary *class = [[NSMutableDictionary alloc]init];
            
            
            //set class
            [class setValue:[dic valueForKey:@"id"] forKey:@"classId"];
            [class setValue:[dic valueForKey:@"name"] forKey:@"className"];
            
            
            NSMutableString *imgUrl = [[NSMutableString alloc]init];
         
            
            [imgUrl appendString:@"lms/rest/schools/"];
            [imgUrl appendString:[[dic valueForKey:@"schoolId"]stringValue]];
            [imgUrl appendString:@"/images/"];
            [imgUrl appendString:[[dic valueForKey:@"imageId"]stringValue]];
            
            
            [class setValue:imgUrl forKey:@"imageURL"];
            
            [classes addObject:class];
            
        }
        
    [self.data setValue:classes forKey:@"classes"];
        
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
