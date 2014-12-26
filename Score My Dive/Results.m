//
//  Results.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "Results.h"
#import "DBManager.h"

@interface Results ()

@property (nonatomic, strong) DBManager *dbManager;

-(NSNumber*)calcTotal:(NSNumber*)oneDive TwoDive:(NSNumber*)twoDive ThreeDive:(NSNumber*)threeDive FourDive:(NSNumber*)fourDive FiveDive:(NSNumber*)fiveDive SixDive:(NSNumber*)SixDive SevenDive:(NSNumber*)sevenDive EightDive:(NSNumber*)eightDive NineDive:(NSNumber*)nineDive TenDive:(NSNumber*)tenDive ElevenDive:(NSNumber*)elevenDive;

-(BOOL)UpdateResultTotal:(int)meetid DiverID:(int)diverid;

@end

@implementation Results

#pragma Public methods

-(BOOL)CreateResult:(int)meetid DiverID:(int)diverid Dive1:(NSNumber*)dive1 Dive2:(NSNumber*)dive2 Dive3:(NSNumber*)dive3 Dive4:(NSNumber*)dive4 Dive5:(NSNumber*)dive5 Dive6:(NSNumber*)dive6 Dive7:(NSNumber*)dive7 Dive8:(NSNumber*)dive8 Dive9:(NSNumber*)dive9 Dive10:(NSNumber*)dive10 Dive11:(NSNumber*)dive11 DiveScoreTotal:(NSNumber*)divescoretotal {
    
    // call the method to calculate the total
    NSNumber *total;
    total = [self calcTotal:dive1 TwoDive:dive2 ThreeDive:dive3 FourDive:dive4 FiveDive:dive5 SixDive:dive6 SevenDive:dive7 EightDive:dive8 NineDive:dive9 TenDive:dive10 ElevenDive:dive11];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    
    NSString *result = [self CheckResults:meetid DiverID:diverid];
    
    if (result == nil) {
        query = [NSString stringWithFormat:@"insert into results(meet_id, diver_id, dive_1, dive_2, dive_3, dive_4, dive_5, dive_6, dive_7, dive_8, dive_9, dive_10, dive_11, total_score) values(%d, %d, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@, %@)", meetid, diverid, dive1, dive2, dive3, dive4, dive5, dive6, dive7, dive8, dive9, dive10, dive11, total];
    } else {
        query = [NSString stringWithFormat:@"update results set dive_1=%@, dive_2=%@, dive_3=%@, dive_4=%@, dive_5=%@, dive_6=%@, dive_7=%@, dive_8=%@, dive_9=%@, dive_10=%@, dive_11=%@, total_score=%@ where meet_id=%d and diver_id=%d", dive1, dive2, dive3, dive4, dive5, dive6, dive7, dive8, dive9, dive10, dive11, total, meetid, diverid];
    }
    
    [self.dbManager executeQuery:query];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Results query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        return true;
    } else {
        NSLog(@"Results could not execute query");
        return  false;
    }
}

-(BOOL)UpdateOneResult:(int)meetid DiverID:(int)diverid DiveNumber:(int)divenumber score:(NSNumber*)score {
    
    BOOL validResultUpdate;
    BOOL validResultTotal;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    NSString *query;
    
    switch (divenumber) {
        case 1:
            query = [NSString stringWithFormat:@"update results set dive_1=%@ where meet_id=%d and diver_id=%d", score, meetid, diverid];
            break;
        case 2:
            query = [NSString stringWithFormat:@"update results set dive_2=%@ where meet_id=%d and diver_id=%d", score, meetid, diverid];
            break;
        case 3:
            query = [NSString stringWithFormat:@"update results set dive_3=%@ where meet_id=%d and diver_id=%d", score, meetid, diverid];
            break;
        case 4:
            query = [NSString stringWithFormat:@"update results set dive_4=%@ where meet_id=%d and diver_id=%d", score, meetid, diverid];
            break;
        case 5:
            query = [NSString stringWithFormat:@"update results set dive_5=%@ where meet_id=%d and diver_id=%d", score, meetid, diverid];
            break;
        case 6:
            query = [NSString stringWithFormat:@"update results set dive_6=%@ where meet_id=%d and diver_id=%d", score, meetid, diverid];
            break;
        case 7:
            query = [NSString stringWithFormat:@"update results set dive_7=%@ where meet_id=%d and diver_id=%d", score, meetid, diverid];
            break;
        case 8:
            query = [NSString stringWithFormat:@"update results set dive_8=%@ where meet_id=%d and diver_id=%d", score, meetid, diverid];
            break;
        case 9:
            query = [NSString stringWithFormat:@"update results set dive_9=%@ where meet_id=%d and diver_id=%d", score, meetid, diverid];
            break;
        case 10:
            query = [NSString stringWithFormat:@"update results set dive_10=%@ where meet_id=%d and diver_id=%d", score, meetid, diverid];
            break;
        case 11:
            query = [NSString stringWithFormat:@"update results set dive_11=%@ where meet_id=%d and diver_id=%d", score, meetid, diverid];
            break;
        default:
            break;
    }
    
    [self.dbManager executeQuery:query];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Results query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        validResultUpdate = true;
        
        if (validResultUpdate) {
            validResultTotal = [self UpdateResultTotal:meetid DiverID:diverid];
            
            if (validResultTotal) {
                return true;
            } else {
                return false;
            }
        }
        
    } else {
        NSLog(@"Results could not execute query");
        return false;
    }
    
    return false;
}

