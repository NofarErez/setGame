// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "GameViewController.h"
#import "Game.h"
#import "GameHistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController()
@end

@implementation GameViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:sender
{
    if ([segue.identifier isEqualToString:@"History"])
    {
        if ([segue.destinationViewController isKindOfClass:[GameHistoryViewController class]])
        {
            GameHistoryViewController *historyController = (GameHistoryViewController *)segue.destinationViewController;
            historyController.history = self.history;
            
        }
        
    }
}

- (Deck *) createDeck
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (Game *) game
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

-(NSMutableAttributedString *) history
{
    if (!_history)
    {
        _history = [[NSMutableAttributedString alloc] init];
    }
    
    return _history;
}
- (IBAction)touchRestartButton:(id)sender
{
    self.game = nil;
    self.history = nil;
    [self game];
    [self updateUIMatchingResult];
    [self updateChoosenCardLabel:-1];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardsButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateChoosenCardLabel:cardIndex];
    [self updateUIMatchingResult];
    
}

- (void) updateChoosenCardLabel: (NSInteger)cardIndex
{
    if(cardIndex >= 0)
    {
        Card *card = [self.game cardAtIndex:cardIndex];
        if ([card chosen])
        {
            NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString: @"You chose: " attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
            NSAttributedString *cardTitle = [self titleForCard:card];
            [message appendAttributedString:cardTitle];
            [message appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
            [self.history appendAttributedString:message];
        }
        else
        {
            NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString: @"You unchose: " attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
            NSAttributedString *cardTitle = [self titleForCard:card];
            [message appendAttributedString:cardTitle];
            [message appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
            [self.history appendAttributedString:message];
        }
    }
}

- (void) updateUIMatchingResult
{
    [self updateCardButtons];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    
    if (self.game.readyToMatch)
    {
        [self updateMatchingResultLabel];
    }

}


- (NSAttributedString *) titleForCard: (Card *)card
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}


- (UIImage *) backgroundImageForCard: (Card *)card
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSAttributedString *) buttonTitleForCard:(Card *)card
{
    return [self titleForCard:card];
}

- (void) updateCardButtons
{
    for (UIButton *cardButton in self.cardsButtons)
    {
        NSUInteger cardIndex = [self.cardsButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:[self buttonTitleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
    }
    
}

- (void) updateMatchingResultLabel
{
    NSMutableAttributedString *cardsString = [[NSMutableAttributedString alloc] init];
    for (Card* card in self.game.testMatchCards)
    {
        [cardsString appendAttributedString:[self titleForCard:card]];
        [cardsString appendAttributedString:[[NSAttributedString alloc] initWithString: @" "]];
    }
    
    NSMutableAttributedString *matchResult = [[NSMutableAttributedString alloc] init];;
    if (self.game.foundMatches)
    {
        matchResult = [[NSMutableAttributedString alloc] initWithString:@"Matched " attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
        [matchResult appendAttributedString: cardsString];
        [matchResult appendAttributedString: [[NSMutableAttributedString alloc] initWithString:@"🎉\n" attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}]];

    }
    else
    {
        matchResult = [[NSMutableAttributedString alloc] initWithString:@"The cards " attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
        [matchResult appendAttributedString: cardsString];
        [matchResult appendAttributedString: [[NSMutableAttributedString alloc] initWithString:@"don't Match 😕\n" attributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}]];
    }
    
    [self.history appendAttributedString:matchResult];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateCardButtons];
}

@end

NS_ASSUME_NONNULL_END
