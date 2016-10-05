//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowSeasonCell.h"
#import "TVShowSeasonCellObject.h"
#import "UIImageView+AFNetworking.h"

static CGFloat const kHeightNumberOfEpisodesLabel = 30;
static CGFloat const kTVShowSeasonCellSpaces = 32;

@interface TVShowSeasonCell ()

@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *seasonNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *seasonOverviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberOfEpisodesLabel;

@end

@implementation TVShowSeasonCell

- (BOOL)shouldUpdateCellWithObject:(TVShowSeasonCellObject *)object
{
    [self.posterImageView setImageWithURL:object.posterURL placeholderImage:[UIImage imageNamed:@"placeholder_poster"]];
    self.seasonNameLabel.text = object.seasonName;
    self.seasonOverviewLabel.text = object.seasonOverview;
    self.numberOfEpisodesLabel.text = object.numberOfEpisodes;
    return YES;
}

+ (CGFloat)heightForObject:(TVShowSeasonCellObject *)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    UIFont *nameLabelFont = [UIFont fontWithName:@"HelveticaNeue" size:20];
    UIFont *overviewLabelFont = [UIFont fontWithName:@"HelveticaNeue" size:15];

    CGSize constraint = CGSizeMake(260, NSUIntegerMax);
    NSDictionary *nameLabelAttributes = @{NSFontAttributeName: nameLabelFont};
    CGRect nameLabelRect = [object.seasonName boundingRectWithSize:constraint
                                                           options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                        attributes:nameLabelAttributes
                                                           context:nil];

    NSDictionary *overviewLabelAttributes = @{NSFontAttributeName: overviewLabelFont};
    CGRect overviewLabelRect = [object.seasonOverview boundingRectWithSize:constraint
                                                                   options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                                attributes:overviewLabelAttributes
                                                                   context:nil];

    return nameLabelRect.size.height + overviewLabelRect.size.height + kHeightNumberOfEpisodesLabel + kTVShowSeasonCellSpaces;
}

@end
