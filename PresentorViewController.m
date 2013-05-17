//
//  PresentorViewController.m
//  LmsClient
//
//  Created by alex zaikman on 5/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "PresentorViewController.h"

@interface PresentorViewController()

@property (strong,nonatomic) NSData* jdata;

@property (weak, nonatomic) IBOutlet UITextView *rawOut;


@end


@implementation PresentorViewController

@synthesize rawOut=_rawOut;
@synthesize jdata=_jdata;


-(void) setJsonData:(NSData*)data{
    self.jdata=data;

}


- (IBAction)refresh:(id)sender {
    
    NSError *error;
    self.rawOut.text = [[NSJSONSerialization JSONObjectWithData:self.jdata
                                                       options:NSJSONReadingMutableContainers error:&error] description];
    
    [self.view setNeedsDisplay];
    
}

@end
