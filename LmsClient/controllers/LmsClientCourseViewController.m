//
//  LmsClientCourseViewController.m
//  LmsClient
//
//  Created by alex zaikman on 5/20/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientCourseViewController.h"
#import "LessonViewModel.h"


@interface LmsClientCourseViewController()

@property (nonatomic,strong) NSDictionary *dataToPass;
@property (nonatomic,strong) NSMutableDictionary *lessonTtoID;
@property (nonatomic,strong) LessonViewModel *lvm;
@property (nonatomic,strong) NSError *errMsg;
@property (nonatomic,strong) NSDictionary *subDataToPass;

@end


@implementation LmsClientCourseViewController

@synthesize data=_data;
@synthesize dataToPass=_dataToPass;
@synthesize lessonTtoID=_lessonTtoID;
@synthesize lvm=_lvm;
@synthesize errMsg=_errMsg;
@synthesize subDataToPass=_subDataToPass;


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray* chapters = [self.data valueForKey:@"chapters"];
    return [chapters count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* chapters = [self.data valueForKey:@"chapters"];
    NSArray* lessons = [[chapters objectAtIndex:section] valueForKey:@"lessons"];
    return [lessons count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    
    NSArray *chapters = (NSArray*)[self.data valueForKey:@"chapters"];
   
    NSDictionary *chapter = [chapters objectAtIndex:section];
    
    NSString *title = [chapter valueForKey:@"title"];
    
    return title;
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSArray *chapters = (NSArray*)[self.data valueForKey:@"chapters"];
    
    NSUInteger section = indexPath.section;
    
    NSUInteger index =  [indexPath indexAtPosition:[indexPath length]-1];
    
    NSDictionary *chapter = [chapters objectAtIndex:section];
    
    NSArray *lessons = [chapter valueForKey:@"lessons"];
    
    NSString *title = [[lessons objectAtIndex:index ]valueForKey:@"title"];
    
    if(!self.lessonTtoID)
        self.lessonTtoID= [[NSMutableDictionary alloc]init];
    
    [self.lessonTtoID setValue:[[lessons objectAtIndex:index ]valueForKey:@"cid"] forKey:title];

    cell.textLabel.text = title;
    cell.tag = index;
    
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellText = cell.textLabel.text;
    
    NSString *lessonId = [self.lessonTtoID  valueForKey:cellText];
    
     NSString *dom = [[NSUserDefaults standardUserDefaults] stringForKey:@"domain_preference"];
    
    NSDictionary * usr= [self.data valueForKey:@"user"];

     NSNumber *uid =[usr valueForKey:@"userId" ];
    
    
   NSString *cid = [self.data valueForKey:@"courseId"];
    
    self.lvm = [[LessonViewModel alloc]init];

    [self.lvm getDataQueryDomain:dom forUserId: uid withCourseId:cid andLessonId:lessonId
     OnSuccessCall:
     ^(NSDictionary *dic){
         
             self.dataToPass=dic;
             [self performSegueWithIdentifier:@"lo" sender:self];
             [self performSegueWithIdentifier:@"lodescription" sender:self];
         
     }
    onFailureCall:
     ^(NSError *e){
         self.errMsg = e;
         [self performSegueWithIdentifier:@"error" sender:self];
     }
     ];
  

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"lo"]){
        [segue.destinationViewController performSelector:@selector(setData:)
                                              withObject:self.dataToPass];

    }else if([[segue identifier] isEqualToString:@"lodescription"]){
 
           self.subDataToPass = [[NSDictionary alloc]
          initWithObjectsAndKeys:
          (NSString*)[self.dataToPass valueForKey:@"lessonOverview"] , @"description",
          (NSString*)[self.dataToPass valueForKey:@"lessonTitle"],@"name",
           @"non",@"objectives",
           nil
        ];
        
        
        [segue.destinationViewController performSelector:@selector(setContent:)
                                                       withObject:self.subDataToPass];
    

    }

}


@end










