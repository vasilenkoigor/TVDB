//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "UserAuthenticationViewController.h"
#import "UserAuthenticationViewModelInput.h"

@interface UserAuthenticationViewController ()

@property (strong, nonatomic, readwrite) id <UserAuthenticationViewModelInput> viewModel;

@end

@implementation UserAuthenticationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSLog(@"viewDidLoad");
}

@end