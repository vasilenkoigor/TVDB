//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <AFNetworking/UIImageView+AFNetworking.h>
#import "TVShowCastCell.h"
#import "TVShowCastCellObject.h"

@interface TVShowCastCell ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *characterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *castNameLabel;

@end

@implementation TVShowCastCell

- (BOOL)shouldUpdateCellWithObject:(TVShowCastCellObject *)object
{
    [self.profileImageView setImageWithURL:object.posterURL placeholderImage:[UIImage imageNamed:@"placeholder_poster"]];
    self.characterNameLabel.text = object.castCharacterName;
    self.castNameLabel.text = object.castName;
    return YES;
}

+ (CGFloat)heightForObject:(id)object atIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView
{
    return 140;
}

@end
