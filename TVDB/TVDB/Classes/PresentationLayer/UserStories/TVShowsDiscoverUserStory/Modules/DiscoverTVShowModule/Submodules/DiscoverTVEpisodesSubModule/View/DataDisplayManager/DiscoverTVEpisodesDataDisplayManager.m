//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Nimbus/NITableViewActions.h>
#import <Nimbus/NITableViewModel.h>
#import <Nimbus/NICellFactory.h>
#import "DiscoverTVEpisodesDataDisplayManager.h"
#import "TVEpisodeCellObjectsBuilder.h"

@interface DiscoverTVEpisodesDataDisplayManager () <UITableViewDelegate>

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) NSArray *cellObjects;

@end

@implementation DiscoverTVEpisodesDataDisplayManager

- (void)configureDataDisplayManagerWithTVEpisodes:(NSArray *)tvEpisodes
{
    self.cellObjects = [self.tvEpisodeCellObjectsBuilder cellObjectsWithEpisodes:tvEpisodes];
}

#pragma mark - DataDisplayManager protocol

- (id <UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView
{
    self.tableViewModel = [self configureTableViewModel];
    return self.tableViewModel;
}

- (id <UITableViewDelegate>)delegateForTableView:(UITableView *)tableView baseTableViewDelegate:(id <UITableViewDelegate>)baseTableViewDelegate
{
    if (!self.tableViewActions) {
        [self configureTableViewActions];
    }
    return [self.tableViewActions forwardingTo:self];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = [NICellFactory tableView:tableView heightForRowAtIndexPath:indexPath model:self.tableViewModel];
    return height;
}

#pragma mark - Private

- (void)configureTableViewActions
{
    self.tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
}

- (NITableViewModel *)configureTableViewModel
{
    NITableViewModel *tableViewModel = [[NITableViewModel alloc] initWithSectionedArray:self.cellObjects
                                                                               delegate:(id)([NICellFactory class])];
    return tableViewModel;
}

@end