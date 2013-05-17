//
//  LmsConnection.h
//  LmsRestConector
//
//  Created by alex zaikman on 5/13/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CalableLmsClient.h"

@interface LmsConnectionLogIn : NSObject



typedef enum {
    STEP1,
    STEP2
} LogState;

/* domain should have https:// and no trailing /  */
- (void) LogInTo:(NSString*)domain asUser:(NSString *)user withPassword:(NSString*)password callBackTarget:(id<CalableLmsClient>)target;

// -(void) LogOut;  TODO call the rest api and logout
    


@end
