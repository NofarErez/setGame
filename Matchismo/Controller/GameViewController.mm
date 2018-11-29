// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "GameViewController.h"
#import "MovingStackBehavior.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController()
@property (weak, nonatomic) IBOutlet UIView *ButtonsView;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (strong, nonatomic) MovingStackBehavior *movingStackBehavior;
@property (strong, nonatomic) UIAttachmentBehavior *attachment;
@end

@implementation GameViewController


- (Deck *) createDeck
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
}

- (IBAction)pinch:(UIPinchGestureRecognizer *)sender
{
    CGSize cellSize = self.grid.cellSize;
    CGRect viewMiddle = CGRectMake((self.cardsView.bounds.size.width - cellSize.width) / 2, (self.cardsView.bounds.size.height - cellSize.height) / 2, kCardFrameRatio * cellSize.width, kCardFrameRatio * cellSize.height);
    for (UIView *subView in self.cardsView.subviews) {
        [self moveCard:subView toRect:viewMiddle];
    }
    self.deckStacked = YES;
}

- (IBAction)tapToSpreadDeck:(UITapGestureRecognizer *)sender {
    [self rearangeBoard];
    self.deckStacked = NO;

}

- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    if (self.deckStacked)
    {
        CGPoint gesturePoint = [sender locationInView:self.cardsView];
        if (sender.state == UIGestureRecognizerStateBegan) {
            [self attachDroppingViewToPoint:gesturePoint];
        } else if (sender.state == UIGestureRecognizerStateChanged) {
            self.attachment.anchorPoint = gesturePoint;
        } else if (sender.state == UIGestureRecognizerStateEnded) {
            [self.animator removeBehavior:self.attachment];
        }
    }
}

- (void)attachDroppingViewToPoint:(CGPoint)anchorPoint
{
    self.attachment = [[UIAttachmentBehavior alloc] initWithItem:self.cardsView attachedToAnchor:anchorPoint];
    [self.animator addBehavior:self.attachment];
    
}

- (void) updateScoreLabel {
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];

}

- (void) updateUIAfterMatch
{
    [self updateCardsViewAfterMatch];
    [self updateScoreLabel];
}


- (void)rearangeBoard {
    for (int i =0; i < [self.cardsView.subviews count]; i++) {
        int column = i % [self.grid columnCount];
        int row = i / [self.grid columnCount];
        CGRect frame = [self.grid frameOfCellAtRow:row inColumn:column];
        
        [self moveCard:self.cardsView.subviews[i] toRect:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width * kCardFrameRatio, frame.size.height * kCardFrameRatio)];
    }
}

- (void) moveCard:(UIView *)cardView toRect:(CGRect)finalPos {
    [UIView animateWithDuration:0.5
                          delay:0.1
                        options: UIViewAnimationOptionCurveLinear
                     animations:^ {
                         [cardView setFrame:finalPos];
                     }
                     completion:nil];
}


//- (void)removeCard:(NSMutableArray *)cardsToRemove {
//    for (UIView *cardView in cardsToRemove)
//    {
//        [UIView transitionWithView:cardView duration:1.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
//            [cardView removeFromSuperview];
//        } completion:NULL];
//    }
//    [self rearangeBoard];
//}

- (void) chooseCard:(NSNumber *)cardIndex {
    [self.game chooseCardAtIndex:[cardIndex unsignedIntegerValue]];
    [self updateUIAfterMatch];
}

- (void)updateChosenFromCard:(UIView *)cardView fromCard:(Card *)card {}

- (void) updateCardsViewAfterMatch
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
            self.cardCount --;

        }
    }
}

- (void) viewDidLayoutSubviews {
    self.grid.size = self.cardsView.bounds.size;
    [self rearangeBoard];
}

- (void)setupGame {
    [self createGame];
    [self updateScoreLabel];
    
    self.grid = [[Grid alloc] init];
    self.grid.cellAspectRatio = 0.666;
    self.grid.size = self.cardsView.bounds.size;
    self.grid.minimumNumberOfCells = self.cardCount;
    
    self.movingStackBehavior = [[MovingStackBehavior alloc] init];
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.cardsView];
    [self.animator addBehavior:self.movingStackBehavior];

    [self.cardsView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)]];
    [self.cardsView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToSpreadDeck:)]];
    [self.cardsView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)]];
    
    self.deckStacked = NO;
    
    [self drawCards];
}

- (void)drawCards {
    [self.cardsView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    for (int i = 0; i < [self cardCount]; i++)
    {
        [self addCardView:CGPointMake(-100, -100) atIndex:i];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setupGame];
}

- (void) addCardView:(CGPoint)initalPos atIndex:(NSUInteger)index {}

@end

NS_ASSUME_NONNULL_END
