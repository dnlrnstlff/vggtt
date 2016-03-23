//
//  AppDelegate.h
//  viagogo-tt
//
//  Created by Daniel-Ernest Luff on 22/03/2016.
//  Copyright © 2016 toutright. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VGGTTCountryDeets.h"

@interface AppDelegate : NSObject <UIApplicationDelegate> {
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    VGGTTCountryDeets *countryDeets;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) VGGTTCountryDeets *countryDeets;
@end

