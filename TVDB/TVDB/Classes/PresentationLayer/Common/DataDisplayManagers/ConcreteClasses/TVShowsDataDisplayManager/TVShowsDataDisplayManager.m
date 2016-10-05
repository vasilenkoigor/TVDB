//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "NITableViewModel.h"
#import "NICellFactory.h"
#import "TVShowsDataDisplayManager.h"
#import "TVShowCellObjectsBuilder.h"
#import "NITableViewActions.h"
#import "TVShowCellObject.h"

@interface TVShowsDataDisplayManager () <UITableViewDelegate>

@property (strong, nonatomic) NITableViewModel *tableViewModel;
@property (strong, nonatomic) NITableViewActions *tableViewActions;
@property (strong, nonatomic) NSArray *cellObjects;

@end

@implementation TVShowsDataDisplayManager

- (void)configureDataDisplayManagerWithTVShows:(NSArray *)tvShows
{
    self.cellObjects = [self.cellObjectsBuilder cellObjectsForTVShows:tvShows];
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

    NIActionBlock actionBlock = ^BOOL(TVShowCellObject *tvShowCellObject, UIViewController *controller, NSIndexPath *indexPath) {
        [self.delegate dataDisplayManager:self didSelectTVShow:tvShowCellObject];
        return YES;
    };

    [self.tableViewActions attachToClass:[TVShowCellObject class] tapBlock:actionBlock];
}

- (NITableViewModel *)configureTableViewModel
{
    NITableViewModel *tableViewModel = [[NITableViewModel alloc] initWithListArray:self.cellObjects
                                                                          delegate:(id)([NICellFactory class])];
    return tableViewModel;
}

@end