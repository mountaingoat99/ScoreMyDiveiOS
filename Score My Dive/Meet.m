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

-(BOOL)UpdateMeet:(int)mMeetid Name:(NSString*)mName School:(NSString*)mSchool City:(NSString*)mCity State:(NSString*)mState Date:(NSString*)mDate {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    
    if (mMeetid == -1) {
        query = [NSString stringWithFormat:@"insert into meet(name, school, city, state, date) values('%@','%@','%@','%@','%@')", mName, mSchool, mCity, mState, mDate];
        NSLog(@"Meet insert");
    } else {
        query = [NSString stringWithFormat:@"update meet set name='%@', school='%@', city='%@', state='%@', date='%@' where id=%d", mName, mSchool, mCity, mState, mDate, mMeetid];
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

-(NSString*)GetMeetName:(int)meetid {
    
    NSString *theMeetName;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select name from meet where id=%d", meetid];
    
    return theMeetName = [self.dbManager loadOneDataFromDB:query];
}

-(NSArray*)GetTheMeet:(int)meetid {
    
    //init DB, Array, and Object
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    NSArray *meetInfo = [[NSArray alloc] init];
    //Meet *theMeet = [[Meet alloc] init];

    // query
    NSString *query = [NSString stringWithFormat:@"select * from meet where id=%d", meetid];
    
    // get the data
    meetInfo = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return meetInfo;
}

-(NSArray*)GetMeetHistory:(int)diverid {
    
    NSArray *divers = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"SELECT m.id, m.name, m.date FROM meet m INNER JOIN results r on (m.id = r.meet_id) WHERE r.diver_id=%d", diverid];
    
    divers = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return divers;
}

@end
