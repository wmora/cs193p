//
//  PlayingCard.h
//  Matchismo
//
//  Created by William Mora on 22/03/14.
//  Copyright (c) 2014 William Mora. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
