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
// diver info by meet
-(DiveList*)CallDiveList:(int)meetid diverid:(int)diverid;
-(DiveTotal*)CallDiveTotal:(int)meetid diverid:(int)diverid;
-(DiveNumber*)CallDiveNumber:(int)meetid diverid:(int)diverid;
-(DiverBoardSize*)CallBoardSize:(int)meetid diverid:(int)diverid;
-(NSMutableArray*)CallJudgeScores:(int)meetid diverid:(int)diverid;
-(JudgeScores*)judgeScoreInsert:(NSString*)jId mid:(NSString*)mid did:(NSString*)did board:(NSString*)board number:(NSString*)number cat:(NSString*)cat type:(NSString*)type pos:(NSString*)pos failed:(NSString*)failed multiplier:(NSString*)multiplier total:(NSString*)total score1:(NSString*)score1 score2:(NSString*)score2 score3:(NSString*)score3 score4:(NSString*)score4 score5:(NSString*)score5 score6:(NSString*)score6 score7:(NSString*)score7;
-(Results*)CallResults:(int)meetid diverid:(int)diverid;

// diver info by all meets
//-(DiveList*)CallDiveList:(int)diverid;
//-(DiveTotal*)CallDiveTotal:(int)diverid;
//-(DiveNumber*)CallDiveNumber:(int)diverid;
//-(DiverBoardSize*)CallBoardSize:(int)diverid;
//-(NSMutableArray*)CallJudgeScores:(int)diverid;
//-(Results*)CallResults:(int)diverid;

@end

@implementation DiverCollection

#pragma public methods

// this will get me all the divers by a meet specified and the diver
// child objects
-(NSMutableArray*)GetDiverInfoByMeet:(int)meetid diverid:(int)diverid {
    
    // collection objects
    NSMutableArray *diverCollec = [[NSMutableArray alloc] init];
//    Diver *diver = [[Diver alloc] init];
//    DiveList *list = [[DiveList alloc] init];
//    DiveTotal *total = [[DiveTotal alloc] init];
//    DiveNumber *number = [[DiveNumber alloc] init];
    //DiverBoardSize *board = [[DiverBoardSize alloc] init];
//    Results *results = [[Results alloc] init];
    //JudgeScores *jScores = [[JudgeScores alloc] init];
    NSMutableArray *judgeScores;
    
    //get the diver
    Diver *diver = [self CallDiver:diverid];
    if (diver != nil) {
        [diverCollec addObject:diver];
    }
    
    
    //get a divelist
    DiveList *list = [self CallDiveList:meetid diverid:diverid];
    if (list != nil) {
        [diverCollec addObject:list];
    }
    
    //get diveTotal
    DiveTotal *total = [self CallDiveTotal:meetid diverid:diverid];
    if (total != nil) {
        [diverCollec addObject:total];
    }
    
    //get diveNumber
    DiveNumber *number = [self CallDiveNumber:meetid diverid:diverid];
    if (number != nil) {
        [diverCollec addObject:number];
    }
    
    //getdiveboardsize
    DiverBoardSize *board = [self CallBoardSize:meetid diverid:diverid];
    if (board) {
        [diverCollec addObject:board];
    }
    
    //get results
    Results *results = [self CallResults:meetid diverid:diverid];
    if (results != nil) {
        [diverCollec addObject:results];
    }
    
    //get judge score
    judgeScores = [self CallJudgeScores:meetid diverid:diverid];
    if (judgeScores != nil) {
        [diverCollec addObject:judgeScores];
    }
    
    return diverCollec;
    
}

