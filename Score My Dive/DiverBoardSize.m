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

-(id)initWithCoder:(NSCoder *)aDecoder {
    if((self = [super init])) {
        self.boardId = [aDecoder decodeObjectForKey:@"BoardId"];
        self.meetId = [aDecoder decodeObjectForKey:@"MeetId"];
        self.diverId = [aDecoder decodeObjectForKey:@"DiverId"];
        self.firstSize = [aDecoder decodeObjectForKey:@"First"];
        self.secondSize = [aDecoder decodeObjectForKey:@"Second"];
        self.thirdSize = [aDecoder decodeObjectForKey:@"Third"];
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.boardId forKey:@"BoardId"];
    [aCoder encodeObject:self.meetId forKey:@"MeetId"];
    [aCoder encodeObject:self.diverId forKey:@"DiverId"];
    [aCoder encodeObject:self.firstSize forKey:@"First"];
    [aCoder encodeObject:self.secondSize forKey:@"Second"];
    [aCoder encodeObject:self.thirdSize forKey:@"Third"];
}

-(BOOL)CreateBoardSize:(int)meetid DiverID:(int)diverid Total:(double)size TotalBoards:(int)totalboards{
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    
    if (totalboards == 1) {
        query = [NSString stringWithFormat:@"insert into diver_board_size(meet_id, diver_id, first_board, second_board, third_board) values(%d, %d, %f, %f, %f)", meetid, diverid, size, 0.0, 0.0];
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

-(NSArray*)GetBoardSizeObject:(int)meetid diverid:(int)diverid {
    
    NSArray *boards;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query;
    
    query = [NSString stringWithFormat:@"select * from diver_board_size where meet_id=%d and diver_id=%d", meetid, diverid];
    
    return boards = [self.dbManager loadDataFromDB:query];
    
}

@end
