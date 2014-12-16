//
//  DiveTypes.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiveTypes : NSObject

// springboard
-(NSArray*)GetForwardOneSpringboard;
-(NSArray*)GetForwardThreeSpringboard;
-(NSArray*)GetBackOneSpringboard;
-(NSArray*)GetBackThreeSpringboard;
-(NSArray*)GetInwardOneSpringboard;
-(NSArray*)GetInwardThreeSpringboard;
-(NSArray*)GetReverseOneSpringboard;
-(NSArray*)GetReverseThreeSpringboard;
-(NSArray*)GetTwistOneSpringboard;
-(NSArray*)GetTwistThreeSpringboard;

// platform
-(NSArray*)GetForwardFivePlatform;
-(NSArray*)GetForwardSevenFivePlatform;
-(NSArray*)GetForwardTenPlatform;
-(NSArray*)GetBackFivePlatform;
-(NSArray*)GetBackSevenFivePlatform;
-(NSArray*)GetBackTenPlatform;
-(NSArray*)GetInwardFivePlatform;
-(NSArray*)GetInwardSevenFivePlatform;
-(NSArray*)GetInwardTenPlatform;
-(NSArray*)GetReverseFivePlatform;
-(NSArray*)GetReverseSevenFivePlatform;
-(NSArray*)GetReverseTenPlatform;
-(NSArray*)GetTwistFivePlatform;
-(NSArray*)GetTwistSevenFivePlatform;
-(NSArray*)GetTwistTenPlatform;
-(NSArray*)GetArmstandFivePlatform;
-(NSArray*)GetArmstandSevenFivePlatform;
-(NSArray*)GetArmstandTenPlatform;

// gets the dive array based on category and boardsize
-(NSArray*)LoadDivePicker:(int)divecat BoardSize:(NSNumber*)boardsize;

// gets the id from the dive by dive name
-(NSNumber*)GetDiveID:(NSString*)diveName DivePosition:(NSNumber*)diveposition BoardType:(NSNumber*)boardtype;

// gets the all the dive dods
-(NSArray*)GetAllDiveDODs:(int)divecat DiveTypeId:(int)divetypeid BoardType:(NSNumber*)boardsize;

@end