//TODO: this need to be reworked
// this will give me a diver and all of it's children
// including the meets the diver has been in
//-(NSMutableArray*)GetDiverInfo:(int)diverid {
//    
//    // collection objects
//    NSMutableArray *diverCollec = [[NSMutableArray alloc] init];
//    Diver *diver = [[Diver alloc] init];
////    DiveList *list = [[DiveList alloc] init];
////    DiveTotal *total = [[DiveTotal alloc] init];
////    DiveNumber *number = [[DiveNumber alloc] init];
////    DiverBoardSize *board = [[DiverBoardSize alloc] init];
////    JudgeScores *jScores = [[JudgeScores alloc] init];
////    Results *results = [[Results alloc] init];
//    
//    //get the diver
//    diver = [self CallDiver:diverid];
//    
//    //get a divelist
//    //list = [self CallDiveList:meetid diverid:diverid];
//    
//    //get diveTotal
//    
//    //get diveNumber
//    
//    //getdiveboardsize
//    
//    //get judge score
//    
//    //get results
//    
//    return diverCollec;
//}

#pragma private methods

-(Diver*)CallDiver:(int)diverid {
    
    NSArray *diverInfo;
    Diver *diver = [[Diver alloc] init];
    
    diverInfo = [diver LoadDiver:diverid];
    
    if (diverInfo.count > 0) {
      
        NSString *theDiverid = [[NSString alloc] initWithString:[[diverInfo objectAtIndex:0] objectAtIndex:0]];
        NSString *name = [[NSString alloc] initWithString:[[diverInfo objectAtIndex:0] objectAtIndex:1]];
        NSString *age = [[NSString alloc] initWithString:[[diverInfo objectAtIndex:0] objectAtIndex:2]];
        NSString *grade = [[NSString alloc] initWithString:[[diverInfo objectAtIndex:0] objectAtIndex:3]];
        NSString *school = [[NSString alloc] initWithString:[[diverInfo objectAtIndex:0] objectAtIndex:4]];
        
        diver.diverID = theDiverid;
        //NSLog(@" diverid %@:", theDiverid);
        diver.Name = name;
        //NSLog(@" diverid %@:", name);
        diver.Age = age;
        //NSLog(@" diverid %@:", age);
        diver.Grade = grade;
        //NSLog(@" diverid %@:", grade);
        diver.School = school;
        //NSLog(@" diverid %@:", school);
    
        return diver;
        
    } else {
        
        return diver = nil;
        
    }
}

// diver info by meet
-(DiveList*)CallDiveList:(int)meetid diverid:(int)diverid {
    
    NSArray *divelist;
    DiveList *list = [[DiveList alloc] init];
    
    divelist = [list GetDiveList:meetid diverid:diverid];
    
    if (divelist.count > 0) {
    
        NSString *lId = [[NSString alloc] initWithString:[[divelist objectAtIndex:0] objectAtIndex:0]];
        NSString *mId = [[NSString alloc] initWithString:[[divelist objectAtIndex:0] objectAtIndex:1]];
        NSString *dId = [[NSString alloc] initWithString:[[divelist objectAtIndex:0] objectAtIndex:2]];
        NSString *listFilled = [[NSString alloc] initWithString:[[divelist objectAtIndex:0] objectAtIndex:3]];
        NSString *noList = [[NSString alloc] initWithString:[[divelist objectAtIndex:0] objectAtIndex:4]];
        
        list.listId = lId;
        //NSLog(@" listid %@", lId);
        list.meetId = mId;
        //NSLog(@" list meetid=d %@", mId);
        list.diverId = dId;
        //NSLog(@" list diveridf=d %@", dId);
        list.listFilled = [NSNumber numberWithInteger:[listFilled integerValue]];
        //NSLog(@" list filled=d %@", listFilled);
        list.noList = [NSNumber numberWithInteger:[noList integerValue]];
        //NSLog(@" list nolist=d %@", noList);
        
        return list;
        
    } else {
        return list = nil;
    }
    
}

