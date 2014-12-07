//
//  JudgeScores.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JudgeScores : NSObject

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

-(BOOL)CreateJudgeScores:(int)meetid diverid:(int)diverid boardsize:(NSNumber*)boardsize divenumber:(NSNumber*)divenumber divecategory:(NSString*)divecategory divetype:(NSString*)divetype diveposition:(NSString*)diveposition failed:(NSString*)failed multiplier:(NSNumber*)multiplier totalscore:(NSNumber*)totalscore score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7;

-(NSArray*)FetchJudgeScores:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber;

-(NSNumber*)GetMultiplier:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber;

-(BOOL)CheckFailed:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber;

-(BOOL)checkResultsExists:(int)meetid diverid:(int)diverid;

-(NSArray*)GetDiveNumbers:(int)meetid diverid:(int)diverid;

-(NSArray*)GetCatAndName:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber;

-(void)UpdateJudgeScoreTypes:(int)meetid diverid:(int)diverid divecat:(NSString*)divecat divetype:(NSString*)divetype divepos:(NSString*)divepos multiplier:(NSNumber*)multiplier divenumber:(NSNumber*)divenumber;

-(void)UpdateJudgeAllScoresFailed:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber failed:(NSString*)failed totalscore:(NSNumber*)totalscore score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7;

-(void)UpdateJudgeFailed:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber failed:(NSString*)failed totalscore:(NSNumber*)totalscore;

-(void)UpdateJudgeAllScores:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber totalscore:(NSNumber*)totalscore score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7;

-(void)DeleteJudgeScore:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber;

@end
