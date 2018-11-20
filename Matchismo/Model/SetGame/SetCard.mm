// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetCard

NSUInteger kSimilarParameters = 1;
NSUInteger kUniqueParameters = 3;

@synthesize contents = _contents;

- (instancetype) initWithCard:(Card *)card
{
    if (self = [super init])
    {
        if ([card isKindOfClass:[SetCard class]])
        {
            self.shape = [card valueForKey:@"shape"];
            self.color = [card valueForKey:@"color"];
            self.rank = [[card valueForKey:@"rank"] integerValue];
            self.shade = [[card valueForKey:@"shade"] floatValue];
        }
    }
    
    return self;
}

- (NSString *) contents
{
    if(!_contents)
    {
        _contents = [@"" stringByPaddingToLength:self.rank  withString:self.shape startingAtIndex:0];
    }
    return _contents;
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
    NSSet *shades = [NSSet setWithArray:[cards valueForKey:@"shade"]];
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

+ (NSArray *) validShapes
{
    return @[@"▲", @"■", @"●"];
}

+ (NSArray *) validShades
{
    return @[@0.1, @0.6, @1.0];
}

+ (NSArray *) validColors
{
    return @[@"Red", @"Blue", @"Green"];
}

+ (NSArray *) validRanks
{
    return @[@1, @2, @3];
}


@end

NS_ASSUME_NONNULL_END
