//
//  MeetCollection.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/5/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Meet;

@interface MeetCollection : NSObject

-(NSArray*)GetMeetAndDiverInfo:(int)meetId;

-(NSArray*)GetMeetInfo:(int)meetid;

@end
