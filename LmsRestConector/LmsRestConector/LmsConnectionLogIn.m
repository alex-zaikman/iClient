//
//  LmsConnection.m
//  LmsRestConector
//
//  Created by alex zaikman on 5/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsConnectionLogIn.h"
#import "Connector.h"

@interface LmsConnectionLogIn() <CalableLmsClient>




@property (nonatomic,weak) id<CalableLmsClient> target;
@property (nonatomic,strong) NSString* domain;
@property (nonatomic,assign) LogState state;
@property (nonatomic,strong) Connector *connection;
@property (nonatomic,strong) NSMutableDictionary *vars;
@property (nonatomic,strong) NSString* user;
@property (nonatomic,strong) NSString* password;

-(void) collectDataForStep2:(NSString *)data;

@end

@implementation LmsConnectionLogIn

@synthesize target=_target;
@synthesize vars = _vars;
@synthesize domain=_domain;
@synthesize state=_state;
@synthesize connection=_connection;
@synthesize password=_password;
@synthesize user=_user;

-(void) collectDataForStep2:(NSString *)data{
    
    
    @try{
        
        
        //find action
        //<form id="fm1" class="myForm" action="/cas/login;jsessionid=20EA8F72F3C53BCC08E957169AC93DBE?service=https%3A%2F%2Fcto.timetoknow.com%2Flms%2F&amp;t2kRedirect=https%3A%2F%2Fcto.timetoknow.com%2Flms%2F" method="post">
        NSRange range = [data rangeOfString:@"action=\"" ];
        NSString*  action= [ data substringFromIndex:range.location+range.length];
        action  = [action substringToIndex:[action rangeOfString:@"\" method=" ].location];
        
        
        
        //find lt
        //<input type="hidden" name="lt" value="LT-55-2NTupLsLgFuri03y5SuYWMvZYaw6Lm" />
        range = [data rangeOfString:@"<input type=\"hidden\" name=\"lt\" value=\"" ];
        NSString*  lt= [ data substringFromIndex:range.location+range.length];
        lt  = [lt substringToIndex:[lt rangeOfString:@"\" />"].location];
        
        
        //find execution
        //<input type="hidden" name="execution" value="e1s1" />
        range = [data rangeOfString:@"<input type=\"hidden\" name=\"execution\" value=\"" ];
        NSString*  execution= [ data substringFromIndex:range.location+range.length];
        execution  = [execution substringToIndex:[execution rangeOfString:@"\" />" ].location];
        
        
        //find _eventId
        //<input type="hidden" name="_eventId" value="submit" />
        range = [data rangeOfString:@"<input type=\"hidden\" name=\"_eventId\" value=\"" ];
        NSString*  eventId= [ data substringFromIndex:range.location+range.length];
        eventId  = [eventId substringToIndex:[eventId rangeOfString:@"\" />" ].location];
        
        
        [self.vars setObject:action forKey:@"action"];
        [self.vars setObject:self.password forKey:@"password"];
        [self.vars setObject:self.user forKey:@"username"];
        [self.vars setObject:lt forKey:@"lt"];
        [self.vars setObject:execution forKey:@"execution"];
        [self.vars setObject:eventId forKey:@"_eventId"];
        
    }
    @catch(NSException * e){
        [self.target didFailWithError:nil];
    }
    

}


- (void) LogInTo:(NSString*)domain asUser:(NSString *)user withPassword:(NSString*)password callBackTarget:(id<CalableLmsClient>)target {
    
    self.target=target;

    self.domain=domain;
    
    self.state=STEP1;

    self.password = password;

    self.user =user;
    
    self.connection = [[Connector alloc]init];
    
    self.vars = [[NSMutableDictionary alloc]initWithCapacity:2];
    
    [self.connection sendGetTo:[self.domain stringByAppendingString:@"/lms"] withVariable:self.vars callBack:self];
    
}

- (void) didReceiveData:(NSData *)data{
    if(self.state==STEP1){
        [self.vars removeAllObjects];
        [self collectDataForStep2:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]];
    }
    if (self.state==STEP2){
                [self.target didReceiveData:data];
    }
}

- (void) didFailWithError:(NSError *)error{
        [self.target didFailWithError:error];
}


- (void) didFinishLoading{
    if(self.state==STEP1){
        
        //pop action
        NSString* action = [self.vars objectForKey:@"action"];
        [self.vars removeObjectForKey:@"action"];
        
        self.state=STEP2;
        
        [self.connection sendPostTo:[self.domain stringByAppendingString: action  ] withVariable:self.vars callBack:self];
        
    }else if (self.state==STEP2){
        [self.target didFinishLoading];
        
    }
}

- (void) didReceiveResponse:(NSURLResponse *)response{
   if (self.state==STEP2)
       [self.target didReceiveResponse:response];
}





@end
