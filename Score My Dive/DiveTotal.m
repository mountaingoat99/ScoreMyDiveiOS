//
//  DiveTotal.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveTotal.h"
#import "DBManager.h"

@interface DiveTotal ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation DiveTotal

-(id)initWithCoder:(NSCoder *)aDecoder {
    if((self = [super init])) {
        self.totalId = [aDecoder decodeObjectForKey:@"totalId"];
        self.meetId = [aDecoder decodeObjectForKey:@"meetId"];
        self.diverId = [aDecoder decodeObjectForKey:@"diverId"];
        self.diveTotal = [aDecoder decodeObjectForKey:@"diveTotal"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.totalId forKey:@"totalId"];
    [aCoder encodeObject:self.meetId forKey:@"meetId"];
    [aCoder encodeObject:self.diverId forKey:@"diverId"];
    [aCoder encodeObject:self.diveTotal forKey:@"diveTotal"];
}

-(BOOL)CreateDiveTotal:(int)meetid DiverID:(int)diverid Total:(int)total {
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;

    query = [NSString stringWithFormat:@"insert into dive_total(meet_id, diver_id, dive_count) values(%d, %d, %d)", meetid, diverid, total];
    
    [self.dbManager executeQuery:query];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        return true;
    } else {
        NSLog(@"Could not execute query");
        return  false;
    }
}

-(NSNumber*)GetDiveTotal:(int)meetid DiverID:(int)diverid {
    
    NSNumber *diveTotal;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;

    query = [NSString stringWithFormat:@"select dive_count from dive_total where meet_id=%d and diver_id=%d", meetid, diverid];
    
    return diveTotal = [self.dbManager loadNumberFromDB:query];
    
}

-(NSArray*)GetDiveTotalObject:(int)meetid DiverID:(int)diverid {
    
    NSArray *diveTotal;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    
    query = [NSString stringWithFormat:@"select * from dive_total where meet_id=%d and diver_id=%d", meetid, diverid];
    
    return diveTotal = [self.dbManager loadDataFromDB:query];
    
}

@end
