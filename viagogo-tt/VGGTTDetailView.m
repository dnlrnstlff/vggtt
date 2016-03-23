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

- (id)initWithDeets:(VGGTTCountryDeets *)deets {
    self = [super init];
    if (self) {
        self.countryData = deets;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
       [self borderLoad];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"borderCell"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedLoading:) name:kFinishedLoading object:nil];
}

- (IBAction)finishedLoading:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tableView reloadData];
        [tableView reloadInputViews];
        NSLog(@"Finished11");
            
            
        });});
    dispatch_async(dispatch_get_main_queue(), ^{
        [tableView reloadInputViews];
        NSArray *indexArray = [_borderTable indexPathsForVisibleRows];
        [tableView reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationFade];
        NSLog(@"Finished");
    });
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = [self.countryData valueForKey:@"name"];
    self.countryNameAlt.text = [self.countryData valueForKey:@"name"];
    self.countryNameTitle.text = [[self.countryData valueForKey:@"altSpellings"]lastObject];
    NSString *rawAddress = [NSString stringWithFormat:@"http://www.geonames.org/flags/x/%@.gif", [self.countryData valueForKey:@"alpha2Code"]];
    NSString *lowerCaseAddress = [rawAddress lowercaseString];
    NSURL *imgURL = [NSURL URLWithString:lowerCaseAddress];
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:imgURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (!connectionError) {
            UIImage *img = [[UIImage alloc] initWithData:data];
            self.flag.image = img;
            //NSLog(@"%@",response);
        }else{
            NSLog(@"%@",connectionError);
        }
    }];

    [_borderTable reloadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_borderTable setNeedsDisplay];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    VGGTTCountryDeets *countryDeets = [VGGTTCountryDeets sharedCDManager];
    return [[self.countryData valueForKey:@"borders"]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"borderCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        cell.textLabel.text = _countryName[indexPath.row];
        cell.detailTextLabel.text = [[self.countryData valueForKey:@"altSpellings"]lastObject];
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
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[self.responseData length]);
    
    NSError *myError = nil;
    NSArray *resonse = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    //NSLog(@"%@", self.responseData);
    _borderFullDataEntry = resonse;
    _countryName = [resonse valueForKey:@"name"];
    NSLog(@"VOunt");
    [[NSNotificationCenter defaultCenter] postNotificationName:kFinishedLoading object:nil];
   

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Get reference to receipt
    VGGTTCountryDeets *countryDeets = [VGGTTCountryDeets sharedCDManager];
    VGGTTCountryDeets *receipt = [_borderFullDataEntry objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    
    VGGTTDetailView *controller = [storyboard instantiateViewControllerWithIdentifier:@"detailView"];
    
    controller.countryData = receipt;
    [self.navigationController pushViewController:controller animated:YES];
}


@end