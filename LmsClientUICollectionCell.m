//
//  LmsClientUICollectionCell.m
//  LmsClient
//
//  Created by alex zaikman on 5/20/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientUICollectionCell.h"

@implementation LmsClientUICollectionCell

@synthesize lable=_lable;


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.lable = [[UILabel alloc]
                      initWithFrame:CGRectMake(10, 10, 190, 24)
                      ];
        
        self.lable.textColor = [UIColor blackColor];
        self.lable.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.lable];
    }
    return self;
}


@end
