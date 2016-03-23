//
//  VGGTTDetailView.h
//  viagogo-tt
//
//  Created by Daniel-Ernest Luff on 23/03/2016.
//  Copyright © 2016 toutright. All rights reserved.
//


#import "VGGTTCountryDeets.h"
@interface VGGTTDetailView : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UITableView *tableView;
}

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSArray *borderFullDataEntry;
@property (nonatomic, strong) NSArray *countryName;
@property (nonatomic, strong) VGGTTCountryDeets *countryData;
@property (nonatomic, strong) UITableView *borderTable;


@property (nonatomic, strong) IBOutlet UILabel *countryNameTitle;
@property (nonatomic, strong) IBOutlet UILabel *countryNameAlt;
@property (nonatomic, strong) IBOutlet UIImageView *flag;


@end

