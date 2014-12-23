//
//  JudgeScores.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "JudgeScores.h"
#import "DBManager.h"

@interface JudgeScores ()

@property (nonatomic, strong) DBManager *dbManager;

-(NSNumber*)calcTotal:(NSNumber*)oneJudge TwoJudge:(NSNumber*)twoJudge ThreeJudge:(NSNumber*)threeJudge FourJudge:(NSNumber*)fourJudge FiveJudge:(NSNumber*)fiveJudge SixJudge:(NSNumber*)SixJudge SevenJudge:(NSNumber*)sevenJudge;
-(NSArray*)GetAllJudgeScores;

@end

@implementation JudgeScores

#pragma public methods

-(BOOL)CreateJudgeScores:(int)meetid diverid:(int)diverid boardsize:(double)boardsize divenumber:(NSNumber*)divenumber divecategory:(NSString*)divecategory divetype:(NSString*)divetype diveposition:(NSString*)diveposition failed:(NSNumber*)failed multiplier:(NSNumber*)multiplier totalscore:(NSNumber*)totalscore score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7 {
    
    //call the method to calc the total
    NSNumber *total;
    total = [self calcTotal:score1 TwoJudge:score2 ThreeJudge:score3 FourJudge:score4 FiveJudge:score5 SixJudge:score6 SevenJudge:score7];
    
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
    
    numbers = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    int count = numbers.count;
    
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

-(void)UpdateJudgeAllScoresFailed:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber failed:(NSNumber*)failed totalscore:(NSNumber*)totalscore score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7 {
    
    //call the calcTotal method
    NSNumber *total;
    total = [self calcTotal:score1 TwoJudge:score2 ThreeJudge:score3 FourJudge:score4 FiveJudge:score5 SixJudge:score6 SevenJudge:score7];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"update judges_scores set failed=%@, total_score=%@, score_1=%@, score_2=%@, score_3=%@, score_4=%@, score_5=%@, score_6=%@, score_7=%@ where meet_id=%d and diver_id=%d and dive_number=%@", failed, total, score1, score2, score3, score4, score5, score6, score7, meetid, diverid, divenumber];
    
    [self.dbManager executeQuery:query];
    
}

-(void)UpdateJudgeFailed:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber failed:(NSNumber*)failed totalscore:(NSNumber*)totalscore {
    
    // here we need to get the old total, and then minus the score we are failing and update the score
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"update judges_scores set failed=%@, total_score=%@ where meet_id=%d and diver_id=%d and dive_number=%@", failed, totalscore, meetid, diverid, divenumber];
    
    [self.dbManager executeQuery:query];
    
}

-(void)UpdateJudgeAllScores:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber totalscore:(NSNumber*)totalscore score1:(NSNumber*)score1 score2:(NSNumber*)score2 score3:(NSNumber*)score3 score4:(NSNumber*)score4 score5:(NSNumber*)score5 score6:(NSNumber*)score6 score7:(NSNumber*)score7 {
    
    //call the calcTotal method
    NSNumber *total;
    total = [self calcTotal:score1 TwoJudge:score2 ThreeJudge:score3 FourJudge:score4 FiveJudge:score5 SixJudge:score6 SevenJudge:score7];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"update judges_scores set total_score=%@, score_1=%@, score_2=%@, score_3=%@, score_4=%@, score_5=%@, score_6=%@, score_7=%@ where meet_id=%d and diver_id=%d and dive_number=%@", total, score1, score2, score3, score4, score5, score6, score7, meetid, diverid, divenumber];
    
    [self.dbManager executeQuery:query];
    
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
        
        int count = check.count;
        
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

@end
