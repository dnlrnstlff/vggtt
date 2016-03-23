//
//  ViewController.m
//  viagogo-tt
//
//  Created by Daniel-Ernest Luff on 22/03/2016.
//  Copyright © 2016 toutright. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "VGGTTCountryDeets.h"
#import "VGGTTDetailView.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedLoading:) name:kFinishedLoading object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedLoading:) name:kContinentFilter object:nil];

}

- (void)finishedLoading:(NSNotification*)notification {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.tableView reloadData];
    });
}

- (void)setConFilter:(NSNotification*)notification {
    self.filter = [notification object];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    VGGTTCountryDeets *countryDeets = [VGGTTCountryDeets sharedCDManager];
    return countryDeets.entryCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"cell";
    VGGTTCountryDeets *countryDeets = [VGGTTCountryDeets sharedCDManager];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSString *filter = self.filter;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY type like %@", filter];
    NSArray *results = [countryDeets.fullDataEntry filteredArrayUsingPredicate:predicate];
    
    UIImageView *flag = (UIImageView *)[cell viewWithTag:103];
    NSString *rawAddress = [NSString stringWithFormat:@"http://www.geonames.org/flags/x/%@.gif", [results valueForKey:@"alpha2Code"][indexPath.row]];
    NSString *lowerCaseAddress = [rawAddress lowercaseString];
    NSURL *imgURL = [NSURL URLWithString:lowerCaseAddress];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:imgURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            UIImage *img = [[UIImage alloc] initWithData:data];
            flag.image = img;
            //NSLog(@"%@",response);
        } else {
             [[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Something went wrong, please try again later! Code:TVFlagCall" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
            NSLog(@"Error: %@", connectionError);
        }
    }];
    
    UILabel *countryNameLabel = (UILabel *)[cell viewWithTag:101];
    countryNameLabel.text = [results valueForKey:@"name"][indexPath.row];
    UILabel *populationLabel = (UILabel *)[cell viewWithTag:102];
    populationLabel.text = [NSString stringWithFormat:@"Pop: %@", [results valueForKey:@"population"][indexPath.row]];
    UILabel *regionLabel = (UILabel *)[cell viewWithTag:104];
    regionLabel.text = [results valueForKey:@"region"][indexPath.row];


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get reference to receipt
    VGGTTCountryDeets *countryDeets = [VGGTTCountryDeets sharedCDManager];
    VGGTTCountryDeets *receipt = [countryDeets.fullDataEntry objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                  bundle:nil];
    
    VGGTTDetailView *controller = [storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    
    controller.countryData = receipt;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
