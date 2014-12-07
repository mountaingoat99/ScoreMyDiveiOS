//
//  Diver.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "Diver.h"
#import "DBManager.h"

@interface Diver ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation Diver

-(BOOL)UpdateDiver:(int)diverid Name:(NSString*)name Age:(NSString*)age Grade:(NSString*)grade School:(NSString*)school {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    
    if (diverid == -1) {
        query = [NSString stringWithFormat:@"insert into diver(name, age, grade, school) values('%@','%@','%@','%@')", name, age, grade, school];
        NSLog(@"Diver insert");
    } else {
        query = [NSString stringWithFormat:@"update diver set name='%@', age='%@', grade='%@', school='%@' where id=%d", name, age, grade, school, diverid];
        NSLog(@"Diver Update");
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

-(NSArray*)GetAllDivers {
    
    NSArray *divers = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from diver"];
    
    divers = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return divers;
    
}

-(NSArray*)LoadDiver:(int)diverid {
    
    NSArray *diver = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from diver where id=%d", diverid];
    
    diver = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return diver;
    
}

-(void)DeleteDiver:(int)diverid {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"delete from diver where id=%d", diverid];
    
    [self.dbManager executeQuery:query];
    
}

-(NSArray*)DiversAtMeet:(int)meetid {
    
    NSArray *divers = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"SELECT d.id, d.name, d.school FROM diver d INNER JOIN results r on (d.id = r.diver_id) WHERE r.meet_id=%d", meetid];
    
    divers = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return divers;
    
}

-(void)RemoveDiverFromMeet:(int)meetid diverid:(int)diverid {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query1 = [NSString stringWithFormat:@"delete from dive_number where meet_id=%d and diver_id=%d", meetid, diverid];
    
    NSString *query2 = [NSString stringWithFormat:@"delete from judges_scores where meet_id=%d and diver_id=%d", meetid, diverid];
    
    NSString *query3 = [NSString stringWithFormat:@"delete from results where meet_id=%d and diver_id=%d", meetid, diverid];
    
    NSString *query4 = [NSString stringWithFormat:@"delete from dive_total where meet_id=%d and diver_id=%d", meetid, diverid];
    
    NSString *query5 = [NSString stringWithFormat:@"delete from diver_board_size where meet_id=%d and diver_id=%d", meetid, diverid];
    
    NSString *query6 = [NSString stringWithFormat:@"delete from dive_list where meet_id=%d and diver_id=%d", meetid, diverid];
    
    [self.dbManager loadDataFromDB:query1];
    [self.dbManager loadDataFromDB:query2];
    [self.dbManager loadDataFromDB:query3];
    [self.dbManager loadDataFromDB:query4];
    [self.dbManager loadDataFromDB:query5];
    [self.dbManager loadDataFromDB:query6];
    
}





























@end