-(DiveTotal*)CallDiveTotal:(int)meetid diverid:(int)diverid {
    
    NSArray *diveTotal;
    DiveTotal *total = [[DiveTotal alloc] init];
    
    diveTotal = [total GetDiveTotalObject:meetid DiverID:diverid];
    
    if (diveTotal.count > 0) {
    
        NSString *tId = [[NSString alloc] initWithString:[[diveTotal objectAtIndex:0] objectAtIndex:0]];
        NSString *mId = [[NSString alloc] initWithString:[[diveTotal objectAtIndex:0] objectAtIndex:1]];
        NSString *dId = [[NSString alloc] initWithString:[[diveTotal objectAtIndex:0] objectAtIndex:2]];
        NSString *diveCount = [[NSString alloc] initWithString:[[diveTotal objectAtIndex:0] objectAtIndex:3]];
        
        total.totalId = tId;
        //NSLog(@" totalid %@", tId);
        total.meetId = mId;
        //NSLog(@" total meetid=d %@", mId);
        total.diverId = dId;
        //NSLog(@" total diveridf=d %@", dId);
        total.diveTotal = [NSNumber numberWithInteger:[diveCount integerValue]];
        //NSLog(@" dive total=d %@", diveCount);
       
        return total;
        
    } else {
        return total = nil;
    }
    
}

-(DiveNumber*)CallDiveNumber:(int)meetid diverid:(int)diverid {
    
    NSArray *diveNumber;
    DiveNumber *number = [[DiveNumber alloc] init];
    
    diveNumber = [number GetDiveNumber:meetid diverid:diverid];
    
    if (diveNumber.count > 0) {
    
        NSString *nId = [[NSString alloc] initWithString:[[diveNumber objectAtIndex:0] objectAtIndex:0]];
        NSString *mId = [[NSString alloc] initWithString:[[diveNumber objectAtIndex:0] objectAtIndex:1]];
        NSString *dId = [[NSString alloc] initWithString:[[diveNumber objectAtIndex:0] objectAtIndex:2]];
        NSString *diveNumer = [[NSString alloc] initWithString:[[diveNumber objectAtIndex:0] objectAtIndex:3]];
        
        number.numberId = nId;
        //NSLog(@" totalid %@", nId);
        number.meetId = mId;
        //NSLog(@" total meetid=d %@", mId);
        number.diverId = dId;
        //NSLog(@" total diveridf=d %@", dId);
        number.number = [NSNumber numberWithInteger:[diveNumer integerValue]];
        //NSLog(@" dive number=d %@", diveNumber);
        
        return number;
        
    } else {
        return number = nil;
    }
    
}

-(DiverBoardSize*)CallBoardSize:(int)meetid diverid:(int)diverid {
    
    NSArray *board;
    DiverBoardSize *size = [[DiverBoardSize alloc] init];
    
    board = [size GetBoardSizeObject:meetid diverid:diverid];
    
    if (board.count > 0) {
    
        NSString *bId = [[NSString alloc] initWithString:[[board objectAtIndex:0] objectAtIndex:0]];
        NSString *mId = [[NSString alloc] initWithString:[[board objectAtIndex:0] objectAtIndex:1]];
        NSString *dId = [[NSString alloc] initWithString:[[board objectAtIndex:0] objectAtIndex:2]];
        NSString *boardOne = [[NSString alloc] initWithString:[[board objectAtIndex:0] objectAtIndex:3]];
        NSString *boardTwo = [[NSString alloc] initWithString:[[board objectAtIndex:0] objectAtIndex:4]];
        NSString *boardThree = [[NSString alloc] initWithString:[[board objectAtIndex:0] objectAtIndex:5]];
        
        
        size.boardId = bId;
        //NSLog(@" totalid %@", bId);
        size.meetId = mId;
        //NSLog(@" total meetid=d %@", mId);
        size.diverId = dId;
        //NSLog(@" total diveridf=d %@", dId);
        size.firstSize = [NSNumber numberWithDouble:[boardOne doubleValue]];
        //NSLog(@" dive number=d %@", boardOne);
        size.secondSize = [NSNumber numberWithDouble:[boardTwo doubleValue]];
        //NSLog(@" dive number=d %@", boardTwo);
        size.thirdSize = [NSNumber numberWithDouble:[boardThree doubleValue]];
        //NSLog(@" dive number=d %@", boardThree);
        
        return size;
        
    } else {
        return size = nil;
    }
    
}

