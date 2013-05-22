//
//  LmsClientTableViewCell.m
//  LmsClient
//
//  Created by alex zaikman on 22/05/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientTableViewCell.h"

@implementation LmsClientTableViewCell

@synthesize img=_img;
@synthesize title=_title;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        
         [self addSubview:self.img];
         [self addSubview:self.title];
        
    }
    return self;
}



@end
