//
//  JudgeScores.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "JudgeScores.h"
#import "DBManager.h"
#import "Results.h"
#import "DiveNumber.h"
#import <Foundation/Foundation.h>

@interface JudgeScores ()

@property (nonatomic, strong) DBManager *dbManager;
@property (nonatomic, strong) NSNumber *total;

-(NSNumber*)calcTotal:(NSNumber*)oneJudge TwoJudge:(NSNumber*)twoJudge ThreeJudge:(NSNumber*)threeJudge FourJudge:(NSNumber*)fourJudge FiveJudge:(NSNumber*)fiveJudge SixJudge:(NSNumber*)SixJudge SevenJudge:(NSNumber*)sevenJudge;
-(NSArray*)GetAllJudgeScores;
-(NSNumber*)DiveNumberDD:(int)divenumber meetInfo:(NSArray*)meetInfo;
-(double)RoundUpScore:(double)originalNumber;

@end

@implementation JudgeScores

#pragma public methods

-(BOOL)CreateJudgeScores:(int)meetid diverid:(int)diverid boardsize:(double)boardsize divenumber:(NSNumber*)divenumber divecategory:(NSString*)divecategory divetype:(NSString*)divetype diveposition:(NSString*)diveposition failed:(NSNumber*)failed multiplier:(NSNumber*)multiplier totalscore:(NSNumber*)totalscore score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7 {
    
    //call the method to calc the total
    //self.total = [self calcTotal:score1 TwoJudge:score2 ThreeJudge:score3 FourJudge:score4 FiveJudge:score5 SixJudge:score6 SevenJudge:score7];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    
    query = [NSString stringWithFormat:@"insert into judges_scores(meet_id, diver_id, board_size, dive_number, dive_category, dive_type, dive_position, failed, multiplier, total_score, score_1, score_2, score_3, score_4, score_5, score_6, score_7) values(%d, %d, %f, %@, '%@', '%@', '%@', %@, %@, %@, %@, %@, %@, %@, %@, %@, %@)", meetid, diverid, boardsize, divenumber, divecategory, divetype, diveposition, failed, multiplier, totalscore, score1, score2, score3, score4, score5, score6, score7];
    
    [self.dbManager executeQuery:query];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Results query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        return true;
    } else {
        NSLog(@"Results could not execute query");
        return  false;
    }
}

-(NSArray*)FetchJudgeScores:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber {
    
    NSArray *scores = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select total_score, score_1, score_2, score_3, score_4, score_5, score_6, score_7 from judges_scores where meet_id=%d and diver_id=%d and dive_number=%@", meetid, diverid, divenumber];
    
    scores = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return scores;
}

-(NSArray*)FetchJudgeScoreObject:(int)meetid diverid:(int)diverid {
    
    NSArray *scores = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from judges_scores where meet_id=%d and diver_id=%d", meetid, diverid];
    
    scores = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return scores;
    
}

-(NSNumber*)GetMultiplier:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber {
    
    NSNumber *multiplier;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select multiplier from judges_scores where meet_id=%d and diver_id=%d and dive_number=%@", meetid, diverid, divenumber];
    
    return multiplier = [self.dbManager loadNumberFromDB:query];
    
}

-(BOOL)CheckFailed:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber {
    
    NSString *failed;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select failed from judges_scores where meet_id=%d and diver_id=%d and dive_number=%@", meetid, diverid, divenumber];
    
    failed = [self.dbManager loadOneDataFromDB:query];
    
    if ([failed isEqualToString:@"F"]) {
        return true;
    } else {
        return false;
    }
}

-(BOOL)checkResultsExists:(int)meetid diverid:(int)diverid {
    
    NSArray *exists;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from judges_scores where meet_id=%d and diver_id=%d", meetid, diverid];
    
    exists = [self.dbManager loadDataFromDB:query];
    
    if (exists.count > 0) {
        return true;
    } else {
        return false;
    }
}

