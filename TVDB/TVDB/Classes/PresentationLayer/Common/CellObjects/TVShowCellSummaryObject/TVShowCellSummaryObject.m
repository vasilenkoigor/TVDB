//
// Created by Igor Vasilenko on 05/10/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import "TVShowCellSummaryObject.h"
#import "TVShowCellSummary.h"


@implementation TVShowCellSummaryObject

- (Class)cellClass
{
    return [TVShowCellSummary class];
}

- (UINib *)cellNib
{
    return [UINib nibWithNibName:NSStringFromClass([TVShowCellSummary class]) bundle:[NSBundle mainBundle]];
}

@end