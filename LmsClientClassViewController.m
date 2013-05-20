//
//  LmsClientClassViewController.m
//  LmsClient
//
//  Created by alex zaikman on 5/19/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientClassViewController.h"
#import "LmsClientUICollectionCell.h"

@implementation LmsClientClassViewController

@synthesize data=_data;
@synthesize sayHello=_sayHello;

-(void)viewDidLoad{
    [self.collectionView registerClass:[LmsClientUICollectionCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    
    return [(NSArray*)[self.data valueForKey:@"classes"]count];
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    LmsClientUICollectionCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    NSString *url = (NSString*)[(NSDictionary*)[(NSArray*)[self.data valueForKey:@"classes"] objectAtIndex:indexPath.item] valueForKey:@"imageURL"];
    
    url = [[[NSUserDefaults standardUserDefaults] stringForKey:@"domain_preference"] stringByAppendingString: [@"/" stringByAppendingString:url]];
  
    
    
    NSURL *bgImageURL = [NSURL URLWithString:url];
    NSData *bgImageData = [NSData dataWithContentsOfURL:bgImageURL];
    UIImage *img = [UIImage imageWithData:bgImageData];
    
    [cell setBackgroundColor: [UIColor colorWithRed:255/255.0f green:237/255.0f blue:108/255.0f alpha:1.0f]];


     
    [cell setBackgroundView:[[UIImageView alloc]initWithImage:img]];

    
//      NSString *fname = (NSString*)[(NSDictionary*)[self.data valueForKey:@"user"] valueForKey:@"firstName"];
//    
//      NSString *lname = (NSString*)[(NSDictionary*)[self.data valueForKey:@"user"] valueForKey:@"lastName"];

  
     NSString *className = (NSString*)[(NSDictionary*)[(NSArray*)[self.data valueForKey:@"classes"] objectAtIndex:indexPath.item] valueForKey:@"className"];

    cell.lable.text = className;
    
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // TODO: Select Item
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Deselect item
}

@end
