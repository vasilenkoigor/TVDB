//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DiscoverTVShowViewModelInput;
@class DiscoverTVShowDataDisplayManager;
@protocol DiscoverTVShowDataDisplayManagerDelegate;

@interface DiscoverTVShowViewController : UITableViewController <DiscoverTVShowDataDisplayManagerDelegate>

@property (strong, nonatomic, readonly) id <DiscoverTVShowViewModelInput> output;
@property (strong, nonatomic, readonly) DiscoverTVShowDataDisplayManager *discoverTVShowDataDisplayManager;

@end