//
//  LmsClientErrorViewController.h
//  LmsClient
//
//  Created by alex zaikman on 5/21/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LmsClientErrorViewController : UIViewController

-(void) errorMsgToDisplay: (NSError*)err;
@end
