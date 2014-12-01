//
//  Meet.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meet : NSObject

@property (nonatomic, retain) NSString *meetID;
@property (nonatomic, retain) NSString *meetName;
@property (nonatomic, retain) NSString *schoolName;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *date;

-(BOOL)UpdateMeet:(int)mMeetId Name:(NSString*)mName School:(NSString*)mSchool City:(NSString*)mCity State:(NSString*)mState Date:(NSString*)mDate;

-(NSArray*)GetAllMeets;

-(NSArray*)LoadMeet:(int)meetid;

-(void)DeleteMeet:(int)meetid;

-(NSString*)GetMeetName:(int)meetid;

-(NSArray*)GetTheMeet:(int)meetid;

-(NSArray*)GetMeetHistory:(int)diverid;

@end