-(BOOL)UpdateTotal:(int)meetid DiverID:(int)diverid Total:(NSNumber*)total {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"update results set total_score=%@ where meet_id=%d and diver_id=%d", total, meetid, diverid];
    
    [self.dbManager executeQuery:query];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Results query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        return true;
    } else {
        NSLog(@"Results could not execute query");
        return  false;
    }
}

-(NSArray*)GetResults:(int)meetid DiverId:(int)diverid {
    
    NSArray *results = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select dive_1, dive_2, dive_3, dive_4, dive_5, dive_6, dive_7, dive_8, dive_9, dive_10, dive_11, total_score from results where meet_id=%d and diver_id=%d", meetid, diverid];
    
    results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return results;
    
}

-(NSArray*)GetScores:(int)meetid DiverId:(int)diverid {
    
    NSArray *results = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select dive_1, dive_2, dive_3, dive_4, dive_5, dive_6, dive_7, dive_8, dive_9, dive_10, dive_11 from results where meet_id=%d and diver_id=%d", meetid, diverid];
    
    results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return results;
    
}

-(NSArray*)GetResultObject:(int)meetid DiverId:(int)diverid {
    
    NSArray *results = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from results where meet_id=%d and diver_id=%d", meetid, diverid];
    
    results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return results;
    
}

-(NSNumber*)GetResultTotal:(int)meetid DiverID:(int)diverid {
    
    NSNumber *totalScore;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select total_score from results where meet_id=%d and diver_id=%d", meetid, diverid];

    return totalScore = [self.dbManager loadNumberFromDB:query];
    
}

-(NSString*)CheckResults:(int)meetid DiverID:(int)diverid {
    
    NSString *result;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select id from results where meet_id=%d and diver_id=%d", meetid, diverid];
    
    return  result = [self.dbManager loadOneDataFromDB:query];
    
}

-(BOOL)ResultsExist:(int)meetid {
    
    NSString *result;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select meet_id from results where meet_id=%d", meetid];
    
    result = [self.dbManager loadOneDataFromDB:query];
    
    if (result != nil) {
        return true;
    } else {
        return false;
    }
}

#pragma private methods

-(NSNumber*)calcTotal:(NSNumber*)oneDive TwoDive:(NSNumber*)twoDive ThreeDive:(NSNumber*)threeDive FourDive:(NSNumber*)fourDive FiveDive:(NSNumber*)fiveDive SixDive:(NSNumber*)sixDive SevenDive:(NSNumber*)sevenDive EightDive:(NSNumber*)eightDive NineDive:(NSNumber*)nineDive TenDive:(NSNumber*)tenDive ElevenDive:(NSNumber*)elevenDive {
    
    double dive1 = [oneDive doubleValue], dive2 = [twoDive doubleValue], dive3 = [threeDive doubleValue], dive4 = [fourDive doubleValue], dive5 = [fiveDive doubleValue], dive6 = [sixDive doubleValue], dive7 = [sevenDive doubleValue], dive8 = [eightDive doubleValue], dive9 = [nineDive doubleValue], dive10 = [tenDive doubleValue], dive11 = [elevenDive doubleValue], total;
    
    NSNumber * finalTotal;
    
    total = dive1 + dive2 + dive3 + dive4 + dive5 + dive6 + dive7 + dive8 + dive9 + dive10 + dive11;
    
    return finalTotal = [NSNumber numberWithDouble:total];
    
}

-(BOOL)UpdateResultTotal:(int)meetid DiverID:(int)diverid {
    
    BOOL valid;
    
    NSArray *results = [[NSArray alloc] init];
    results = [self GetScores:meetid DiverId:diverid];
    
    // throw the results into ints
    double score1 = [[[results objectAtIndex:0] objectAtIndex:0] doubleValue];
    double score2 = [[[results objectAtIndex:0] objectAtIndex:1] doubleValue];
    double score3 = [[[results objectAtIndex:0] objectAtIndex:2] doubleValue];
    double score4 = [[[results objectAtIndex:0] objectAtIndex:3] doubleValue];
    double score5 = [[[results objectAtIndex:0] objectAtIndex:4] doubleValue];
    double score6 = [[[results objectAtIndex:0] objectAtIndex:5] doubleValue];
    double score7 = [[[results objectAtIndex:0] objectAtIndex:6] doubleValue];
    double score8 = [[[results objectAtIndex:0] objectAtIndex:7] doubleValue];
    double score9 = [[[results objectAtIndex:0] objectAtIndex:8] doubleValue];
    double score10 = [[[results objectAtIndex:0] objectAtIndex:9] doubleValue];
    double score11 = [[[results objectAtIndex:0] objectAtIndex:10] doubleValue];
    
    // sum them
    double total = score1 + score2 + score3 + score4 + score5 + score6 + score7 + score8 + score9 + score10 + score11;
    
    // convert back to NSNumber
    NSNumber *sum = [NSNumber numberWithDouble:total];
    
    // update the record
    valid = [self UpdateTotal:meetid DiverID:diverid Total:sum];
    
    if (valid) {
        return true;
    } else {
        return false;
    }
    
}

@end
