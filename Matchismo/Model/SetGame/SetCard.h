// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN



@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property (nonatomic) NSUInteger rank;
@property (nonatomic) float shade;

+ (NSArray *) validShapes;
+ (NSArray *) validShades;
+ (NSArray *) validColors;
+ (NSArray *) validRanks;

@end


NS_ASSUME_NONNULL_END