-(NSMutableArray*)CallJudgeScores:(int)meetid diverid:(int)diverid {
    
    NSArray *judgeScores;
    NSMutableArray *jScores;
    JudgeScores *judge = [[JudgeScores alloc] init];
    
    judgeScores = [judge FetchJudgeScoreObject:meetid diverid:diverid];
    
    if (judgeScores.count > 0) {
  
        jScores = [[NSMutableArray alloc] init];
        
        int count1 = (int)judgeScores.count;
        
        for (int index = 0; index < count1; index++) {
                
            NSString *jId = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:0]];
            NSString *mId = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:1]];
            NSString *dId = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:2]];
            NSString *boardSize = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:3]];
            NSString *diveNumber = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:4]];
            NSString *diveCat = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:5]];
            NSString *diveType = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:6]];
            NSString *divePosition = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:7]];
            NSString *failed = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:8]];
            NSString *multiplier = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:9]];
            NSString *totalScore = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:10]];
            NSString *score1 = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:11]];
            NSString *score2 = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:12]];
            NSString *score3 = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:13]];
            NSString *score4 = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:14]];
            NSString *score5 = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:15]];
            NSString *score6 = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:16]];
            NSString *score7 = [[NSString alloc] initWithString:[[judgeScores objectAtIndex:index] objectAtIndex:17]];
            
//            JudgeScores *update = [[JudgeScores alloc] init];
            
            JudgeScores *update = [self judgeScoreInsert:jId mid:mId did:dId board:boardSize number:diveNumber cat:diveCat type:diveType pos:divePosition failed:failed multiplier:multiplier total:totalScore score1:score1 score2:score2 score3:score3 score4:score4 score5:score5 score6:score6 score7:score7];
    
            [jScores insertObject:update atIndex:index];
            
        }
        
        return jScores;
        
    } else {
        return jScores = nil;
    }
}

-(JudgeScores*)judgeScoreInsert:(NSString*)jId mid:(NSString*)mid did:(NSString*)did board:(NSString*)board number:(NSString*)number cat:(NSString*)cat type:(NSString*)type pos:(NSString*)pos failed:(NSString*)failed multiplier:(NSString*)multiplier total:(NSString*)total score1:(NSString*)score1 score2:(NSString*)score2 score3:(NSString*)score3 score4:(NSString*)score4 score5:(NSString*)score5 score6:(NSString*)score6 score7:(NSString*)score7 {
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    scores.judgeScoreID = jId;
    scores.meetid = mid;
    scores.diverid = did;
    scores.boardSize = [NSNumber numberWithDouble:[board doubleValue]];
    scores.diveNumber = [NSNumber numberWithInteger:[number integerValue]];
    scores.diveCategory = cat;
    scores.diveType = type;
    scores.divePosition = pos;
    scores.failed = failed;
    scores.multiplier = [NSNumber numberWithDouble:[multiplier doubleValue]];
    scores.totalScore = [NSNumber numberWithDouble:[total doubleValue]];
    scores.score1 = [NSNumber numberWithDouble:[score1 doubleValue]];
    scores.score2 = [NSNumber numberWithDouble:[score2 doubleValue]];
    scores.score3 = [NSNumber numberWithDouble:[score3 doubleValue]];
    scores.score4 = [NSNumber numberWithDouble:[score4 doubleValue]];
    scores.score5 = [NSNumber numberWithDouble:[score5 doubleValue]];
    scores.score6 = [NSNumber numberWithDouble:[score6 doubleValue]];
    scores.score7 = [NSNumber numberWithDouble:[score7 doubleValue]];
    
    return scores;
}

