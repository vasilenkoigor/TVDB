//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVShowsDataDisplayManager.h"

@protocol PopularTVShowsViewModelInput;

@interface PopularTVShowsViewController : UIViewController <TVShowsDataDisplayManagerDelegate>

@property (strong, nonatomic, readonly) id <PopularTVShowsViewModelInput> output;
@property (strong, nonatomic, readonly) TVShowsDataDisplayManager *dataDisplayManager;

@end