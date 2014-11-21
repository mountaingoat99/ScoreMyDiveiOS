//
//  Meet.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "Meet.h"
#import "DBManager.h"

@interface Meet ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation Meet

-(BOOL)UpdateMeet:(int)meetid Name:(NSString*)name School:(NSString*)school City:(NSString*)city State:(NSString*)state Date:(NSString*)date {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    
    if (meetid == -1) {
        query = [NSString stringWithFormat:@"insert into meet(name, school, city, state, date) values('%@','%@','%@','%@','%@')", name, school, city, state, date];
        NSLog(@"Meet insert");
    } else {
        query = [NSString stringWithFormat:@"update meet set name='%@', school='%@', city='%@', state='%@', date='%@' where id=%d", name, school, city, state, date, meetid];
        NSLog(@"Meet Update");
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

-(NSArray*)GetAllMeets {
    NSArray *meets = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = @"select * from meet";
    
    meets = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return meets;
    
}

-(NSArray*)LoadMeet:(int)meetid {
    
    NSArray *meet = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from meet where id=%d", meetid];
    
    meet = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return meet;
}

-(void)DeleteMeet:(int)meetid {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"delete from meet where id=%d", meetid];
    
    [self.dbManager executeQuery:query];
    
}

@end
