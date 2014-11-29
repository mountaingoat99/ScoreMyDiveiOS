//
//  Judges.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "Judges.h"
#import "DBManager.h"

@interface Judges ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation Judges

-(BOOL)UpdateJudges:(int)meetid Total:(NSNumber*)total {
    
    NSNumber *testNumber = @0;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    Judges *judges = [[Judges alloc] init];
    
    testNumber = [judges getJudges:meetid];
    
    if ([testNumber isEqualToNumber:@0]) {
        
        query = [NSString stringWithFormat:@"insert into judges(meet_id, judge_total) values(%d, %@)", meetid, total];
        NSLog(@"Judges Insert");
    } else {
        query = [NSString stringWithFormat:@"update judges set judge_total=%@ where meet_id=%d", total, meetid];
        NSLog(@"Judges Update");
    }
    
    [self.dbManager executeQuery:query];
    
    if(self.dbManager.affectedRows != 0) {
        NSLog(@"query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        return true;
    } else {
        NSLog(@"Could not execute query");
        return  false;
    }
}

-(NSNumber*)getJudges:(int)meetid {
    NSNumber *judges = 0;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    
    query = [NSString stringWithFormat:@"select judge_total from judges where meet_id=%d", meetid];
    
    return judges = [self.dbManager loadNumberFromDB:query];
    
}

@end
