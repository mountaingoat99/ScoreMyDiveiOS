//
//  DiverBoardSize.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiverBoardSize : NSObject

@property (nonatomic) double *boardSize;

-(BOOL)CreateBoardSize:(int)meetid DiverID:(int)diverid Total:(double)size TotalBoards:(int)totalboards;

-(double)GetBoardSize:(int)meetid DiverID:(int)diverid BoardNumber:(int)boardnumber;

@end
