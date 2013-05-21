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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *chapters = (NSArray*)[self.data valueForKey:@"chapters"];
    NSUInteger index =  [indexPath indexAtPosition:[indexPath length]-1];
    NSDictionary *chapter = [chapters objectAtIndex:index];
    
    NSString *ovw = [chapter valueForKey:@"overview"];
    self.dataToPass = ovw;
    
    [self performSegueWithIdentifier:@"chapteroverview" sender:self];
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"chapteroverview"]){
        [segue.destinationViewController performSelector:@selector(setOverviewText:)
                                              withObject:self.dataToPass];

    }
}


@end





























