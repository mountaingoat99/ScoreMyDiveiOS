//
//  MeetCollection.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/5/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "MeetCollection.h"
#import "Meet.h"
#import "Judges.h"
#import "DiverCollection.h"

@interface MeetCollection ()

-(Meet*)CallMeet:(int)meetid;
-(Judges*)CallJudges:(int)meetid;
-(NSArray*)CallDivers:(int)meetid diverid:(int)diverid;

@end

@implementation MeetCollection

#pragma public methods

// this public method will make calls to methods in the child objects of a meet
// this returns all the divers on a selected meet
-(NSArray*)GetMeetAndDiverInfo:(int)meetId diverid:(int)diverid {
    
    // collection objects, meet collection is the array that will hold the objects
    NSArray *meetCollec;
//    Meet *meet = [[Meet alloc] init];
//    Judges *judges = [[Judges alloc] init];
    NSArray *diverCollection;
    
    // get the meet
    Meet *meet = [self CallMeet:meetId];
    
    // get the judges
    Judges *judges = [self CallJudges:meetId];
    
    //get the diversCollection
    diverCollection = [self CallDivers:meetId diverid:diverid];
    
    meetCollec = [[NSArray alloc] initWithObjects:meet, judges, diverCollection, nil];
    
    return meetCollec;
    
}

// this will give me the meet and it's one child object, the judges
-(NSArray*)GetMeetInfo:(int)meetid  {
    
    // collection objects, meet collection is the array that will hold the objects
    NSArray *meetCollec;
//    Meet *meet = [[Meet alloc] init];
//    Judges *judges = [[Judges alloc] init];
    
    // get the meet
    Meet *meet = [self CallMeet:meetid];
    
    // get the judges
    Judges *judges = [self CallJudges:meetid];
    
    meetCollec = [[NSArray alloc] initWithObjects:meet, judges, nil];
    
    return meetCollec;
}

#pragma private methods

-(Meet*)CallMeet:(int)meetid {
    
    NSArray *meetInfo;
    Meet *meetCall = [[Meet alloc] init];
    
    meetInfo = [meetCall GetTheMeet:meetid];
    
    if (meetInfo.count > 0) {
    
        NSString *theMeetid = [[NSString alloc] initWithString:[[meetInfo objectAtIndex:0] objectAtIndex:0]];
        NSString *meetName = [[NSString alloc] initWithString:[[meetInfo objectAtIndex:0] objectAtIndex:1]];
        NSString *schoolName = [[NSString alloc] initWithString:[[meetInfo objectAtIndex:0] objectAtIndex:2]];
        NSString *city = [[NSString alloc] initWithString:[[meetInfo objectAtIndex:0] objectAtIndex:3]];
        NSString *state = [[NSString alloc] initWithString:[[meetInfo objectAtIndex:0] objectAtIndex:4]];
        NSString *date = [[NSString alloc] initWithString:[[meetInfo objectAtIndex:0] objectAtIndex:5]];
        
        meetCall.meetID = theMeetid;
        meetCall.meetName = meetName;
        meetCall.schoolName = schoolName;
        meetCall.city = city;
        meetCall.state = state;
        meetCall.date = date;
        
        return meetCall;
    
    } else {
        return meetCall = nil;
    }
    
}

-(Judges*)CallJudges:(int)meetid {
    
    NSNumber *judgeTotal;
    Judges *judges = [[Judges alloc] init];
    
    judgeTotal = [judges getJudges:meetid];
    
    judges.judgeTotal = judgeTotal;
    
    return judges;
}

-(NSArray*)CallDivers:(int)meetid diverid:(int)diverid {
    
    NSArray *diverCollection;
    DiverCollection *divers = [[DiverCollection alloc] init];
    
    diverCollection = [[NSArray alloc] initWithObjects:[divers GetDiverInfoByMeet:meetid diverid:diverid], nil];
    
    return diverCollection;
    
}


@end

