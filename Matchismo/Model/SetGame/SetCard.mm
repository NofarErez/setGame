// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCard

NSUInteger kSimilarParameters = 1;

@synthesize contents = _contents;

- (instancetype) initWithCard:(Card *)card
{
    if (self = [super init])
    {
        if ([card isKindOfClass:[SetCard class]])
        {
            self.shape = [[card valueForKey:@"shape"] integerValue];
            self.color = [[card valueForKey:@"color"] integerValue];
            self.rank = [[card valueForKey:@"rank"] integerValue];
            self.fill = [[card valueForKey:@"fill"] integerValue];
        }
    }
    
    return self;
}

- (NSUInteger)uniqueParameters {
    return 3;
}

- (NSString *) contents
{
    return nil;
}

+ (BOOL) validParameter: (NSSet *)parameters
{
    return [parameters count] == kSimilarParameters || [parameters count] == kUniqueParameters;
}

+ (BOOL) matchShape: (NSArray *)cards
{
    NSSet *shapes = [NSSet setWithArray:[cards valueForKey:@"shape"]];
    return [SetCard validParameter:shapes];
}

+ (BOOL) matchRank: (NSArray *)cards
{
    NSSet *ranks = [NSSet setWithArray:[cards valueForKey:@"rank"]];
    return [SetCard validParameter:ranks];
}

+ (BOOL) matchColor: (NSArray *)cards
{
    NSSet *colors = [NSSet setWithArray:[cards valueForKey:@"color"]];
    return [SetCard validParameter:colors];
}

+ (BOOL) matchShade: (NSArray *)cards
{
    NSSet *shades = [NSSet setWithArray:[cards valueForKey:@"fill"]];
    return [SetCard validParameter:shades];
}

+ (int)match:(NSArray *)cards
{
    int score = 0;
    if([SetCard matchRank:cards] && [SetCard matchColor:cards] &&
       [SetCard matchShape:cards] && [SetCard matchShade:cards])
    {
        score = 3;
    }

    return score;
}

//+ (NSArray *) validShapes
//{
//    return @[@"▲", @"■", @"●"];
//}
//
//+ (NSArray *) validShades
//{
//    return @[@0.1, @0.6, @1.0];
//}
//
//+ (NSArray *) validColors
//{
//    return @[@"Red", @"Blue", @"Green"];
//}
//
//+ (NSArray *) validRanks
//{
//    return @[@1, @2, @3];
//}


@end

NS_ASSUME_NONNULL_END
