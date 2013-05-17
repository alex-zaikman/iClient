//
//  ClassesViewModel.m
//  LmsRestConector
//
//  Created by alex zaikman on 5/16/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "ClassesViewModel.h"
#import "CalableLmsClient.h"
#import "LmsConnectionRestApi.h"
#import "RestCallableClient.h"

@interface ClassesViewModel()<CalableLmsClient>

@property (nonatomic,strong) NSDictionary *classesView;

typedef enum{
  APP_DATA,
  CLASSES
}State;


@property (nonatomic,assign) State state;
@property (nonatomic,weak) id<RestCallableClient> callback;
@property(nonatomic,strong) NSString *domain;

@end


@implementation ClassesViewModel

@synthesize classesView=_classesView;
@synthesize state=_state;
@synthesize callback=_callback;
@synthesize domain=_domain;


-(id)initWithDomain: (NSString*)domain callback: (id<RestCallableClient>) callback{

    if(self = [super init]){
        
        self.state=APP_DATA;
        self.callback = callback;
        self.domain=domain;

          [LmsConnectionRestApi lmsGetAppDataFrom:self.domain dictionaryModified:nil callBackTarget:self ];
        
        return self;
    }else{
        return nil;
    }
}








- (void) didReceiveData:(NSData *)data{
    
    
    if(self.state==APP_DATA){
        //collect
        self.state=CLASSES;        //issue studyclasses req
    }
    if(self.state==CLASSES){
        //collect urls for images
        //advance state
        //call user call back
       // [self.callback sucsses:<#(NSDictionary *)#>]
    }
    
    
}

- (void) didFailWithError:(NSError *)error{
    
}

- (void) didReceiveResponse:(NSURLResponse *)response{
    
}

- (void) didFinishLoading{
    
}
@end
