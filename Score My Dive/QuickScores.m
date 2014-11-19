//
//  QuickScores.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "QuickScores.h"
#import "DBManager.h"

@interface QuickScores ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation QuickScores

#pragma PublicMethods

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

#pragma DataInterface
-(BOOL)updateQuickScore:(int)idToEdit Name:(NSString *)name Dive1:(NSString *)dive1 Dive2:(NSString *)dive2 Dive3:(NSString *)dive3 Dive4:(NSString *)dive4 Dive5:(NSString *)dive5 Dive6:(NSString *)dive6 Dive7:(NSString *)dive7 Dive8:(NSString *)dive8 Dive9:(NSString *)dive9 Dive10:(NSString *)dive10 Dive11:(NSString *)dive11 Total:(NSString *)total {
    
    // initilize the database
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
                      
    NSString *query;
    
    // get the id and see if this is an insert or update
    if (idToEdit == -1) {
        // insert
        query = [NSString stringWithFormat:@"insert into quick_score(name_meet, dive_1, dive_2, dive_3, dive_4, dive_5, dive_6, dive_7, dive_8, dive_9, dive_10, dive_11, total_score) values('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", name, dive1, dive2, dive3, dive4, dive5, dive6, dive7, dive8, dive9, dive10, dive11, total];
        NSLog(@"quick score insert query");
    } else {
        // update
        query = [NSString stringWithFormat:@"update quick_score set name_meet='%@', dive_1='%@', dive_2='%@', dive_3='%@', dive_4='%@', dive_5='%@', dive_6='%@', dive_7='%@', dive_8='%@', dive_9='%@', dive_10='%@', dive_11='%@', total_score='%@' where id=%d", name, dive1, dive2, dive3, dive4, dive5, dive6, dive7, dive8, dive9, dive10, dive11, total, idToEdit];
        NSLog(@"quick score update query");
    }
    
    // execute the query
    [self.dbManager executeQuery:query];
    
    // if the query was succesfully executed then pop the view controller
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        return true;
        
        } else {
        NSLog(@"Could not execute the query");
        return false;
    }
}

-(NSArray*)loadInfo:(int)idToLoad {
    
    // initilize the database
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    // create the query
    NSString *query = [NSString stringWithFormat:@"select * from quick_score where id=%d", idToLoad];
    
    //load the correct record
    NSArray *results = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return results;
}















@end
