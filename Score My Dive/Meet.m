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

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.meetID = [aDecoder decodeObjectForKey:@"meetId"];
        self.meetName = [aDecoder decodeObjectForKey:@"meetName"];
        self.schoolName = [aDecoder decodeObjectForKey:@"schoolName"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.state = [aDecoder decodeObjectForKey:@"state"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.meetID forKey:@"meetId"];
    [aCoder encodeObject:self.meetName forKey:@"meetName"];
    [aCoder encodeObject:self.schoolName forKey:@"schoolName"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.state forKey:@"state"];
    [aCoder encodeObject:self.date forKey:@"date"];
}

-(int)UpdateMeet:(int)mMeetid Name:(NSString*)mName School:(NSString*)mSchool City:(NSString*)mCity State:(NSString*)mState Date:(NSString*)mDate {
    
    int lastInsertRecord;
    
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
        return lastInsertRecord = (int)self.dbManager.lastInsertedRowID;
    } else {
        NSLog(@"Could not execute query");
        return 0;
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

-(NSArray*)GetNameForMeetRank {
    
    NSArray *meets = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select distinct m.id, m.name, d.first_board from meet m inner join diver_board_size d on d.meet_id = m.id where d.first_board > 0 order by m.id asc, d.first_board asc"];
    
    meets = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return meets;
}

@end
