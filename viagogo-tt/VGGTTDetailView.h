//
//  VGGTTDetailView.h
//  viagogo-tt
//
//  Created by Daniel-Ernest Luff on 23/03/2016.
//  Copyright © 2016 toutright. All rights reserved.
//


#import "VGGTTCountryDeets.h"
#import <MapKit/MapKit.h>
@interface VGGTTDetailView : UIViewController <UITableViewDataSource, UITableViewDelegate> {
}

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSArray *borderFullDataEntry;
@property (nonatomic, strong) NSArray *countryName;
@property (nonatomic, strong) VGGTTCountryDeets *countryData;

@property (nonatomic, strong) IBOutlet UITableView *borderTable;


@property (nonatomic, retain) IBOutlet UILabel *countryNameTitle;
@property (nonatomic, retain) IBOutlet UILabel *countryNameAlt;
@property (nonatomic, retain) IBOutlet UIImageView *flag;
@property (nonatomic, retain) IBOutlet UILabel *countryNameLocal;
@property (nonatomic, retain) IBOutlet UILabel *dialingCode;
@property (nonatomic, retain) IBOutlet UILabel *tld;
@property (nonatomic, retain) IBOutlet UILabel *timezone;
@property (nonatomic, retain) IBOutlet UILabel *currency;
@property (nonatomic, retain) IBOutlet UIButton *contientsButton;





@end

