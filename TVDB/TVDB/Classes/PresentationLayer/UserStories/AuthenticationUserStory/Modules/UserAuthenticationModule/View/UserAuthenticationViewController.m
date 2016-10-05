//
// Created by Igor Vasilenko on 03/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UserAuthenticationViewController.h"
#import "UserAuthenticationViewModelInput.h"

@interface UserAuthenticationViewController ()

@property (strong, nonatomic, readwrite) id <UserAuthenticationViewModelInput> output;

@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@property (weak, nonatomic) IBOutlet UIView *signInView;
@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerYSignInButtonConstraint;

@end

@implementation UserAuthenticationViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self prepareViewInitialState];
    [self bindUI];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self.view endEditing:YES];
    [SVProgressHUD dismiss];
}

#pragma mark - Bindings

- (void)bindUI
{
    self.signInButton.rac_command = self.output.signInButtonCommand;

    [[self.output.authenticationProcessSignal deliverOnMainThread] subscribeNext:^(NSNumber *inProgress) {
        if (inProgress.boolValue) {
            [SVProgressHUD show];
        } else {
            [SVProgressHUD dismiss];
        }
    } error:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"Something went wrong"];
    }];

    RAC(self.output, loginTextFieldText) = [self.loginTextField rac_textSignal];
    RAC(self.output, passwordTextFieldText) = [self.passwordTextField rac_textSignal];

    @weakify(self)
    [[[[self rac_signalForSelector:@selector(viewDidAppear:)] take:1] delay:0.5f] subscribeNext:^(id x) {
        @strongify(self)
        if (self.output.isAuthenticated) {
            [self.output closeAuthentication];
        } else {
            [self showSignInView];
        }
    }];

    [[[[self rac_signalForSelector:@selector(viewDidAppear:)] skip:1] delay:0.5f] subscribeNext:^(id x) {
        @strongify(self)
        [self showSignInView];
    }];

    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
        @strongify(self)
        [self.view addGestureRecognizer:self.tapGestureRecognizer];
    }];
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillHideNotification object:nil] takeUntil:[self rac_willDeallocSignal]] subscribeNext:^(id x) {
        @strongify(self)
        [self.view removeGestureRecognizer:self.tapGestureRecognizer];
    }];
}

#pragma mark - Setup View

- (void)prepareViewInitialState
{
    [SVProgressHUD show];

    self.centerYSignInButtonConstraint.constant = - 1000;

    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(didTapViewWithGestureRecognizer:)];
}

#pragma mark - Animation

- (void)didTapViewWithGestureRecognizer:(UITapGestureRecognizer*)recognizer
{
    [self.view endEditing:YES];
}

- (void)showSignInView
{
    [SVProgressHUD dismiss];
    self.centerYSignInButtonConstraint.constant = - 150;
    [UIView animateWithDuration:0.5f
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}

@end
