//
//  Meet.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meet : NSObject

@property (nonatomic, copy) NSString *meetID;
@property (nonatomic, copy) NSString *meetName;
@property (nonatomic, copy) NSString *schoolName;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *date;

-(int)UpdateMeet:(int)mMeetId Name:(NSString*)mName School:(NSString*)mSchool City:(NSString*)mCity State:(NSString*)mState Date:(NSString*)mDate;

-(NSArray*)GetAllMeets;

-(NSArray*)LoadMeet:(int)meetid;

-(void)DeleteMeet:(int)meetid;

-(NSString*)GetMeetName:(int)meetid;

-(NSArray*)GetTheMeet:(int)meetid;

-(NSArray*)GetMeetHistory:(int)diverid;

@end
