#import "TVShow.h"//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "DiscoverTVShowViewModel.h"
#import "DiscoverTVShowRouterInput.h"
#import "TVShowsService.h"
#import "FavoritesTVShowsService.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface DiscoverTVShowViewModel ()

@property (strong, nonatomic, readwrite) id <DiscoverTVShowRouterInput> router;
@property (strong, nonatomic, readwrite) id <TVShowsService> tvShowsService;
@property (strong, nonatomic, readwrite) id <FavoritesTVShowsService> favoritesTVShowsService;

@property (strong, nonatomic) TVShow *tvShow;
@property (copy, nonatomic) NSString *favoriteButtonTitle;
@property (strong, nonatomic) RACSignal *loadTVShowsErrorSignal;
@property (strong, nonatomic) RACSubject *loadTVShowsErrorSubject;
@property (strong, nonatomic) RACCommand *favoriteButtonCommand;

@end

@implementation DiscoverTVShowViewModel

- (void)typhoonDidInject
{
    self.loadTVShowsErrorSubject = [RACSubject subject];

    RAC(self, self.favoriteButtonTitle) = [RACObserve(self, tvShow) map:^id(TVShow *tvShow) {
        if (!tvShow) {
            return @"";
        }
        if (tvShow.isFavorite) {
            return @"Remove from favorites";
        } else {
            return @"Mark as favorite";
        }
    }];
}

#pragma mark - DiscoverTVShowViewModelInput protocol

- (void)openEpisodesForSeason:(TVSeason *)season
{
    [self.router openDiscoverEpisodesModuleWithTVSeason:season];
}

#pragma mark - DiscoverTVShowModuleInput protocol

- (void)configureDiscoverTVShowModuleWithTVShow:(TVShow *)tvShow
{
    [self requestDetailsForTVShow:tvShow];
}

#pragma mark - Load content

- (void)requestDetailsForTVShow:(TVShow *)tvShow
{
    [[self.tvShowsService getFullTVShow:tvShow] subscribeNext:^(TVShow *tvShow) {
        self.tvShow = tvShow;
    } error:^(NSError *error) {
        [self.loadTVShowsErrorSubject sendError:error];
    }];
}

#pragma mark - Getters

- (RACCommand *)favoriteButtonCommand
{
    if (!_favoriteButtonCommand) {
        _favoriteButtonCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[[self.favoritesTVShowsService makeTVShowAsFavorite:self.tvShow
                                                               favorite:!self.tvShow.isFavorite] initially:^{
                self.tvShow.isFavorite = !self.tvShow.isFavorite;
            }] doNext:^(id x) {
                [self requestDetailsForTVShow:self.tvShow];
            }] doError:^(NSError *error) {
                self.tvShow.isFavorite = self.tvShow.isFavorite;
                [self.loadTVShowsErrorSubject sendError:error];
            }];
        }];
    }
    return _favoriteButtonCommand;
}

- (RACSignal *)loadTVShowsErrorSignal
{
    if (!_loadTVShowsErrorSignal) {
        _loadTVShowsErrorSignal = self.loadTVShowsErrorSubject;
    }
    return _loadTVShowsErrorSignal;
}

@end