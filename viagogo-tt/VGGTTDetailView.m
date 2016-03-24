//
//  VGGTTDetailView.m
//  viagogo-tt
//
//  Created by Daniel-Ernest Luff on 23/03/2016.
//  Copyright © 2016 toutright. All rights reserved.
//
int loopCount;
NSTimer *timer;

#import <Foundation/Foundation.h>
#import "VGGTTDetailView.h"

@implementation VGGTTDetailView
@synthesize responseData;

#pragma mark - init

- (id)initWithDeets:(VGGTTCountryDeets *)deets {
    self = [super init];
    if (self) {
        self.countryData = deets;
    }
    return self;
}

#pragma mark - view loading

- (void)viewDidLoad {
    [super viewDidLoad];
    [self borderLoad];
    [_borderTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"borderCell"];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = [self.countryData valueForKey:@"name"];
    NSString *title = [NSString stringWithFormat:@"%@ - %@", [self.countryData valueForKey:@"name"], [self.countryData valueForKey:@"nativeName"]];
    self.countryNameAlt.text = [[self.countryData valueForKey:@"altSpellings"]lastObject];
    self.countryNameTitle.text = title;
    self.dialingCode.text = [[self.countryData valueForKey:@"callingCodes"]lastObject];
    self.tld.text = [[self.countryData valueForKey:@"topLevelDomain"]lastObject];
    if ([self.countryData valueForKey:@"timezones"] != [NSNull null] ) {
        self.timezone.text = [[self.countryData valueForKey:@"timezones"]lastObject];
    } else {
        self.timezone.text = @"-";
            }
    self.currency.text = [[self.countryData valueForKey:@"currencies"]lastObject];
    NSString *continent = [NSString stringWithFormat:@"%@", [self.countryData valueForKey:@"region"]];
    [self.contientsButton setTitle:continent forState:UIControlStateNormal];
    NSString *rawAddress = [NSString stringWithFormat:@"http://www.geonames.org/flags/x/%@.gif", [self.countryData valueForKey:@"alpha2Code"]];
    NSString *lowerCaseAddress = [rawAddress lowercaseString];
    NSURL *imgURL = [NSURL URLWithString:lowerCaseAddress];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:imgURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            UIImage *img = [[UIImage alloc] initWithData:data];
            self.flag.image = img;
            //NSLog(@"%@",response);
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Something went wrong, please try again later! Code:DVFlagCall" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
            NSLog(@"%@",connectionError);
        }
    }];
    self.contientsButton.enabled = FALSE;
    [self.contientsButton setTitle:[self.countryData valueForKey:@"region"] forState:UIControlStateNormal];
    self.contientsButton.enabled = TRUE;
    [self.contientsButton setNeedsLayout];
}

#pragma mark - border table view

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    VGGTTCountryDeets *countryDeets = [VGGTTCountryDeets sharedCDManager];
    return [[self.countryData valueForKey:@"borders"]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"borderCell";
    
    UITableViewCell *cell = [_borderTable dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    UILabel *countryNameLabelDetail = (UILabel *)[cell viewWithTag:110];
    countryNameLabelDetail.text = _countryName[indexPath.row];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.backgroundColor = [UIColor darkGrayColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:16];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.text = _countryName[indexPath.row];
    });return cell;
}


- (void)borderLoad {
    NSString * borderMerge = [[[self.countryData valueForKey:@"borders"] valueForKey:@"description"] componentsJoinedByString:@";"];
    responseData = [NSMutableData data];
    NSString *rawAddress = [NSString stringWithFormat:@"https://restcountries.eu/rest/v1/alpha?codes=%@", borderMerge];
    NSString *lowerCaseAddress = [rawAddress lowercaseString];
    NSURLRequest *request = [NSURLRequest requestWithURL:
                             [NSURL URLWithString:lowerCaseAddress]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog([NSString stringWithFormat:@"Connection failed: %@", [error description]]);
    [[[UIAlertView alloc] initWithTitle:@"Ooops" message:@"Something went wrong, please try again later! Code:DVInfoCall" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil] show];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSError *myError = nil;
    NSArray *resonse = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    //NSLog(@"%@", self.responseData);
    _borderFullDataEntry = resonse;
    _countryName = [resonse valueForKey:@"name"];
    [_borderTable reloadData];
    
    
}

#pragma mark - table view interactions

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VGGTTCountryDeets *receipt = [_borderFullDataEntry objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    
    VGGTTDetailView *controller = [storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    
    controller.countryData = receipt;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - filter by continent

- (IBAction)filterByContinent:(id)sender {
    
    VGGTTCountryDeets *countryDeets = [VGGTTCountryDeets sharedCDManager];
    [countryDeets countryLoad:[self.countryData valueForKey:@"region"]];
    
    
}

@end