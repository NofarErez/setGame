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
    [self.cardsView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [self setupGame];
    [self drawCards];
//    [self game];
//    [self updateUIMatchingResult];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger cardIndex = [self.cardsButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUIMatchingResult];
}



- (void) updateUIMatchingResult
{
    [self updateCardButtons];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}


- (NSAttributedString *) titleForCard: (Card *)card
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}


//- (UIImage *) backgroundImageForCard: (Card *)card
//{
//    @throw [NSException exceptionWithName:NSInternalInconsistencyException
//                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
//                                 userInfo:nil];
//}
//
//- (NSAttributedString *) buttonTitleForCard:(Card *)card
//{
//    return [self titleForCard:card];
//}
//

- (void)rearangeBoard {
    
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

- (void)updateChosenFromCard:(UIView *)cardView fromCard:(Card *)card
{
    
}

- (void) updateCardButtons
{
    NSMutableArray *cardsToRemove = [[NSMutableArray alloc] init];
    for (UIView *cardView in self.cardsView.subviews)
    {
        NSUInteger cardIndex = [self.cardsView.subviews indexOfObject:cardView];
        Card *card = [self.game cardAtIndex:cardIndex];
        [self updateChosenFromCard:cardView fromCard:card];
        if(card.matched) {
//            [cardsToRemove addObject:cardView];
            [UIView transitionWithView:self.cardsView duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                [cardView removeFromSuperview];
            } completion:NULL];
            [self.game removeCardAtIndex:cardIndex];
        }

    }
    
//    if ([cardsToRemove count]) {
//        [self removeCard:cardsToRemove];
//    }
}

- (void)setupGame {
    
    self.grid = [[Grid alloc] init];
    self.grid.cellAspectRatio = 0.666;
    self.grid.size = self.cardsView.bounds.size; // what is the right size?
//    NSLog(@"%@", self.cardsView.bounds);
//    NSLog(@"%d", kCardCount);
    self.grid.minimumNumberOfCells = kCardCount;
    
    [self createGame];
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
