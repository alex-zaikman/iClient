//
//  LmsClientLogInViewController.m
//  LmsClient
//
//  Created by alex zaikman on 5/19/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientLogInViewController.h"
#import "LmsConnectionLogIn.h"
#import "HomeViewModel.h"

@interface LmsClientLogInViewController()<CalableLmsClient>

@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *waitting;
@property (weak, nonatomic) IBOutlet UITextField *output;
@property (nonatomic,strong) NSDictionary *data;
@property (nonatomic,strong) HomeViewModel *hvm;

@end

@implementation LmsClientLogInViewController


@synthesize user=_user;
@synthesize pass=_pass;
@synthesize waitting=_waitting;
@synthesize output=_output;
@synthesize data=_data;
@synthesize hvm=_hvm;

- (IBAction)logIn {
 
    LmsConnectionLogIn *log = [[LmsConnectionLogIn alloc]init];
    
    [self.waitting startAnimating];
    [log LogInTo:[[NSUserDefaults standardUserDefaults] stringForKey:@"domain_preference"] asUser:self.user.text withPassword:self.pass.text callBackTarget:self];
    
}
                                                       
                                                  
                                                       
-(void) didReceiveData:(NSData *)data{
  


}


- (void) didFailWithError:(NSError *)error{
   
    [self.waitting stopAnimating];
    self.output.text=@"error: please check yor credentials, you web connection and try again.";
    
}
                                                       
- (void) didReceiveResponse:(NSURLResponse *)response{
}


- (void )qqq:( NSError *)dddd{}

- (void) didFinishLoading{
  
    [self.waitting stopAnimating];
    self.output.text=@"you are logged in";

    self.hvm = [[HomeViewModel alloc]init];
    

    [self.hvm getDataQueryDomain:[[NSUserDefaults standardUserDefaults] stringForKey:@"domain_preference"] OnSuccessCall:
    
     ^(NSDictionary *dic ){
         self.data = dic;
         [self performSegueWithIdentifier:@"classes" sender:self];
       //  [self performSegueWithIdentifier:@"table" sender:self];
         
         
     }
    onFailureCall:
     ^(NSError *e){
         [self didFailWithError:e];
     }
     ];
        
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"classes"])
    {
        [segue.destinationViewController performSelector:@selector(setData:)
                                              withObject:self.data];
        
        
        
             NSString *fname = (NSString*)[(NSDictionary*)[self.data valueForKey:@"user"] valueForKey:@"firstName"];
        
            NSString *lname = (NSString*)[(NSDictionary*)[self.data valueForKey:@"user"] valueForKey:@"lastName"];
        
        
        NSString *greet = [@"Welcome " stringByAppendingString:[lname stringByAppendingString:fname]];
        
        [segue.destinationViewController performSelector:@selector(setSayHello:)
                                              withObject:greet];
        
        
    }
}
    


@end
