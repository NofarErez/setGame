// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "GameViewController.h"
#import "Game.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController()

@end

@implementation GameViewController

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

- (IBAction)touchRestartButton:(id)sender
{
    self.game = nil;
    [self game];
    [self updateUIMatchingResult];
    [self updateChoosenCardLabel:-1];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardsButtons indexOfObject:sender];
    [self updateChoosenCardLabel:cardIndex];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUIMatchingResult];
    
}

- (void) updateChoosenCardLabel: (NSInteger)cardIndex
{
    if(cardIndex > 0)
    {
        Card *card = [self.game cardAtIndex:cardIndex];
        NSString *content = card.contents;
        self.cardSelectionLabel.text = [NSString stringWithFormat:@"You chose: %@", content];
    }
    else
    {
        self.cardSelectionLabel.text = @"";
        
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
//    else
//    {
//        [self updateChoosenCardLabel:-1];
//    }
    
}

- (void) updateMatchingResultLabel
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
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

- (void) updateCardButtons
{
    for (UIButton *cardButton in self.cardsButtons)
    {
        NSUInteger cardIndex = [self.cardsButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateCardButtons];
}

@end

NS_ASSUME_NONNULL_END
