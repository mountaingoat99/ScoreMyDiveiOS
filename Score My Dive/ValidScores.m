//
//  ValidScores.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "ValidScores.h"
#import "DBManager.h"

@interface ValidScores ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation ValidScores

-(NSArray*)GetValidScores {
    
//    NSArray *scores = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select scores from valid_scores"];
    
    NSArray *scores = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return scores;
}

@end
