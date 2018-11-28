// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "GameViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController()
@property (weak, nonatomic) IBOutlet UIView *ButtonsView;

@end

@implementation GameViewController

static const int kCardCount = 12;

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

- (Game *) createGame
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}


- (IBAction)touchRestartButton:(id)sender
{
    [self setupGame];
    [self drawCards];
}

- (void) updateScoreLabel {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];

}

- (void) updateUIMatchingResult
{
    [self updateCardButtons];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}


- (void)rearangeBoard {
    for (int i =0; i < [self.cardsView.subviews count]; i++) {
        int column = i % [self.grid columnCount];
        int row = i / [self.grid columnCount];
        CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
        [self moveCard:self.cardsView.subviews[i] toRect:frame];
    }
}
- (void) moveCard:(UIView *)cardView toRect:(CGRect)finalPos {
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: UIViewAnimationOptionCurveLinear
                     animations:^ {
                         [cardView setFrame:finalPos];
                     }
                     completion:nil];
}


- (void)removeCard:(NSMutableArray *)cardsView {
    for (UIView *cardView in cardsView)
    {
        [UIView transitionWithView:cardView duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            [cardView removeFromSuperview];
        } completion:NULL];
    }
    [self rearangeBoard];
}

- (void) chooseCard:(NSNumber *)cardIndex {
    
    [self.game chooseCardAtIndex:[cardIndex unsignedIntegerValue]];
    [self updateUIMatchingResult];
}

- (void)updateChosenFromCard:(UIView *)cardView fromCard:(Card *)card {}

- (void) updateCardButtons
{
    for (UIView *cardView in self.cardsView.subviews)
    {
        NSUInteger cardIndex = [self.cardsView.subviews indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:cardIndex];
        [self updateChosenFromCard:cardView fromCard:card];
        if(card.matched) {
            [UIView transitionWithView:self.cardsView duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [cardView removeFromSuperview];
            } completion:NULL];
            [self.game removeCardAtIndex:cardIndex];
            [self rearangeBoard];

        }
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    self.grid.size = CGSizeMake(self.cardsView.bounds.size.height, self.cardsView.bounds.size.width);
    
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        
        [self rearangeBoard];
        
    } completion:nil];
}

- (void)setupGame {
    
    self.grid = [[Grid alloc] init];
    self.grid.cellAspectRatio = 0.666;
    self.grid.size = self.cardsView.bounds.size;
    self.grid.minimumNumberOfCells = kCardCount;
    
    [self createGame];
    [self updateScoreLabel];
}

- (void)drawCards {
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self setupGame];

    [self drawCards];

}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end

NS_ASSUME_NONNULL_END
