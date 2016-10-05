//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UITableViewDataSource;
@protocol UITableViewDelegate;
@class UITableView;

@protocol DataDisplayManager <NSObject>

- (id <UITableViewDataSource>)dataSourceForTableView:(UITableView *)tableView;

- (id <UITableViewDelegate>)delegateForTableView:(UITableView *)tableView
                           baseTableViewDelegate:(id <UITableViewDelegate>)baseTableViewDelegate;

@end