-(Results*)CallResults:(int)meetid diverid:(int)diverid {
    
    NSArray *results;
    Results *r = [[Results alloc] init];
    
    results = [r GetResultObject:meetid DiverId:diverid];
    
    if (results.count > 0) {
     
        NSString *rId = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:0]];
        NSString *mId = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:1]];
        NSString *dId = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:2]];
        NSString *dive1 = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:3]];
        NSString *dive2 = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:4]];
        NSString *dive3 = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:5]];
        NSString *dive4 = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:6]];
        NSString *dive5 = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:7]];
        NSString *dive6 = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:8]];
        NSString *dive7 = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:9]];
        NSString *dive8 = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:10]];
        NSString *dive9 = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:11]];
        NSString *dive10 = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:12]];
        NSString *dive11 = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:13]];
        NSString *total = [[NSString alloc] initWithString:[[results objectAtIndex:0] objectAtIndex:14]];
        
        
        r.resultId = rId;
        //NSLog(@" resultid %@", rId);
        r.meetId = mId;
        //NSLog(@" result meetid=d %@", mId);
        r.diverId = dId;
        //NSLog(@" result diveridf=d %@", dId);
        r.dive1 = [NSNumber numberWithDouble:[dive1 doubleValue]];
        //NSLog(@" dive1=d %@", dive1);
        r.dive2 = [NSNumber numberWithDouble:[dive2 doubleValue]];
        //NSLog(@" dive2=d %@", dive2);
        r.dive3 = [NSNumber numberWithDouble:[dive3 doubleValue]];
        //NSLog(@" dive3=d %@", dive3);
        r.dive4 = [NSNumber numberWithDouble:[dive4 doubleValue]];
        //NSLog(@" dive4=d %@", dive4);
        r.dive5 = [NSNumber numberWithDouble:[dive5 doubleValue]];
        //NSLog(@" dive5=d %@", dive5);
        r.dive6 = [NSNumber numberWithDouble:[dive6 doubleValue]];
        //NSLog(@" dive6=d %@", dive6);
        r.dive7 = [NSNumber numberWithDouble:[dive7 doubleValue]];
        //NSLog(@" dive7=d %@", dive7);
        r.dive8 = [NSNumber numberWithDouble:[dive8 doubleValue]];
        //NSLog(@" dive8=d %@", dive8);
        r.dive9 = [NSNumber numberWithDouble:[dive9 doubleValue]];
        //NSLog(@" dive9=d %@", dive9);
        r.dive10 = [NSNumber numberWithDouble:[dive10 doubleValue]];
        //NSLog(@" dive10=d %@", dive10);
        r.dive11 = [NSNumber numberWithDouble:[dive11 doubleValue]];
        //NSLog(@" dive11=d %@", dive11);
        r.totalScoreTotal = [NSNumber numberWithDouble:[total doubleValue]];
        //NSLog(@" result total=d %@", total);
        
        return r;
        
    } else {
        return r = nil;
    }
    
}

// diver info by all meets;
//-(DiveList*)CallDiveList:(int)diverid {
//    
//    DiveList *list = [[DiveList alloc] init];
//    
//    return list;
//    
//}
//
//-(DiveTotal*)CallDiveTotal:(int)diverid {
//    
//    DiveTotal *total = [[DiveTotal alloc] init];
//    
//    return total;
//    
//}
//
//-(DiveNumber*)CallDiveNumber:(int)diverid {
//    
//    DiveNumber *number = [[DiveNumber alloc] init];
//    
//    return number;
//    
//}
//
//-(DiverBoardSize*)CallBoardSize:(int)diverid {
//    
//    DiverBoardSize *size = [[DiverBoardSize alloc] init];
//    
//    return size;
//    
//}
//
//-(NSMutableArray*)CallJudgeScores:(int)diverid {
//    
//    NSMutableArray *jScores;
//    
//    return jScores;
//    
//}
//
//-(Results*)CallResults:(int)diverid {
//    
//    Results *r = [[Results alloc] init];
//    
//    return r;
//    
//}

@end
