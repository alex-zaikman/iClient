//
//  UserModel.h
//  LmsRestConector
//
//  Created by alex zaikman on 5/16/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

//User:
@property (nonatomic,strong) NSString * domain;
@property (nonatomic,strong) NSString * sureName;
@property (nonatomic,strong) NSString * familyName;
@property (nonatomic,strong) NSNumber * userid;
//@property (nonatomic,strong) NSDictionary * courses;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,assign) NSArray * role;
@property (nonatomic,strong) NSString * logouturl;
@property (nonatomic,strong) NSString * userName;


//school:
@property (nonatomic,strong) NSNumber * schoolid;
@property (nonatomic,strong) NSString * schoolName;
@property (nonatomic,strong) NSNumber * districtid;


-(id)initWithDomin: (NSString *)dom;

@end
