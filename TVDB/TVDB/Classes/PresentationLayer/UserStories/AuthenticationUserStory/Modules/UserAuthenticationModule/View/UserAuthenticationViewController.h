//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UserAuthenticationViewModelInput;

@interface UserAuthenticationViewController : UIViewController

@property (strong, nonatomic, readonly) id <UserAuthenticationViewModelInput> output;

@end