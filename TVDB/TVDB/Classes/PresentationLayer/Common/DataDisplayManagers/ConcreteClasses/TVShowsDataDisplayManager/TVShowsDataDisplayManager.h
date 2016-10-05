//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataDisplayManager.h"

@class TVShowCellObjectsBuilder;
@class TVShowCellObject;
@class TVShowsDataDisplayManager;

@protocol TVShowsDataDisplayManagerDelegate <NSObject>

- (void)dataDisplayManager:(TVShowsDataDisplayManager *)dataDisplayManager didSelectTVShow:(TVShowCellObject *)tvShowCellObject;

@end

@interface TVShowsDataDisplayManager : NSObject <DataDisplayManager>

@property (weak, nonatomic) id <TVShowsDataDisplayManagerDelegate> delegate;
@property (strong, nonatomic) TVShowCellObjectsBuilder *cellObjectsBuilder;

- (void)configureDataDisplayManagerWithTVShows:(NSArray *)tvShows;

@end