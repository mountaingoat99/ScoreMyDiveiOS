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

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.numberId = [aDecoder decodeObjectForKey:@"numberId"];
        self.meetId = [aDecoder decodeObjectForKey:@"meetId"];
        self.diverId = [aDecoder decodeObjectForKey:@"diverId"];
        self.number = [aDecoder decodeObjectForKey:@"number"];
        self.boardSize = [aDecoder decodeObjectForKey:@"boardSize"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.numberId forKey:@"numberId"];
    [aCoder encodeObject:self.meetId forKey:@"meetId"];
    [aCoder encodeObject:self.diverId forKey:@"diverId"];
    [aCoder encodeObject:self.number forKey:@"number"];
    [aCoder encodeObject:self.boardSize forKey:@"boardSize"];
}

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

-(BOOL)UpdateDiveNumber:(int)meetid diverid:(int)diverid divenumber:(int)divenumber {
    
    // first we need to see what dive number thye are currently on
    NSNumber *currentDive = [self WhatDiveNumber:meetid diverid:diverid];
    
    // convert the current and paramter to ints soe we can do a proper compare
    int currentInt = [currentDive intValue];
    // now we will see if we even need to increment the number.
    // if it is the same or greater than the current we don't have to increment
    // we do this because in the diveList scoring screens the user can change the score anytime
    if (currentInt >= divenumber) {
        
        return true;
        
    } else {
    
        self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
        
        NSString *query = [NSString stringWithFormat:@"update dive_number set number=%d where meet_id=%d and diver_id=%d", divenumber, meetid, diverid];
        
        [self.dbManager executeQuery:query];
        
        if(self.dbManager.affectedRows != 0) {
            NSLog(@"query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
            return true;
        } else {
            NSLog(@"Could not execute query");
            return  false;
        }
    }
}

-(BOOL)DiveNumberForRankings:(int)meetid diverid:(int)diverid {
    
    NSNumber *num;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select number from dive_number where meet_id=%d and diver_id=%d", meetid, diverid];
    
    num = [self.dbManager loadNumberFromDB:query];
    
    if ([num isEqualToNumber:@0]) {
        return false;
    } else {
        return true;
    }
}

@end
