//
//  Judges.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Judges : NSObject

@property (nonatomic, copy) NSNumber *judgeTotal;

-(BOOL)UpdateJudges:(int)meetid Total:(NSNumber*)total;

-(NSNumber*)getJudges:(int)meetid;

@end
