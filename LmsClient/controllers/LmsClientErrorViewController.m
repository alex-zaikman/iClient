//
//  LmsClientErrorViewController.m
//  LmsClient
//
//  Created by alex zaikman on 5/21/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientErrorViewController.h"

@interface LmsClientErrorViewController ()

@property (weak, nonatomic) IBOutlet UITextView *errorMsg;

@end

@implementation LmsClientErrorViewController

@synthesize errorMsg=_errorMsg;

-(void) errorMsgToDisplay: (NSError*)err{
    self.errorMsg.text=[err localizedDescription];
}

@end
