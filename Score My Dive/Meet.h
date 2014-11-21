//
//  Meet.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meet : NSObject

@property (nonatomic, strong) NSString *MeetName;
@property (nonatomic, strong) NSString *SchoolName;
@property (nonatomic, strong) NSString *City;
@property (nonatomic, strong) NSString *State;
@property (nonatomic, strong) NSString *Date;

-(BOOL)UpdateMeet:(int)meetid Name:(NSString*)name School:(NSString*)school City:(NSString*)city State:(NSString*)state Date:(NSString*)date;

-(NSArray*)GetAllMeets;

-(NSArray*)LoadMeet:(int)meetid;

-(void)DeleteMeet:(int)meetid;

@end
