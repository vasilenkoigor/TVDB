//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "DiscoverTVEpisodesViewController.h"
#import "DiscoverTVEpisodesViewModelInput.h"
#import "DiscoverTVEpisodesDataDisplayManager.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface DiscoverTVEpisodesViewController ()

@property (strong, nonatomic, readwrite) id <DiscoverTVEpisodesViewModelInput> output;
@property (strong, nonatomic, readwrite) DiscoverTVEpisodesDataDisplayManager *discoverTVEpisodesDataDisplayManager;

@end

@implementation DiscoverTVEpisodesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupInitialState];
    [self bindUI];
}

#pragma mark - Bindings

- (void)bindUI
{
    [[RACObserve(self.output, episodes) deliverOnMainThread] subscribeNext:^(NSArray *episodes) {
        [self updateViewStateWithEpisodes:episodes];
    }];
}

- (void)updateViewStateWithEpisodes:(NSArray *)episodes
{
    [self.discoverTVEpisodesDataDisplayManager configureDataDisplayManagerWithTVEpisodes:episodes];

    self.tableView.dataSource = [self.discoverTVEpisodesDataDisplayManager dataSourceForTableView:self.tableView];
    [self.tableView reloadData];
}

#pragma mark - Setup Controller

- (void)setupInitialState
{
    self.tableView.delegate = [self.discoverTVEpisodesDataDisplayManager delegateForTableView:self.tableView
                                                                    baseTableViewDelegate:nil];


}

@end