-(int)GetMaxDiveNumber:(int)meetid diverid:(int)diverid {
    
    //int max;
    NSArray *numbers;
    int xmax = 0;
    int xmin = 0;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    NSString *query = [NSString stringWithFormat:@"select dive_number from judges_scores where meet_id=%d and diver_id=%d", meetid, diverid];
    NSLog(@"MaxDiveNumber Query is: %@", query);
    
    numbers = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    int count = (int)numbers.count;
    
    for (int i = 0; i < count; i++) {
        xmin = [[[numbers objectAtIndex:i] objectAtIndex:0] intValue];
        
        if (xmin > xmax) {
            xmax = xmin;
        }
    }

    return xmax;
}

-(NSString*)GetCatAndName:(int)meetid diverid:(int)diverid divenumber:(int)divenumber {
    
    NSString *divecat;
    NSString *diveType;
    NSString *divePosition;
    NSString *multi;
    NSString *diveName;
    NSRange dash;
    
    NSArray *diveInfo;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select dive_category, dive_type, dive_position, multiplier from judges_scores where meet_id=%d and diver_id=%d and dive_number=%d", meetid, diverid, divenumber];
    
    diveInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // lets throw every part into a seperate stirng
    divecat = [[diveInfo objectAtIndex:0] objectAtIndex:0];
    diveType = [[diveInfo objectAtIndex:0] objectAtIndex:1];
    divePosition = [[diveInfo objectAtIndex:0] objectAtIndex:2];
    multi = [[diveInfo objectAtIndex:0] objectAtIndex:3];
    
    //now lets parse the diveNumber out of the dive
    dash = [diveType rangeOfString:@"-"];
    if (dash.location != NSNotFound) {
        diveType = [diveType substringWithRange:NSMakeRange(0, (dash.location - 1))];
    }
    
    // now parse the dive Position
    dash = [divePosition rangeOfString:@"-"];
    if (dash.location != NSNotFound) {
        divePosition = [divePosition substringWithRange:NSMakeRange(0, (dash.location - 1))];
    }
    
    // now lets put it all together
    diveName = divecat;
    diveName = [diveName stringByAppendingString:@" - "];
    diveName = [diveName stringByAppendingString:diveType];
    diveName = [diveName stringByAppendingString:divePosition];
    diveName = [diveName stringByAppendingString:@" - DD: "];
    diveName = [diveName stringByAppendingString:multi];
    
    return diveName;
    
}

-(NSString*)GetName:(int)meetid diverid:(int)diverid divenumber:(int)divenumber {
    
    NSString *diveType;
    NSString *divePosition;
    NSString *multi;
    NSString *diveName;
    NSRange dash;
    
    NSArray *diveInfo;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select dive_category, dive_type, dive_position, multiplier from judges_scores where meet_id=%d and diver_id=%d and dive_number=%d", meetid, diverid, divenumber];
    
    diveInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    // lets throw every part into a seperate stirng
    diveType = [[diveInfo objectAtIndex:0] objectAtIndex:1];
    divePosition = [[diveInfo objectAtIndex:0] objectAtIndex:2];
    multi = [[diveInfo objectAtIndex:0] objectAtIndex:3];
    
    //now lets parse the diveNumber out of the dive
    dash = [diveType rangeOfString:@"-"];
    if (dash.location != NSNotFound) {
        diveType = [diveType substringWithRange:NSMakeRange(0, (dash.location - 1))];
    }
    
    // now parse the dive Position
    dash = [divePosition rangeOfString:@"-"];
    if (dash.location != NSNotFound) {
        divePosition = [divePosition substringWithRange:NSMakeRange(0, (dash.location - 1))];
    }
    
    // now lets put it all together
    diveName = diveType;
    diveName = [diveName stringByAppendingString:divePosition];
    diveName = [diveName stringByAppendingString:@" - DD: "];
    diveName = [diveName stringByAppendingString:multi];
    
    return diveName;
    
}

-(void)UpdateJudgeScoreTypes:(int)meetid diverid:(int)diverid divecat:(NSString*)divecat divetype:(NSString*)divetype divepos:(NSString*)divepos multiplier:(NSNumber*)multiplier oldDiveNumber:(NSNumber*)olddivenumber divenumber:(NSNumber*)divenumber {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"update judges_scores set dive_category='%@', dive_type='%@', dive_position='%@', dive_number=%@, multiplier=%@ where meet_id=%d and diver_id=%d and dive_number=%@", divecat, divetype, divepos, divenumber, multiplier, meetid, diverid, olddivenumber];
    
    [self.dbManager executeQuery:query];
    
}

