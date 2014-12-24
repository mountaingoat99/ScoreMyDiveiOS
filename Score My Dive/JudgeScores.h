//
//  JudgeScores.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JudgeScores : NSObject

@property (nonatomic, copy) NSString *judgeScoreID;
@property (nonatomic, copy) NSString *meetid;
@property (nonatomic, copy) NSString *diverid;
@property (nonatomic, copy) NSNumber *boardSize;
@property (nonatomic, copy) NSNumber *diveNumber;
@property (nonatomic, copy) NSString *diveCategory;
@property (nonatomic, copy) NSString *diveType;
@property (nonatomic, copy) NSString *divePosition;
@property (nonatomic, copy) NSString *failed;
@property (nonatomic, copy) NSNumber *multiplier;
@property (nonatomic, copy) NSNumber *totalScore;
@property (nonatomic, copy) NSNumber *score1;
@property (nonatomic, copy) NSNumber *score2;
@property (nonatomic, copy) NSNumber *score3;
@property (nonatomic, copy) NSNumber *score4;
@property (nonatomic, copy) NSNumber *score5;
@property (nonatomic, copy) NSNumber *score6;
@property (nonatomic, copy) NSNumber *score7;

-(BOOL)CreateJudgeScores:(int)meetid diverid:(int)diverid boardsize:(double)boardsize divenumber:(NSNumber*)divenumber divecategory:(NSString*)divecategory divetype:(NSString*)divetype diveposition:(NSString*)diveposition failed:(NSNumber*)failed multiplier:(NSNumber*)multiplier totalscore:(NSNumber*)totalscore score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7;

-(NSArray*)FetchJudgeScores:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber;

-(NSArray*)FetchJudgeScoreObject:(int)meetid diverid:(int)diverid;

-(NSNumber*)GetMultiplier:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber;

-(BOOL)CheckFailed:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber;

-(BOOL)checkResultsExists:(int)meetid diverid:(int)diverid;

-(int)GetMaxDiveNumber:(int)meetid diverid:(int)diverid;

-(NSString*)GetCatAndName:(int)meetid diverid:(int)diverid divenumber:(int)divenumber;

-(NSString*)GetName:(int)meetid diverid:(int)diverid divenumber:(int)divenumber;

-(void)UpdateJudgeScoreTypes:(int)meetid diverid:(int)diverid divecat:(NSString*)divecat divetype:(NSString*)divetype divepos:(NSString*)divepos multiplier:(NSNumber*)multiplier oldDiveNumber:(NSNumber*)olddivenumber divenumber:(NSNumber*)divenumber;

-(void)UpdateJudgeAllScoresFailed:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber failed:(NSNumber*)failed totalscore:(NSNumber*)totalscore score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7;

-(void)UpdateJudgeFailed:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber failed:(NSNumber*)failed totalscore:(NSNumber*)totalscore;

-(void)UpdateJudgeAllScores:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber totalscore:(NSNumber*)totalscore score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7;

-(void)DeleteJudgeScore:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber;

-(BOOL)MeetsWithScores;

-(BOOL)Calculate2JudgesScore:(int)meetid diverid:(int)diverid divenumber:(int)divenumber meetinfo:(NSArray*)meetinfo score1:(NSNumber*)score1 score2:(NSNumber*)score2;

-(BOOL)Calculate3JudgesScore:(int)meetid diverid:(int)diverid divenumber:(int)divenumber meetinfo:(NSArray*)meetinfo score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3;

-(BOOL)Calculate5JudgesScore:(int)meetid diverid:(int)diverid divenumber:(int)divenumber meetinfo:(NSArray*)meetinfo score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5;

-(BOOL)Calculate7JudgesScore:(int)meetid diverid:(int)diverid divenumber:(int)divenumber meetinfo:(NSArray*)meetinfo score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7;

@end
