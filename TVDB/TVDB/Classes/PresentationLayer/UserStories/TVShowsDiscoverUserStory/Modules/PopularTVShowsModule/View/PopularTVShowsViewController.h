//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopularTVShowsViewModelInput;

@interface PopularTVShowsViewController : UIViewController

@property (strong, nonatomic, readonly) id <PopularTVShowsViewModelInput> viewModel;

@end