-(BOOL)UpdateJudgeAllScoresFailed:(int)meetid diverid:(int)diverid divenumber:(int)divenumber failed:(NSNumber*)failed totalscore:(NSNumber*)totalscore score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7 {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"update judges_scores set failed=%@, total_score=%@, score_1=%@, score_2=%@, score_3=%@, score_4=%@, score_5=%@, score_6=%@, score_7=%@ where meet_id=%d and diver_id=%d and dive_number=%d", failed, totalscore, score1, score2, score3, score4, score5, score6, score7, meetid, diverid, divenumber];
    
    [self.dbManager executeQuery:query];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Results query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        return true;
    } else {
        NSLog(@"Results could not execute query");
        return  false;
    }
    
}

-(void)UpdateJudgeFailed:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber failed:(NSNumber*)failed totalscore:(NSNumber*)totalscore {
    
    // here we need to get the old total, and then minus the score we are failing and update the score
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"update judges_scores set failed=%@, total_score=%@ where meet_id=%d and diver_id=%d and dive_number=%@", failed, totalscore, meetid, diverid, divenumber];
    
    [self.dbManager executeQuery:query];
    
}

-(BOOL)UpdateJudgeAllScores:(int)meetid diverid:(int)diverid divenumber:(int)divenumber totalscore:(NSNumber*)totalscore score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7 {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"update judges_scores set total_score=%@, score_1=%@, score_2=%@, score_3=%@, score_4=%@, score_5=%@, score_6=%@, score_7=%@ where meet_id=%d and diver_id=%d and dive_number=%d", totalscore, score1, score2, score3, score4, score5, score6, score7, meetid, diverid, divenumber];
    
    [self.dbManager executeQuery:query];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Results query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        return true;
    } else {
        NSLog(@"Results could not execute query");
        return  false;
    }
}

-(void)DeleteJudgeScore:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"delete from judges_scores where meet_id=%d and diver_id=%d and dive_number=%@", meetid, diverid, divenumber];
    
    [self.dbManager executeQuery:query];
    
}

-(BOOL)MeetsWithScores {
    
    NSArray *check;
    
    check = [self GetAllJudgeScores];
    
    if (check.count > 0) {
        
        int count = (int)check.count;
        
        for (int index = 0; index < count; index++) {
            
            NSString *diveNumberString = [[NSString alloc] initWithString:[[check objectAtIndex:index] objectAtIndex:4]];
            
            _diveNumber = [NSNumber numberWithDouble:[diveNumberString doubleValue]];
            
            if (_diveNumber > 0) {
                
                return true;
                
            } else {
                
                return false;

            }
        }
        
    } else {
        
        return false;
    }
    
    return false;
}

-(BOOL)Calculate2JudgesScore:(int)meetid diverid:(int)diverid divenumber:(int)divenumber meetinfo:(NSArray*)meetinfo score1:(NSNumber*)score1 score2:(NSNumber*)score2 {
    
    //lets create some bools yo!
    BOOL validJudgeScoreInsert;
    BOOL validResultsInsert;
    BOOL validDiveNumberIncrement;
    
    // lets see what the multiplier for this diver and dive is first
    NSNumber* multiplier = [self DiveNumberDD:divenumber meetInfo:meetinfo];
    
    // create some doubles
    double finalScore = 0.0;
    //double roundedFinalScore = 0.0;
    double scr1 = [score1 doubleValue];
    double scr2 = [score2 doubleValue];
    double scr3 = 0.0;
    
    // total them, average
    scr3 = (scr1 + scr2) / 2;
    
    finalScore = (scr1 + scr2 + scr3) * [multiplier doubleValue];
    
    //commenting out for now. Think we can just convert to NSNumber to round it out.
    //roundedFinalScore = [self RoundUpScore:finalScore];
    if (finalScore < .5) {
        return false;
    }
    
    //update the judge_scores table
    // first convert any doubles to NSNumber
    NSNumber *score3 = [NSNumber numberWithDouble:scr3];
    NSNumber *totalScore = [NSNumber numberWithDouble:finalScore];
    validJudgeScoreInsert = [self UpdateJudgeAllScores:meetid diverid:diverid divenumber:divenumber totalscore:totalScore score1:score1 score2:score2 score3:score3 score4:@0 score5:@0 score6:@0 score7:@0];
    
    //update the results table 
    Results *result = [[Results alloc] init];
    validResultsInsert = [result UpdateOneResult:meetid DiverID:diverid DiveNumber:divenumber score:totalScore];
    
    // increment the dive number in the dive_number table
    DiveNumber *number = [[DiveNumber alloc] init];
    validDiveNumberIncrement = [number UpdateDiveNumber:meetid diverid:diverid divenumber:divenumber];
    
    // now make sure everything was updated correctly
    if (validJudgeScoreInsert && validResultsInsert && validDiveNumberIncrement) {
        return true;
    } else {
        return false;
    }
}

