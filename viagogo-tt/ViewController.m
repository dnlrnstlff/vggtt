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

@interface ViewController ()

@end

@implementation ViewController
@synthesize responseData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedLoading:) name:kFinishedLoading object:nil];
}

- (IBAction)finishedLoading:(id)sender {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.tableView reloadData];
    });
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

    //UIImageView *flag = (UIImageView *)[cell viewWithTag:103];
    //NSData *imageData = [[NSData alloc] initWithContentsOfURL:countryDeets.pictureURL[indexPath.row]]];
    //flag.image = [UIImage imageWithData:countryDeets.pictureURL[indexPath.row]];
    
    UILabel *countryNameLabel = (UILabel *)[cell viewWithTag:101];
    countryNameLabel.text = countryDeets.username[indexPath.row];
    UILabel *populationLabel = (UILabel *)[cell viewWithTag:102];
    populationLabel.text = [NSString stringWithFormat:@"Pop: %@", countryDeets.population[indexPath.row]];
    UILabel *regionLabel = (UILabel *)[cell viewWithTag:104];
    regionLabel.text = countryDeets.username[indexPath.row];


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
}

@end
