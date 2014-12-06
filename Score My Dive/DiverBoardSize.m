//
//  DiverBoardSize.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiverBoardSize.h"
#import "DBManager.h"

@interface DiverBoardSize ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation DiverBoardSize

-(BOOL)CreateBoardSize:(int)meetid DiverID:(int)diverid Total:(double)size TotalBoards:(int)totalboards{
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    
    if (totalboards == 1) {
        query = [NSString stringWithFormat:@"insert into diver_board_size(meet_id, diver_id, first_board) values(%d, %d, %f)", meetid, diverid, size];
    } else if (totalboards == 2) {
        query = [NSString stringWithFormat:@"update diver_board_size set second_board=%f where meet_id=%d and diver_id=%d", size, meetid, diverid];
    } else if (totalboards == 3) {
        query = [NSString stringWithFormat:@"update diver_board_size set third_board=%f where meet_id=%d and diver_id=%d", size, meetid, diverid];
    }
    
    [self.dbManager executeQuery:query];
    
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"DiverBoardSize query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        return true;
    } else {
        NSLog(@"DiverBoardSize could not execute query");
        return  false;
    }
}

-(NSNumber*)BoardSize:(int)meetid DiverID:(int)diverid BoardNumber:(int)boardnumber {
    
    NSNumber *boardSize;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    
    if (boardnumber == 1) {
        query = [NSString stringWithFormat:@"select first_board from diver_board_size where meet_id=%d and diver_id=%d", meetid, diverid];
    } else if (boardnumber == 2) {
        query = [NSString stringWithFormat:@"select second_board from diver_board_size where meet_id=%d and diver_id=%d", meetid, diverid];
    } else if (boardnumber == 3) {
        query = [NSString stringWithFormat:@"select third_board from diver_board_size where meet_id=%d and diver_id=%d", meetid, diverid];
    }
    
    return boardSize = [self.dbManager loadNumberFromDB:query];
    
}

@end
