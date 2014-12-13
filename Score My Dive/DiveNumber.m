//
//  DiveNumber.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveNumber.h"
#import "DBManager.h"

@interface DiveNumber ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation DiveNumber

-(BOOL)CreateDiveNumber:(int)meetid diverid:(int)diverid number:(NSNumber*)number boardsize:(double)boardsize {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    
    query = [NSString stringWithFormat:@"insert into dive_number(meet_id, diver_id, number, board_size) values(%d, %d, %@, %f)", meetid, diverid, number, boardsize];
    
    [self.dbManager executeQuery:query];
    
    if(self.dbManager.affectedRows != 0) {
        NSLog(@"query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        return true;
    } else {
        NSLog(@"Could not execute query");
        return  false;
    }
}

-(NSNumber*)WhatDiveNumber:(int)meetid diverid:(int)diverid {
    
    NSNumber *num;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select number from dive_number where meet_id=%d and diver_id=%d", meetid, diverid];
    
    return num = [self.dbManager loadNumberFromDB:query];
    
}

-(NSArray*)GetDiveNumber:(int)meetid diverid:(int)diverid {
    
    NSArray *num;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from dive_number where meet_id=%d and diver_id=%d", meetid, diverid];
    
    return num = [self.dbManager loadDataFromDB:query];
    
}

-(void)UpdateDiveNumber:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"update dive_number set number=%@ where meet_id=%d and diver_id=%d", divenumber, meetid, diverid];
    
    [self.dbManager loadDataFromDB:query];
    
}

@end
