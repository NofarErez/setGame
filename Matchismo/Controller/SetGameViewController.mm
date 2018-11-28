// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "SetGameViewController.h"
#import "SetGame.h"
#import "SetDeck.h"
#import "SetCard.h"
#import "SetCardView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SetGameViewController()
@property (weak, nonatomic) IBOutlet UIButton *addThreeCardsToGameButton;
@property (nonatomic) NSUInteger cardCount;

@end

@implementation SetGameViewController

@synthesize game = _game;
@synthesize grid = _grid;
@synthesize cardsView = _cardsView;

static const int kInitialCardCount = 12;

- (Deck *) createDeck
{
    return [[SetDeck alloc] init];
}

- (Game *) game
{
    if (!_game)
    {
        _game = [[SetGame alloc] initWithCardCount:kInitialCardCount usingDeck:[self createDeck]];
    }
    return _game;
}

- (Game *)createGame {
    _game = [[SetGame alloc] initWithCardCount:kInitialCardCount usingDeck:[self createDeck]];
    self.cardCount = kInitialCardCount;
    return _game;
}

- (void)drawCards {
    self.grid.minimumNumberOfCells = [self cardCount];
    [self.cardsView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    for (int i = 0; i < [self cardCount]; i++)
    {
        [self addCardView:CGPointMake(-100, -100) atIndex:i];
    }
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    if([sender.view isKindOfClass:[SetCardView class]])
    {
        SetCardView *view = (SetCardView *)sender.view;
        view.chosen = !view.chosen;
    }
    
    NSUInteger cardIndex = [self.cardsView.subviews indexOfObject:sender.view];
    [self performSelector:@selector(chooseCard:) withObject:[NSNumber numberWithUnsignedInteger:cardIndex] afterDelay:0.1];
}

- (void)increaseCurrentCardsView {
    for (int i = 0; i < [self cardCount]; i++)
    {
        int column = i / [self.grid rowCount];
        int row = i % [self.grid rowCount];
        CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
        
        [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^ {
                         self.cardsView.subviews[i]. frame = frame;
                         [self.cardsView.subviews[i] layoutIfNeeded];
                         
                     }
                         completion:nil];
    }  
}

- (void) addCardView:(CGPoint)initalPos atIndex:(NSUInteger)index {
    Card *card = [self.game cardAtIndex:index];
    int column = index / [self.grid rowCount];
    int row = index % [self.grid rowCount];
    CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
    SetCardView *cardView = [[SetCardView alloc] initWithFrame:CGRectMake(initalPos.x, initalPos.y, frame.size.width * 0.75, frame.size.height * 0.75)];
    if ([card isKindOfClass:[SetCard class]])
    {
        SetCard *setCard = (SetCard *)card;
        if (![setCard isEqual:cardView.card]) {
            cardView.card = setCard;
            [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
            [self.cardsView addSubview:cardView];
        }
    }
    [self moveCard:cardView toRect:frame];
}


- (IBAction)AddThreeCards:(UIButton *)sender {
    NSArray *cardsAdded = [self.game addCardsToGame:3];
    
    self.grid.minimumNumberOfCells = [self cardCount] + [cardsAdded count];
    [self increaseCurrentCardsView];
    for (int i = self.cardCount; i < self.cardCount + [cardsAdded count]; i ++)
    {
        [self addCardView:CGPointMake(800, 800) atIndex:i];
    }
    
    self.cardCount += [cardsAdded count];


    if ([self.game emptyDeck]) {
        self.addThreeCardsToGameButton.userInteractionEnabled = NO;
    }
}



@end

NS_ASSUME_NONNULL_END
