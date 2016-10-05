//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "TVShowEpisodeCell.h"
#import "TVShowEpisodeCellObject.h"

static CGFloat const kTVShowEpisodeCellSpaces = 32;

@interface TVShowEpisodeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *episodePosterImageView;
@property (weak, nonatomic) IBOutlet UILabel *episodeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *episodeOverviewLabel;

@end

@implementation TVShowEpisodeCell

- (BOOL)shouldUpdateCellWithObject:(TVShowEpisodeCellObject *)object
{
    [self.episodePosterImageView setImageWithURL:object.posterURL placeholderImage:[UIImage imageNamed:@"placeholder_poster"]];
    self.episodeNameLabel.text = object.episodeName;
    self.episodeOverviewLabel.text = object.episodeOverview;
    return YES;
}

+ (CGFloat)heightForObject:(TVShowEpisodeCellObject *)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    UIFont *nameLabelFont = [UIFont fontWithName:@"HelveticaNeue" size:20];
    UIFont *overviewLabelFont = [UIFont fontWithName:@"HelveticaNeue" size:15];

    CGSize constraint = CGSizeMake(260, NSUIntegerMax);
    NSDictionary *nameLabelAttributes = @{NSFontAttributeName: nameLabelFont};
    CGRect nameLabelRect = [object.episodeName boundingRectWithSize:constraint
                                                            options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                         attributes:nameLabelAttributes
                                                            context:nil];

    NSDictionary *overviewLabelAttributes = @{NSFontAttributeName: overviewLabelFont};
    CGRect overviewLabelRect = [object.episodeOverview boundingRectWithSize:constraint
                                                                    options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                                 attributes:overviewLabelAttributes
                                                                    context:nil];

    return nameLabelRect.size.height + overviewLabelRect.size.height + kTVShowEpisodeCellSpaces;
}

@end
