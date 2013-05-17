//
//  ClassesViewModel.m
//  LmsRestConector
//
//  Created by alex zaikman on 5/16/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "ClassesViewModel.h"
#import "CalableLmsClient.h"
@interface ClassesViewModel()<CalableLmsClient>

@property (nonatomic,strong) NSDictionary *classesView;

typedef enum{
  APP_DATA,
  CLASSES
}State;


@property (nonatomic,assign)State state;

@end


@implementation ClassesViewModel

@synthesize classesView=_classesView;
@synthesize state=_state;


-(id)init{

    if(self = [super init]){
        
        self.state=APP_DATA;
        //issue first request for appdata
        
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
    }
    
    
}

- (void) didFailWithError:(NSError *)error{
    
}

- (void) didReceiveResponse:(NSURLResponse *)response{
    
}

- (void) didFinishLoading{
    
}
@end