-(BOOL)Calculate3JudgesScore:(int)meetid diverid:(int)diverid divenumber:(int)divenumber meetinfo:(NSArray*)meetinfo score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 {
    
    //lets create some bools yo!
    BOOL validJudgeScoreInsert;
    BOOL validResultsInsert;
    BOOL validDiveNumberIncrement;
    
    // lets see what the multiplier for this diver and dive is first
    NSNumber* multiplier = [self DiveNumberDD:divenumber meetInfo:meetinfo];
    
    // create some doubles
    double finalScore = 0.0;
    //double roundedFinalScore = 0.0;
    double scr1 = [score1 doubleValue];
    double scr2 = [score2 doubleValue];
    double scr3 = [score3 doubleValue];
    
    finalScore = (scr1 + scr2 + scr3) * [multiplier doubleValue];
    
    //commenting out for now. Think we can just convert to NSNumber to round it out.
    //roundedFinalScore = [self RoundUpScore:finalScore];
    if (finalScore < .5) {
        return false;
    }
    
    //update the judge_scores table
    // first convert all the values back to NSNumber
    NSNumber *totalScore = [NSNumber numberWithDouble:finalScore];
    validJudgeScoreInsert =  [self UpdateJudgeAllScores:meetid diverid:diverid divenumber:divenumber totalscore:totalScore score1:score1 score2:score2 score3:score3 score4:@0 score5:@0 score6:@0 score7:@0];
    
    //update the results table
    Results *result = [[Results alloc] init];
    validResultsInsert = [result UpdateOneResult:meetid DiverID:diverid DiveNumber:divenumber score:totalScore];
    
    // increment the dive number in the dive_number table
    DiveNumber *number = [[DiveNumber alloc] init];
    validDiveNumberIncrement = [number UpdateDiveNumber:meetid diverid:diverid divenumber:divenumber];
    
    // now make sure everything was updated correctly
    if (validJudgeScoreInsert && validResultsInsert && validDiveNumberIncrement) {
        return true;
    } else {
        return false;
    }
}

