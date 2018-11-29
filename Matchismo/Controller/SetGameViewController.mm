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

- (Game *)createGame {
    _game = [[SetGame alloc] initWithCardCount:kInitialCardCount usingDeck:[self createDeck]];
    self.cardCount = kInitialCardCount;
    self.addThreeCardsToGameButton.userInteractionEnabled = YES;
    return _game;
}

- (IBAction)tap:(UITapGestureRecognizer *)sender {
    if (!self.deckStacked) {
        if([sender.view isKindOfClass:[SetCardView class]])
        {
            SetCardView *view = (SetCardView *)sender.view;
            view.chosen = !view.chosen;
        }
        
        NSUInteger cardIndex = [self.cardsView.subviews indexOfObject:sender.view];
        [self performSelector:@selector(chooseCard:) withObject:[NSNumber numberWithUnsignedInteger:cardIndex] afterDelay:0.1];
    }
    
}

- (void)increaseCurrentCardsView {
    for (int i = 0; i < [self cardCount]; i++)
    {
        int column = i % [self.grid columnCount];
        int row = i / [self.grid columnCount];
        CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
        
        [UIView animateWithDuration:0.5
                          delay:0.0
                        options: UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^ {
                         self.cardsView.subviews[i]. frame = CGRectMake(frame.origin.x, frame.origin.y, kCardFrameRatio * frame.size.width, kCardFrameRatio * frame.size.height);
                         
                     }
                         completion:nil];
    }  
}

- (void) addCardView:(CGPoint)initalPos atIndex:(NSUInteger)index {
    Card *card = [self.game cardAtIndex:index];
    NSUInteger column = index % [self.grid columnCount];
    NSUInteger row = index / [self.grid columnCount];
    CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
    SetCardView *cardView = [[SetCardView alloc] initWithFrame:CGRectMake(initalPos.x, initalPos.y, frame.size.width * kCardFrameRatio, frame.size.height * kCardFrameRatio)];
    if ([card isKindOfClass:[SetCard class]])
    {
        SetCard *setCard = (SetCard *)card;
        cardView.card = setCard;
        [cardView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
        [self.cardsView addSubview:cardView];
    }
    [self moveCard:cardView toRect:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width * kCardFrameRatio, frame.size.height * kCardFrameRatio)];
}


- (IBAction)AddThreeCards:(UIButton *)sender {
    NSArray *cardsAdded = [self.game addCardsToGame:3];
    
    self.grid.minimumNumberOfCells = [self cardCount] + [cardsAdded count];
    [self increaseCurrentCardsView];
    for (NSUInteger i = self.cardCount; i < self.cardCount + [cardsAdded count]; i ++) {
        [self addCardView:CGPointMake(800, 800) atIndex:i];
    }
    
    self.cardCount += [cardsAdded count];

    if ([self.game emptyDeck]) {
        self.addThreeCardsToGameButton.userInteractionEnabled = NO;
    }
}



@end

NS_ASSUME_NONNULL_END
