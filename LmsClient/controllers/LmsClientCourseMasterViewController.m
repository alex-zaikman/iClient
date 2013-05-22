//
//  LmsClientCourseMasterViewController.m
//  LmsClient
//
//  Created by alex zaikman on 5/20/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientCourseMasterViewController.h"

@interface LmsClientCourseMasterViewController ()

@property (nonatomic,strong) NSString *dataToPass;

@end

@implementation LmsClientCourseMasterViewController

@synthesize data=_data;
@synthesize dataToPass=_dataToPass;

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* chapters = [self.data valueForKey:@"chapters"];
    return [chapters count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    NSArray *chapters = (NSArray*)[self.data valueForKey:@"chapters"];
    NSUInteger index =  [indexPath indexAtPosition:[indexPath length]-1];
    NSDictionary *chapter = [chapters objectAtIndex:index];
    
    NSString *title = [chapter valueForKey:@"title"];
    
    
    cell.textLabel.text = title;
    cell.tag = index;
    
    
    return cell;
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *chapters = (NSArray*)[self.data valueForKey:@"chapters"];
    NSUInteger index =  [indexPath indexAtPosition:[indexPath length]-1];
    NSDictionary *chapter = [chapters objectAtIndex:index];
    
    NSString *ovw = [chapter valueForKey:@"overview"];
    self.dataToPass = ovw;
    
    [self performSegueWithIdentifier:@"chapteroverview" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"chapteroverview"]){
        [segue.destinationViewController performSelector:@selector(setOverviewText:)
                                              withObject:self.dataToPass];

    }
}


@end





























