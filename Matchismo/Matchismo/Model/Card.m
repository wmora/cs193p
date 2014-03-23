//
//  Card.m
//  Matchismo
//
//  Created by William Mora on 22/03/14.
//  Copyright (c) 2014 William Mora. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int) match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

@end