-(BOOL)Calculate5JudgesScore:(int)meetid diverid:(int)diverid divenumber:(int)divenumber meetinfo:(NSArray*)meetinfo score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 {
    
    //lets create some bools yo!
    BOOL validJudgeScoreInsert;
    BOOL validResultsInsert;
    BOOL validDiveNumberIncrement;
    
    // lets see what the multiplier for this diver and dive is first
    NSNumber* multiplier = [self DiveNumberDD:divenumber meetInfo:meetinfo];
    
    // lets throw all those scores into a mutable array yo!
    NSArray *scores = [NSMutableArray arrayWithObjects:
                              score1, score2, score3, score4, score5, nil];
    
    NSArray *sortedNumbers = [scores sortedArrayUsingSelector:@selector(compare:)];
    
    // now we only need to get the middle doubles and leave out the lowest and highest
    double finalScore = 0.0;
    //double roundedFinalScore = 0.0;
    double scr1 = [[sortedNumbers objectAtIndex:1] doubleValue];
    double scr2 = [[sortedNumbers objectAtIndex:2] doubleValue];
    double scr3 = [[sortedNumbers objectAtIndex:3] doubleValue];
    
    finalScore = (scr1 + scr2 + scr3) * [multiplier doubleValue];
    
    //commenting out for now. Think we can just convert to NSNumber to round it out.
    //roundedFinalScore = [self RoundUpScore:finalScore];
    if (finalScore < .5) {
        return false;
    }
    
    //update the judge_scores table
    // first convert all the values back to NSNumber
    NSNumber *totalScore = [NSNumber numberWithDouble:finalScore];
    validJudgeScoreInsert = [self UpdateJudgeAllScores:meetid diverid:diverid divenumber:divenumber totalscore:totalScore score1:score1 score2:score2 score3:score3 score4:score4 score5:score5 score6:@0 score7:@0];
    
    //update the results table
    Results *result = [[Results alloc] init];
    validResultsInsert = [result UpdateOneResult:meetid DiverID:diverid DiveNumber:divenumber score:totalScore];
    
    // increment the dive number in the dive_number table
    DiveNumber *number = [[DiveNumber alloc] init];
    validDiveNumberIncrement = [number UpdateDiveNumber:meetid diverid:diverid divenumber:divenumber];

    // now make sure everything was updated correctly
    if (validJudgeScoreInsert && validResultsInsert && validDiveNumberIncrement) {
        return true;
    } else {
        return false;
    }
}

-(BOOL)Calculate7JudgesScore:(int)meetid diverid:(int)diverid divenumber:(int)divenumber meetinfo:(NSArray*)meetinfo score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7 {
    
    //lets create some bools yo!
    BOOL validJudgeScoreInsert;
    BOOL validResultsInsert;
    BOOL validDiveNumberIncrement;
    
    // lets see what the multiplier for this diver and dive is first
    NSNumber* multiplier = [self DiveNumberDD:divenumber meetInfo:meetinfo];
    
    // lets throw all those scores into a mutable array yo!
    NSArray *scores = [NSMutableArray arrayWithObjects:
                       score1, score2, score3, score4, score5, score6, score7, nil];
    
   NSArray *sortedNumbers = [scores sortedArrayUsingSelector:@selector(compare:)];
    
    // now we only need to get the middle doubles and leave out the lowest and highest
    double finalScore = 0.0;
    //double roundedFinalScore = 0.0;
    double scr1 = [[sortedNumbers objectAtIndex:2] doubleValue];
    double scr2 = [[sortedNumbers objectAtIndex:3] doubleValue];
    double scr3 = [[sortedNumbers objectAtIndex:4] doubleValue];
    
    finalScore = (scr1 + scr2 + scr3) * [multiplier doubleValue];
    
    //commenting out for now. Think we can just convert to NSNumber to round it out.
    //roundedFinalScore = [self RoundUpScore:finalScore];
    if (finalScore < .5) {
        return false;
    }
    
    //update the judge_scores table
    // first convert all the values back to NSNumber
    NSNumber *totalScore = [NSNumber numberWithDouble:finalScore];
    validJudgeScoreInsert = [self UpdateJudgeAllScores:meetid diverid:diverid divenumber:divenumber totalscore:totalScore score1:score1 score2:score2 score3:score3 score4:score4 score5:score5 score6:score6 score7:score7];
    
    //update the results table
    Results *result = [[Results alloc] init];
    validResultsInsert = [result UpdateOneResult:meetid DiverID:diverid DiveNumber:divenumber score:totalScore];
    
    // increment the dive number in the dive_number table
    DiveNumber *number = [[DiveNumber alloc] init];
    validDiveNumberIncrement = [number UpdateDiveNumber:meetid diverid:diverid divenumber:divenumber];

    // now make sure everything was updated correctly
    if (validJudgeScoreInsert && validResultsInsert && validDiveNumberIncrement) {
        return true;
    } else {
        return false;
    }
}

#pragma private methods

