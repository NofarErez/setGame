// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "SetGameViewController.h"
#import "SetGame.h"
#import "SetDeck.h"
#import "SetCard.h"

NS_ASSUME_NONNULL_BEGIN

@implementation SetGameViewController

@synthesize game = _game;

- (Deck *) createDeck
{
    return [[SetDeck alloc] init];
}

- (Game *) game
{
    if (!_game)
    {
        _game = [[SetGame alloc] initWithCardCount:[self.cardsButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

- (UIImage *) backgroundImageForCard: (Card *)card
{
    UIImage *cardImage = [UIImage imageNamed:@"cardFront"];
    
    if ([card chosen])
    {
        UIGraphicsBeginImageContextWithOptions(cardImage.size, NO, cardImage.scale);
        [cardImage drawAtPoint:CGPointZero];
        [[UIColor blackColor] setStroke];
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, cardImage.size.width, cardImage.size.height)];
        path.lineWidth = 5.0;
        [path stroke];
        cardImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return cardImage;
}

- (void) updateMatchingResultLabel
{
    NSString *cardsString = [[self.game.testMatchCards valueForKey:@"contents"] componentsJoinedByString: @", "];
    
    if (self.game.foundMatches)
    {
        self.cardSelectionLabel.text = [NSString stringWithFormat:@"Matched %@ 🎉", cardsString];
    }
    else
    {
        self.cardSelectionLabel.text = [NSString stringWithFormat:@"The cards %@ don't Match 😕", cardsString];
    }
}

- (NSAttributedString *) titleForCard: (Card *)card
{
    SetCard *titleCard = [[SetCard alloc] initWithCard:card];
    UIColor *color = [self UIColorFromCard:titleCard];
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:titleCard.contents attributes:@{NSForegroundColorAttributeName: color}];
    return title;
}

- (UIColor *) UIColorFromCard: (SetCard *)card
{
    UIColor *color;
    if ([card.color isEqual:@"Red"])
    {
        color = [UIColor colorWithRed:1 green:0 blue:0 alpha:card.shade];
    }
    else if ([card.color isEqual:@"Green"])
    {
        color = [UIColor colorWithRed:0 green:1 blue:0 alpha:card.shade];
    }
    else if ([card.color isEqual:@"Blue"])
    {
        color = [UIColor colorWithRed:0 green:0 blue:1 alpha:card.shade];
    }
    else
    {
        color = [UIColor colorWithRed:0 green:0 blue:0 alpha:card.shade];
    }
    
    return color;
}

@end

NS_ASSUME_NONNULL_END
