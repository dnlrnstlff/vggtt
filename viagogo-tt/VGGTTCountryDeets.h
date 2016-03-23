//
//  VGGTTCountryDeets.h
//  viagogo-tt
//
//  Created by Daniel-Ernest Luff on 22/03/2016.
//  Copyright © 2016 toutright. All rights reserved.
//

@interface VGGTTCountryDeets : NSObject {
    NSArray *username;
    NSArray *population;
    NSArray *twoLetterCode;
    NSString *password;
    NSString *accountType;
    NSInteger *entryCount;
    NSURL *pictureURL;
    NSArray *region;
}
@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, retain) NSArray *username;
@property (nonatomic, retain) NSArray *population;
@property (nonatomic, retain) NSArray *twoLetterCode;
@property (nonatomic, retain) NSArray *region;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *accountType;
@property (nonatomic) NSInteger *entryCount;
@property (nonatomic, retain) NSURL *pictureURL;

+ (VGGTTCountryDeets *)sharedCDManager;

@end


//"name": "Afghanistan",
//"capital": "Kabul",
//"altSpellings": [
//                 "AF",
//                 "Afġānistān"
//                 ],
//"relevance": "0",
//"region": "Asia",
//"subregion": "Southern Asia",
//"translations": {
//    "de": "Afghanistan",
//    "es": "Afganistán",
//    "fr": "Afghanistan",
//    "ja": "アフガニスタン",
//    "it": "Afghanistan"
//},
//"population": 26023100,
//"latlng": [
//           33,
//           65
//           ],
//"demonym": "Afghan",
//"area": 652230,
//"gini": 27.8,
//"timezones": [
//              "UTC+04:30"
//              ],
//"borders": [
//            "IRN",
//            "PAK",
//            "TKM",
//            "UZB",
//            "TJK",
//            "CHN"
//            ],
//"nativeName": "افغانستان",
//"callingCodes": [
//                 "93"
//                 ],
//"topLevelDomain": [
//                   ".af"
//                   ],
//"alpha2Code": "AF",
//"alpha3Code": "AFG",
//"currencies": [
//               "AFN"
//               ],
//"languages": [
//              "ps",
//              "uz",
//              "tk"
//              ]
//},