-(NSNumber*)calcTotal:(NSNumber*)oneJudge TwoJudge:(NSNumber*)twoJudge ThreeJudge:(NSNumber*)threeJudge FourJudge:(NSNumber*)fourJudge FiveJudge:(NSNumber*)fiveJudge SixJudge:(NSNumber*)SixJudge SevenJudge:(NSNumber*)sevenJudge {
    
    double score1 = [oneJudge doubleValue], score2 = [twoJudge doubleValue], score3 = [threeJudge doubleValue], score4 = [fourJudge doubleValue], score5 = [fiveJudge doubleValue], score6 = [SixJudge doubleValue], score7 = [sevenJudge doubleValue], total;
    
    NSNumber * finalTotal;
    
    total = score1 + score2 + score3 + score4 + score5 + score6 + score7;
    
    return finalTotal = [NSNumber numberWithDouble:total];
    
}

-(NSArray*)GetAllJudgeScores {
    
    NSArray *scores;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from judges_scores"];
    
    scores = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return scores;
}

-(NSNumber*)DiveNumberDD:(int)divenumber meetInfo:(NSArray*)meetInfo {
    
    NSNumber *diveDD;
    
    JudgeScores *dd = [[JudgeScores alloc] init];
    // here we use the divenumber - 1 to get the array index for the correct dive
    dd = [[[[meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:divenumber - 1];
    
    return diveDD = dd.multiplier;
    
}

-(double)RoundUpScore:(double)originalNumber {
    
    // this already formats it, and changing it back to a double gets rid of the rounding
    NSNumber *doubleNumber = [NSNumber numberWithDouble:originalNumber];
    double newScore = 0.0;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode:NSNumberFormatterRoundUp];
    
    NSString *numberString = [formatter stringFromNumber:doubleNumber];
    NSLog(@"Formatted Result %@", numberString);
    
    // this removes the formatting
    return newScore = [numberString doubleValue];
}

-(NSArray*)FetchMeetResults:(int)meetid {
    
    NSArray *info = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"SELECT DISTINCT d.id, d.name, d.school, m.name, m.date, j.judge_total, dt.dive_count, db.first_board, r.total_score, r.dive_1, r.dive_2, r.dive_3, r.dive_4, r.dive_5, r.dive_6, r.dive_7, r.dive_8, r.dive_9, r.dive_10, r.dive_11, js.dive_number, js.dive_type, js.dive_position, js.multiplier, js.failed, js.score_1, js.score_2, js.score_3, js.score_4, js.score_5, js.score_6, js.score_7 FROM diver d INNER JOIN results r on r.diver_id = d.id INNER JOIN meet m on m.id = r.meet_id INNER JOIN judges j on j.meet_id = m.id INNER JOIN dive_total dt on dt.diver_id = d.id AND dt.meet_id=%d INNER JOIN diver_board_size db on db.diver_id = d.id AND db.meet_id=%d INNER JOIN judges_scores js on js.diver_id = d.id AND js.meet_id=%d WHERE m.id=%d ORDER BY d.id asc, db.first_board asc, js.dive_number asc", meetid, meetid, meetid, meetid];
    
    info = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return info;
}
-(NSArray*)FetchMeetScores:(int)meetid diverid:(int)diverid {
    
    NSArray *info = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"SELECT d.id, d.name, d.school, m.name, m.date, r.total_score, r.dive_1, r.dive_2, r.dive_3, r.dive_4, r.dive_5, r.dive_6, r.dive_7, r.dive_8, r.dive_9, r.dive_10, r.dive_11 FROM results r INNER JOIN diver d ON d.id = r.diver_id INNER JOIN meet m ON m.id = r.meet_id WHERE r.meet_id= %d and r.diver_id= %d", meetid, diverid];
    
    info = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return info;
    
}

-(NSArray*)FetchJudgeMeetScores:(int)meetid diverid:(int)diverid {
    
    NSArray *info = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"SELECT d.id, d.name, m.name, js.dive_number, js.dive_type, js.dive_position, js.multiplier, js.total_score, j.judge_total, js.failed, js.score_1, js.score_2, js.score_3, js.score_4, js.score_5, js.score_6, js.score_7 from results r INNER JOIN diver d ON d.id = r.diver_id INNER JOIN meet m ON m.id = r.meet_id INNER JOIN judges j ON j.meet_id = m.id INNER JOIN judges_scores js ON js.diver_id = r.diver_id AND js.meet_id = r.meet_id WHERE js.meet_id=%d AND js.diver_id=%d", meetid, diverid];
    
    info = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return info;
    
}

@end
