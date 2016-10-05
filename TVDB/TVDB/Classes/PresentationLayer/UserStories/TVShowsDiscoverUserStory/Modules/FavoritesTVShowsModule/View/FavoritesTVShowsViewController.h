//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FavoritesTVShowsViewModelInput;
@class TVShowsDataDisplayManager;

@interface FavoritesTVShowsViewController : UIViewController

@property (strong, nonatomic, readonly) id <FavoritesTVShowsViewModelInput> output;
@property (strong, nonatomic, readonly) TVShowsDataDisplayManager *dataDisplayManager;

@end