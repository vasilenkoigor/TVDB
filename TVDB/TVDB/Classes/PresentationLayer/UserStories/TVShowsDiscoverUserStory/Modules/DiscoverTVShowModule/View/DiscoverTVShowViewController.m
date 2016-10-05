//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "DiscoverTVShowViewController.h"
#import "DiscoverTVShowDataDisplayManager.h"
#import "DiscoverTVShowViewModelInput.h"
#import "TVShowSeasonCellObject.h"
#import "TVShow.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface DiscoverTVShowViewController ()

@property (strong, nonatomic, readwrite) id <DiscoverTVShowViewModelInput> output;
@property (strong, nonatomic, readwrite) DiscoverTVShowDataDisplayManager *discoverTVShowDataDisplayManager;
@property (strong, nonatomic) UIButton *favoriteButton;

@end

@implementation DiscoverTVShowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupViewInitialConfiguration];
    [self setupInitialState];
    [self bindUI];
}

#pragma mark - Bindings

- (void)bindUI
{
    [[RACObserve(self.output, tvShow) deliverOnMainThread] subscribeNext:^(TVShow *tvShow) {
        if (tvShow) {
            [self updateViewStateWithTVShow:tvShow];
        }
    }];

    [self.favoriteButton rac_liftSelector:@selector(setTitle:forState:)
                     withSignalsFromArray:@[[RACObserve(self.output, favoriteButtonTitle) deliverOnMainThread], [RACSignal return:@(UIControlStateNormal)]]];

    [[self.output.loadTVShowsErrorSignal deliverOnMainThread] subscribeError:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

- (void)updateViewStateWithTVShow:(TVShow *)tvShow
{
    [SVProgressHUD dismiss];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.discoverTVShowDataDisplayManager configureDataDisplayManagerWithTVShow:tvShow];

    self.tableView.dataSource = [self.discoverTVShowDataDisplayManager dataSourceForTableView:self.tableView];
    [self.tableView reloadData];
}

#pragma mark - Setup Controller

- (void)setupInitialState
{
    [SVProgressHUD showWithStatus:@"Loading"];

    self.discoverTVShowDataDisplayManager.delegate = self;
    self.tableView.delegate = [self.discoverTVShowDataDisplayManager delegateForTableView:self.tableView
                                                      baseTableViewDelegate:nil];

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 100)];
    view.backgroundColor = [UIColor clearColor];
    self.favoriteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.favoriteButton.frame = CGRectMake(0, 0, 200, 30);
    self.favoriteButton.center = view.center;
    [view addSubview:self.favoriteButton];
    self.favoriteButton.rac_command = self.output.favoriteButtonCommand;

    self.tableView.tableHeaderView = view;
}

- (void)setupViewInitialConfiguration
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - DiscoverTVShowDataDisplayManagerDelegate

- (void)dataDisplayManager:(DiscoverTVShowDataDisplayManager *)dataDisplayManager didSelectTVSeason:(TVShowSeasonCellObject *)tvSeasonCellObject
{
    [self.output openEpisodesForSeason:tvSeasonCellObject.tvSeason];
}

@end