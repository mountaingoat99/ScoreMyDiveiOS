//
//  DiverBoardSize.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiverBoardSize : NSObject <NSCoding>

@property (nonatomic, copy) NSString *boardId;
@property (nonatomic, copy) NSString *meetId;
@property (nonatomic, copy) NSString *diverId;
@property (nonatomic) NSNumber *firstSize;
@property (nonatomic) NSNumber *secondSize;
@property (nonatomic) NSNumber *thirdSize;

-(BOOL)CreateBoardSize:(int)meetid DiverID:(int)diverid Total:(double)size TotalBoards:(int)totalboards;

-(NSNumber*)BoardSize:(int)meetid DiverID:(int)diverid BoardNumber:(int)boardnumber;

-(NSArray*)GetBoardSizeObject:(int)meetid diverid:(int)diverid;

@end
