//
//  LmsClientViewController.m
//  LmsClient
//
//  Created by alex zaikman on 5/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientViewController.h"
#import "LmsConnectionLogIn.h"


@interface LmsClientViewController ()<CalableLmsClient>
@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *pass;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *progress;


@property (weak, nonatomic) IBOutlet UITextField *status;


@property (strong,nonatomic) LmsConnectionLogIn* connection;


@end

@implementation LmsClientViewController

@synthesize status=_status;
@synthesize connection=_connection;
@synthesize pass=_pass;
@synthesize user=_user;
@synthesize progress=_progress;

- (IBAction)logIn {
    
    self.connection= [[LmsConnectionLogIn alloc]init];
    
    [self.connection LogInTo:@"https://cto.timetoknow.com" asUser:self.user.text withPassword:self.pass.text callBackTarget:self];
    [self.progress startAnimating];
    self.status.text=@"please wait......";
}


- (void) didFailWithError:(NSError *)error{
        self.status.text= error.debugDescription;
        [self.progress stopAnimating];

}


- (void) didFinishLoading{
    self.status.text=@"logged in";
    [self.progress stopAnimating];
    [self performSegueWithIdentifier:@"menu" sender:self];
    
    
}


- (IBAction)logOut {
      self.status.text=@"logged out (it is a dummy logout)";
    //TODO: call the appropriate rest api
}

-(void)didReceiveData:(NSData *)data{
//    self.debug.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

-(void)didReceiveResponse:(NSURLResponse *)response{
//   self.debug.text = [response debugDescription];
}

@end
