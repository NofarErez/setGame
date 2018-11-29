// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import <UIKit/UIKit.h>
#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

// Object used as the Card Matching Game view.
@interface SetCardView : UIView
@property (strong, nonatomic) SetCard* card;
@property (nonatomic) BOOL chosen;
@end

NS_ASSUME_NONNULL_END
