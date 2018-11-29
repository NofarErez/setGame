// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// Object used as the Card Matching Game view.
@interface PlayingCardView : UIView

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL chosen;

- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end

NS_ASSUME_NONNULL_END
