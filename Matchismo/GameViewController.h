// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import <UIKit/UIKit.h>
#import "Game.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *cardSelectionLabel;
@property (strong, nonatomic) Game *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardsButtons;
@property (strong, nonatomic) NSMutableAttributedString *history;


- (void) updateMatchingResultLabel;
- (NSAttributedString *) titleForCard: (Card *)card;
- (UIImage *) backgroundImageForCard: (Card *)card;
- (NSAttributedString *) buttonTitleForCard:(Card *)card;

@end

NS_ASSUME_NONNULL_END

