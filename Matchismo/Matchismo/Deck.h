//
//  Deck.h
//  Matchismo
//
//  Created by William Mora on 22/03/14.
//  Copyright (c) 2014 William Mora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)card atTop:(BOOL)atTop;
- (void) addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
