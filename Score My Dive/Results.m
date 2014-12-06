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
    
    if ([result isEqualToString:nil]) {
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

-(NSArray*)GetResults:(int)meetid DiverId:(int)diverid {
    
    NSArray *results = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select dive_1, dive_2, dive_3, dive_4, dive_5, dive_6, dive_7, dive_8, dive_9, dive_10, dive_11, total_score from results where meet_id=%d and diver_id=%d", meetid, diverid];
    
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

#pragma private methods

-(NSNumber*)calcTotal:(NSNumber*)oneDive TwoDive:(NSNumber*)twoDive ThreeDive:(NSNumber*)threeDive FourDive:(NSNumber*)fourDive FiveDive:(NSNumber*)fiveDive SixDive:(NSNumber*)sixDive SevenDive:(NSNumber*)sevenDive EightDive:(NSNumber*)eightDive NineDive:(NSNumber*)nineDive TenDive:(NSNumber*)tenDive ElevenDive:(NSNumber*)elevenDive {
    
    double dive1 = [oneDive doubleValue], dive2 = [twoDive doubleValue], dive3 = [threeDive doubleValue], dive4 = [fourDive doubleValue], dive5 = [fiveDive doubleValue], dive6 = [sixDive doubleValue], dive7 = [sevenDive doubleValue], dive8 = [eightDive doubleValue], dive9 = [nineDive doubleValue], dive10 = [tenDive doubleValue], dive11 = [elevenDive doubleValue], total;
    
    NSNumber * finalTotal;
    
    total = dive1 + dive2 + dive3 + dive4 + dive5 + dive6 + dive7 + dive8 + dive9 + dive10 + dive11;
    
    return finalTotal = [NSNumber numberWithDouble:total];
    
}

@end
