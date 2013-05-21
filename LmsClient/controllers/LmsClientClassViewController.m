//
//  LmsClientClassViewController.m
//  LmsClient
//
//  Created by alex zaikman on 5/19/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientClassViewController.h"
#import "LmsClientUICollectionCell.h"
#import "CourseViewModel.h"

@interface LmsClientClassViewController()

@property (nonatomic,strong) CourseViewModel *cvm;
@property (nonatomic,strong) NSError *errMsg;
@property (nonatomic,strong) NSDictionary *dataToPass;

@end

@implementation LmsClientClassViewController

@synthesize data=_data;
@synthesize cvm=_cvm;
@synthesize errMsg=_errMsg;
@synthesize dataToPass=_dataToPass;



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
  
     NSString *className = (NSString*)[(NSDictionary*)[(NSArray*)[self.data valueForKey:@"classes"] objectAtIndex:indexPath.item] valueForKey:@"className"];

    cell.lable.text = className;
    
    NSArray *classes = (NSArray*)[self.data valueForKey:@"classes"];
    NSUInteger index =  [indexPath indexAtPosition:[indexPath length]-1];
    NSDictionary *class = [classes objectAtIndex:index];
    NSNumber *cid = [class valueForKey:@"classId"];
    
    
    cell.tag =[cid integerValue] ;
    
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *currentCell = [collectionView cellForItemAtIndexPath:indexPath];
    
    self.cvm = [[CourseViewModel alloc]init];
    
    NSDictionary * usr= [self.data valueForKey:@"user"];
    
    
    NSNumber *cid = [[NSNumber alloc] initWithInt: currentCell.tag];
    NSNumber *uid =[usr valueForKey:@"userId" ];
    NSString *dom = [[NSUserDefaults standardUserDefaults] stringForKey:@"domain_preference"];
    
    
    

    
    [self.cvm getDataQueryDomain:dom
                    curentUserId:uid
                     forClassId:cid
                    OnSuccessCall:
     ^(NSDictionary *dic ){
         if(dic == nil)
                [self performSegueWithIdentifier:@"nocourse" sender:self];
         else{
             self.dataToPass = dic;
             [self performSegueWithIdentifier:@"course" sender:self];
             [self performSegueWithIdentifier:@"courseMaster" sender:self];
         }
     }
                   onFailureCall:
     ^(NSError *e){
         self.errMsg = e;
         [self performSegueWithIdentifier:@"error" sender:self];
          }
     ];
    
    // TODO: Select Item
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"error"]){
        [segue.destinationViewController performSelector:@selector(errorMsgToDisplay:)
                                              withObject:self.errMsg];

    }else if([[segue identifier] isEqualToString:@"course"] || [[segue identifier] isEqualToString:@"courseMaster"] ){
        [segue.destinationViewController performSelector:@selector(setData:)
                                              withObject:self.dataToPass];
        
    }
}

@end
