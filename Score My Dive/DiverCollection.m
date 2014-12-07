//
//  DiverCollection.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/6/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiverCollection.h"
#import "Diver.h"
#import "DiveList.h"
#import "DiveTotal.h"
#import "DiveNumber.h"
#import "DiverBoardSize.h"
#import "JudgeScores.h"
#import "Results.h"
#import "Meet.h"

@interface DiverCollection ()

-(Diver*)CallDiver:(int)diverid;
-(DiveList*)CallDiveList:(int)meetid diverid:(int)diverid;
-(DiveTotal*)CallDiveTotal:(int)meetid diverid:(int)diverid;
-(DiverBoardSize*)CallBoardSize:(int)meetid diverid:(int)diverid;
-(JudgeScores*)CallJudgeScores:(int)meetid diverid:(int)diverid;
-(Results*)CallResults:(int)meetid diverid:(int)diverid;

@end

@implementation DiverCollection

#pragma public methods

// this will give me a diver and all of it's children
// including the meets the diver has been in
-(NSArray*)GetDiverInfo:(int)diverid {
    
    
    
}

// this will get me all the divers by a meet specified and the diver
// child objects
-(NSArray*)GetDiverInfoByMeet:(int)meetid {
    
}

#pragma private methods

-(Diver*)CallDiver:(int)diverid {
    
}

-(DiveList*)CallDiveList:(int)meetid diverid:(int)diverid {
    
}
-(DiveTotal*)CallDiveTotal:(int)meetid diverid:(int)diverid {
    
}
-(DiverBoardSize*)CallBoardSize:(int)meetid diverid:(int)diverid {
    
}

-(JudgeScores*)CallJudgeScores:(int)meetid diverid:(int)diverid {
    
}
-(Results*)CallResults:(int)meetid diverid:(int)diverid {
    
}

@end
