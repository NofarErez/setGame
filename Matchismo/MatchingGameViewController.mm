//
//  MatchingGameViewController.m
//  Matchismo
//
//  Created by Nofar Erez on 12/11/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#import "MatchingGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface MatchingGameViewController ()

@property (weak, nonatomic) IBOutlet UISegmentedControl *modeSelectionSegment;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsButtons;
@property (weak, nonatomic) IBOutlet UILabel *cardSelectionLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@end

@implementation MatchingGameViewController

- (Deck *) createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (CardMatchingGame *) game
{
    if (!_game)
    {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardsButtons count] usingDeck:[self createDeck]];
    }
    return _game;
}

- (IBAction)touchRestartButton:(id)sender
{
    self.game = nil;
    [self game];
    [self updateUIMatchingResult];
    self.modeSelectionSegment.userInteractionEnabled = YES;
    [self updateChoosenCardLabel:-1];


}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardsButtons indexOfObject:sender];
    
    if (self.modeSelectionSegment.enabled)
    {
        self.game.matchMode = self.modeSelectionSegment.selectedSegmentIndex + 2;
        self.modeSelectionSegment.userInteractionEnabled = NO;
    }
    
    [self updateChoosenCardLabel:cardIndex];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUIMatchingResult];
    
}

- (void) updateChoosenCardLabel: (NSInteger)cardIndex
{
    if(cardIndex > 0)
    {
        Card *card = [self.game cardAtIndex:cardIndex];
        self.cardSelectionLabel.text = [NSString stringWithFormat:@"You chose: %@", card.contents];
    }
    else
    {
        self.cardSelectionLabel.text = @"";

    }
}

-
(void) updateChosenCards: (NSUInteger)cardIndex
{
    
}


- (void) updateUIMatchingResult
{
    for (UIButton *cardButton in self.cardsButtons)
    {
        NSUInteger cardIndex = [self.cardsButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.matched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    
    if (self.game.readyToMatch)
    {
        [self updateMatchingResultLabel];
    }
    else
    {
        [self updateChosenCards:-1];
    }
    
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

- (NSString *) titleForCard: (Card *)card
{
    return card.chosen ? card.contents : @"";
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
