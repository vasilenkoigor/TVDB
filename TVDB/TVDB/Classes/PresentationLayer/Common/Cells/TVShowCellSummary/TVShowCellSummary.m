//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowCellSummary.h"
#import "TVShowCellSummaryObject.h"
#import "UIImageView+AFNetworking.h"

static CGFloat kSpacingBetweenElements = 16.f;

@interface TVShowCellSummary ()

@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *tvShowNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tvShowOverviewLabel;

@end

@implementation TVShowCellSummary

- (BOOL)shouldUpdateCellWithObject:(TVShowCellSummaryObject *)object
{
    [self.posterImageView setImageWithURL:object.posterURL placeholderImage:[UIImage imageNamed:@"placeholder_poster"]];
    self.tvShowNameLabel.text = object.name;
    self.tvShowOverviewLabel.text = object.overview;
    return YES;
}

+ (CGFloat)heightForObject:(TVShowCellSummaryObject *)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    UIFont *nameLabelFont = [UIFont fontWithName:@"HelveticaNeue" size:20];
    UIFont *overviewLabelFont = [UIFont fontWithName:@"HelveticaNeue" size:15];

    CGSize constraint = CGSizeMake(260, NSUIntegerMax);
    NSDictionary *nameLabelAttributes = @{NSFontAttributeName: nameLabelFont};
    CGRect nameLabelRect = [object.name boundingRectWithSize:constraint
                                                     options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                  attributes:nameLabelAttributes
                                                     context:nil];

    NSDictionary *overviewLabelAttributes = @{NSFontAttributeName: overviewLabelFont};
    CGRect overviewLabelRect = [object.overview boundingRectWithSize:constraint
                                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                                          attributes:overviewLabelAttributes
                                                             context:nil];

    return kSpacingBetweenElements + nameLabelRect.size.height + overviewLabelRect.size.height;
}

@end
