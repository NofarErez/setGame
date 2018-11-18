//
//  PlayingCard.h
//  Matchismo
//
//  Created by Nofar Erez on 12/11/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end

NS_ASSUME_NONNULL_END
