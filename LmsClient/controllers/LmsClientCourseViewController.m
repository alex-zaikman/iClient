//
//  LmsClientCourseViewController.m
//  LmsClient
//
//  Created by alex zaikman on 5/20/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientCourseViewController.h"

@interface LmsClientCourseViewController()

@property (nonatomic,strong) NSString *dataToPass;

@end


@implementation LmsClientCourseViewController

@synthesize data=_data;
@synthesize dataToPass=_dataToPass;


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
    
    
    cell.textLabel.text = title;
    cell.tag = index;
    
    
    return cell;
}



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   //TODO.....

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
//    if([[segue identifier] isEqualToString:@"lessonoverview"]){
//        [segue.destinationViewController performSelector:@selector(setOverviewText:)
//                                              withObject:self.dataToPass];
//
//    }
}


@end















