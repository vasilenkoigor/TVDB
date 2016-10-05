//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DiscoverTVEpisodesViewModelInput;
@class DiscoverTVEpisodesDataDisplayManager;

@interface DiscoverTVEpisodesViewController : UITableViewController

@property (strong, nonatomic, readonly) id <DiscoverTVEpisodesViewModelInput> output;
@property (strong, nonatomic, readonly) DiscoverTVEpisodesDataDisplayManager *discoverTVEpisodesDataDisplayManager;

@end