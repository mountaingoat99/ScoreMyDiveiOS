//
//  DiveList.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveList.h"
#import "DBManager.h"

@interface DiveList ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation DiveList

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super init])) {
        self.listId = [aDecoder decodeObjectForKey:@"listId"];
        self.meetId = [aDecoder decodeObjectForKey:@"meetId"];
        self.diverId = [aDecoder decodeObjectForKey:@"diverId"];
        self.listFilled = [aDecoder decodeObjectForKey:@"listFilled"];
        self.noList = [aDecoder decodeObjectForKey:@"noList"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.listId forKey:@"listId"];
    [aCoder encodeObject:self.meetId forKey:@"meetId"];
    [aCoder encodeObject:self.diverId forKey:@"diverId"];
    [aCoder encodeObject:self.listFilled forKey:@"listFilled"];
    [aCoder encodeObject:self.noList forKey:@"noList"];
}

-(BOOL)UpdateDiveList:(int)meetid diverid:(int)diverid listfilled:(NSNumber*)listfilled noList:(NSNumber*)nolist {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    
    query = [NSString stringWithFormat:@"insert into dive_list(meet_id, diver_id, list_filled, no_list) values(%d, %d, %@, %@)", meetid, diverid, listfilled, nolist];
    
    [self.dbManager executeQuery:query];
    
    if(self.dbManager.affectedRows != 0) {
        NSLog(@"query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        return true;
    } else {
        NSLog(@"Could not execute query");
        return  false;
    }
}

-(NSArray*)GetDiveList:(int)meetid diverid:(int)diverid {
    
    NSArray *list;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from dive_list where meet_id=%d and diver_id=%d", meetid, diverid];
    
    list = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return list;
    
}

-(BOOL)CheckForNoList:(int)meetid diverid:(int)diverid {
    
    NSNumber *num;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select no_list from dive_list where meet_id=%d and diver_id=%d", meetid, diverid];
    
    num = [self.dbManager loadNumberFromDB:query];
    
    if ([num isEqualToNumber:@0]) {
        return false;
    } else {
        return true;
    }
}

-(void)MarkNoList:(int)meetid diverid:(int)diverid {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"update dive_list set no_list=1 where meet_id=%d and diver_id=%d", meetid, diverid];
    
    [self.dbManager executeQuery:query];
    
}

-(void)UpdateListFilled:(int)meetid diverid:(int)diverid key:(NSNumber*)key {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"update dive_list set list_filled=%@ where meet_id=%d and diver_id=%d", key, meetid, diverid];
    
    [self.dbManager executeQuery:query];

}

-(void)updateListStarted:(int)meetid diverid:(int)diverid {
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"update dive_list set list_filled=%@ where meet_id=%d and diver_id=%d",@1, meetid, diverid];
    
    [self.dbManager executeQuery:query];
    
}

-(NSNumber*)IsListFinished:(int)meetid diverid:(int)diverid {
    
    NSNumber *num;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select list_filled from dive_list where meet_id=%d and diver_id=%d", meetid, diverid];
    
    num = [self.dbManager loadNumberFromDB:query];
    
    return num;
    
}

@end
