//
//  QuickScores.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuickScores : NSObject


-(double)GetQuickScoreTotal:(NSArray *)diveScores;

-(BOOL)updateQuickScore:(int)idToEdit Name:(NSString*)name Dive1:(NSString*)dive1 Dive2:(NSString*)dive2 Dive3:(NSString*)dive3
                       Dive4:(NSString*)dive4 Dive5:(NSString*)dive5 Dive6:(NSString*)dive6 Dive7:(NSString*)dive7
                  Dive8:(NSString*)dive8 Dive9:(NSString*)dive9 Dive10:(NSString*)dive10 Dive11:(NSString*)dive11 Total:(NSString*)total;

-(NSArray*)loadInfo:(int)idToLoad;

-(NSArray*)LoadAllQuickScores;

-(void)DeleteQuickScore:(int)idToDelete;

@end
