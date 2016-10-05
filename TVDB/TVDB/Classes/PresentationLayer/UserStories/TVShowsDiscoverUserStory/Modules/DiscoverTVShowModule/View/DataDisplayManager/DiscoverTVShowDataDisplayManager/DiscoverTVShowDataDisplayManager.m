//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "NITableViewActions.h"
#import "NITableViewModel.h"
#import "NICellFactory.h"
#import "DiscoverTVShowDataDisplayManager.h"
#import "TVShow.h"
#import "DiscoverTVShowCellObjectsBuilder.h"
#import "TVShowSeasonCellObject.h"

@interface DiscoverTVShowDataDisplayManager () <UITableViewDelegate>

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) NSArray *cellObjects;

@end

@implementation DiscoverTVShowDataDisplayManager

- (void)configureDataDisplayManagerWithTVShow:(TVShow *)tvShow
{
    self.cellObjects = [self.discoverTVShowCellObjectsBuilder sectionedCellObjectsWithTVShow:tvShow];
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

    NIActionBlock actionBlock = ^BOOL(TVShowSeasonCellObject *tvSeasonCellObject, UIViewController *controller, NSIndexPath *indexPath) {
        [self.delegate dataDisplayManager:self didSelectTVSeason:tvSeasonCellObject];
        return YES;
    };

    [self.tableViewActions attachToClass:[TVShowSeasonCellObject class] tapBlock:actionBlock];
}

- (NITableViewModel *)configureTableViewModel
{
    NITableViewModel *tableViewModel = [[NITableViewModel alloc] initWithSectionedArray:self.cellObjects
                                                                               delegate:(id)([NICellFactory class])];
    return tableViewModel;
}

@end