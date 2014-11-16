//
//  QuickScores.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "QuickScores.h"

@interface QuickScores ()

@end

@implementation QuickScores


// this will get all the scores from the QuickScore Edit View
// and calculate the total
-(double)GetQuickScoreTotal:(NSArray *)diveScores{
    
    double totalScore = 0;
    NSString *scores;
    
    for (scores in diveScores) {
        totalScore += [scores doubleValue];
    }
    
    return totalScore;
}

@end
