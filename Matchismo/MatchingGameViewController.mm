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
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:card.chosen ? card.contents : @"" attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
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
