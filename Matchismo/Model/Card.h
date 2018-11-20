// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Object used as an abstract class representing a card.
@interface Card : NSObject

// String representation of the content of the card.
@property (strong, nonatomic) NSString *contents;

// Boolean that represent whether the card was chosen.
@property (nonatomic) BOOL chosen;

// Boolean that represent whether the card was matched.
@property (nonatomic) BOOL matched;

// Class method that returns the match score of the given \c cards.
+ (int)match:(NSArray *)cards;

@end

NS_ASSUME_NONNULL_END

