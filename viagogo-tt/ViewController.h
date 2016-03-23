//
//  ViewController.h
//  viagogo-tt
//
//  Created by Daniel-Ernest Luff on 22/03/2016.
//  Copyright © 2016 toutright. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSArray *tempDictionary;
@property (nonatomic, strong) IBOutlet UILabel *countryName;


@end

