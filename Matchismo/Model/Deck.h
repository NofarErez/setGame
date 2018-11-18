//
//  Deck.h
//  Matchismo
//
//  Created by Nofar Erez on 12/11/2018.
//  Copyright © 2018 Lightricks. All rights reserved.
//

#ifndef Deck_h
#define Deck_h

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *) card atTop:(BOOL)atTop;
- (void)addCard:(Card *) card;

- (Card *)drawRandomCard;

@end

#endif /* Deck_h */
