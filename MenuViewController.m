//
//  MenuViewController.m
//  LmsClient
//
//  Created by alex zaikman on 5/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "MenuViewController.h"
#import "CalableLmsClient.h"
#import "PresentorViewController.h"
#import "LmsConnectionRestApi.h"


@interface MenuViewController ()<CalableLmsClient>

@property NSData *data;

@end

@implementation MenuViewController

@synthesize data=_data;




- (IBAction)getStudyClasses {
    
    [LmsConnectionRestApi lmsGetAppDataFrom:@"https://cto.timetoknow.com" dictionaryModified:nil callBackTarget:self ];
}

-(void) didReceiveResponse:(NSURLResponse *)response{
    
}
-(void)didReceiveData:(NSData *)data{
    self.data = data;
}

-(void)didFailWithError:(NSError *)error{
    

}
-(void)didFinishLoading{
     [self performSegueWithIdentifier:@"JSONPresentor" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"JSONPresentor"]) {
            [segue.destinationViewController setJsonData:self.data ];
        }
}


- (IBAction)debug {
    
  //  UserModel* model = [[UserModel alloc]initWithDomin:@"https://cto.timetoknow.com"];
    
                    
}



@end
