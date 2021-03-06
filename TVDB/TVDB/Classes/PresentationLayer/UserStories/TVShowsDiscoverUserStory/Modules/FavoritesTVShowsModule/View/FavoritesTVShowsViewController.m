//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "FavoritesTVShowsViewController.h"
#import "FavoritesTVShowsViewModelInput.h"
#import "TVShowsDataDisplayManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <SVProgressHUD/SVProgressHUD.h>

@interface FavoritesTVShowsViewController () <TVShowsDataDisplayManagerDelegate>

@property (strong, nonatomic, readwrite) id <FavoritesTVShowsViewModelInput> output;
@property (strong, nonatomic, readwrite) TVShowsDataDisplayManager *dataDisplayManager;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation FavoritesTVShowsViewController

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
    [[RACObserve(self.output, tvShows) deliverOnMainThread] subscribeNext:^(NSArray *tvShows) {
        if (tvShows.count) {
            [self updateViewStateWithTVShows:tvShows];
        }
    }];

    [[self.output.loadTVShowsErrorSignal deliverOnMainThread] subscribeError:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}

- (void)updateViewStateWithTVShows:(NSArray *)tvShows
{
    [self.refreshControl endRefreshing];
    [SVProgressHUD dismiss];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.dataDisplayManager configureDataDisplayManagerWithTVShows:tvShows];

    self.tableView.dataSource = [self.dataDisplayManager dataSourceForTableView:self.tableView];
    [self.tableView reloadData];
}

#pragma mark - Setup Controller

- (void)setupInitialState
{
    [SVProgressHUD showWithStatus:@"Loading"];

    self.dataDisplayManager.delegate = self;
    self.tableView.delegate = [self.dataDisplayManager delegateForTableView:self.tableView
                                                      baseTableViewDelegate:nil];


}

- (void)setupViewInitialConfiguration
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self.output
                            action:@selector(reloadTVShows)
                  forControlEvents:UIControlEventValueChanged];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - TVShowsDataDisplayManagerDelegate

- (void)dataDisplayManager:(TVShowsDataDisplayManager *)dataDisplayManager didSelectTVShow:(TVShowCellObject *)tvShowCellObject
{
    [self.output discoverTVShow:tvShowCellObject];
}

@end
