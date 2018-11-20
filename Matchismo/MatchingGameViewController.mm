//
//  MatchingGameViewController.m
//  Matchismo
//
//  Created by Nofar Erez on 12/11/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "MatchingGameViewController.h"
#import "CardMatchingGame.h"
#import "PlayingCardDeck.h"

@implementation MatchingGameViewController

@synthesize game = _game;

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (Game *) game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardsButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}




- (NSAttributedString *) buttonTitleForCard:(Card *)card
{
    return card.chosen ? [self titleForCard:card] : nil;
}

- (NSAttributedString *) titleForCard: (Card *)card
{
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:card.contents attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
    return title;
}

- (UIImage *) backgroundImageForCard: (Card *)card
{
    return [UIImage imageNamed:card.chosen ? @"cardFront" : @"cardBack"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


@end
