//
//  MeetCollection.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/26/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "MeetCollection.h"
#import "Meet.h"
#import "Judges.h"
#import "DiverCollection.h"

@implementation MeetCollection

-(NSArray*)GetMeetCollection:(int)meetid {
    
    // init the judges and Diver collection Objects
    Meet *meet = [[Meet alloc] init];
    Judges *judges = [[Judges alloc] init];
    DiverCollection *divers = [[DiverCollection alloc] init];
    
    // method to get the meet
    NSArray *meetInfo = [[NSArray alloc] initWithArray:[meet GetTheMeet:meetid]];
    
    // method to get the judges and add them to the array
    //NSString judgeTotals = [judges ]
    
    // method to get the divers and add them to the array
    
    
    // init the array with the objects in them
    self.collectionOfMeetObjects = [NSArray arrayWithObjects:meetInfo, judges, divers, nil];
    
    return self.collectionOfMeetObjects;
}

@end

