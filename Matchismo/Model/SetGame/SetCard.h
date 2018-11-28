// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.
#import "Card.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, Fill)
{
    Solid,
    Unfilled,
    Striped
};

typedef NS_OPTIONS(NSUInteger, Shape)
{
    Oval,
    Diamond,
    Squiggle
};

typedef NS_OPTIONS(NSUInteger, Color)
{
    Green,
    Red,
    Purple
};

// Object used as a Set card.
@interface SetCard : Card

// The shape of the card. Possible values are ●, ■, ▲.
@property (nonatomic) Shape shape;

// The color of the card. Possible values are red, green, blue.
@property (nonatomic) Color color;

// The rank of the card. Possible values are 1,2,3.
@property (nonatomic) NSUInteger rank;

// The opacity of the card. possible values are 0.1, 0.6, 1.
@property (nonatomic) Fill fill;

@property (nonatomic, readonly) NSUInteger uniqueParameters;

// Designated initialiser for the calss. initialise the object using /c card.
- (instancetype) initWithCard:(Card *)card;

// Method that returns an array of the valid shapes.
//+ (NSArray *) validShapes;
//
//// Method that returns an array of the valid shades.
//+ (NSArray *) validShades;
//
//// Method that returns an array of the valid colors.
//+ (NSArray *) validColors;
//
//// Method that returns an array of the valid ranks.
//+ (NSArray *) validRanks;

@end

static const NSUInteger kUniqueParameters = 3;


NS_ASSUME_NONNULL_END
