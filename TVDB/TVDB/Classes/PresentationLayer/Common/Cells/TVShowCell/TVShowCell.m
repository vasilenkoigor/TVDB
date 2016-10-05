//
// Created by Igor Vasilenko on 04/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowCell.h"
#import "TVShowCellObject.h"
#import "UIImageView+AFNetworking.h"

static NSInteger const TVShowCellHeight = 140;

@interface TVShowCell ()

@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *tvShowNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tvShowOverviewLabel;

@end

@implementation TVShowCell

- (BOOL)shouldUpdateCellWithObject:(TVShowCellObject *)object
{
    [self.posterImageView setImageWithURL:object.posterURL placeholderImage:[UIImage imageNamed:@"placeholder_poster"]];
    self.tvShowNameLabel.text = object.name;
    self.tvShowOverviewLabel.text = object.overview;
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    return TVShowCellHeight;
}

@end
