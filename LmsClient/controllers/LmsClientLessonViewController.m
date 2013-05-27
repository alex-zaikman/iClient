//
//  LmsClientLessonViewController.m
//  LmsClient
//
//  Created by alex zaikman on 22/05/13.
//  Copyright (c) 2013 alex zaikman. All rights reserved.
//

#import "LmsClientLessonViewController.h"
#import "LmsClientTableViewCell.h"


@interface LmsClientLessonViewController ()

@end

@implementation LmsClientLessonViewController


@synthesize data=_data;

//@synthesize dataToPass=_dataToPass;


+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        if ([[UIScreen mainScreen] scale] == 2.0) {
            UIGraphicsBeginImageContextWithOptions(newSize, YES, 2.0);
        } else {
            UIGraphicsBeginImageContext(newSize);
        }
    } else {
        UIGraphicsBeginImageContext(newSize);
    }
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.data valueForKey:@"sequences"]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    LmsClientTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text= [(NSDictionary*)[(NSArray*)[self.data valueForKey:@"sequences"] objectAtIndex:[indexPath indexAtPosition:[indexPath length]-1 ]] valueForKey:@"title" ];
    
    cell.textLabel.contentMode = UIViewContentModeScaleAspectFit;
    
    
    NSString *url = [(NSDictionary*)[(NSArray*)[self.data valueForKey:@"sequences"] objectAtIndex:[indexPath indexAtPosition:[indexPath length]-1 ]] valueForKey:@"thumbnailUrl" ];
    
   
    NSURL *bgImageURL = [NSURL URLWithString:url];
    NSData *bgImageData = [NSData dataWithContentsOfURL:bgImageURL];
    
    cell.imageView.image =     [ LmsClientLessonViewController  imageWithImage:[UIImage imageWithData:bgImageData] scaledToSize:CGSizeMake(300,200)] ;
    
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LmsClientTableViewCell *currentCell = (LmsClientTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
    
    //TODO: get and set data
    
    [self performSegueWithIdentifier:@"lowebview" sender:self];

    
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if([[segue identifier] isEqualToString:@"lowebview"]){
        
        //TODO pass data to LmsClientLessonOverviewWebViewController controller
        
       // [segue.destinationViewController performSelector:@selector(errorMsgToDisplay:)
         //                                     withObject:self.errMsg];

    }
}
@end


















