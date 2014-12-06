//
//  Results.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Results : NSObject

@property (nonatomic) NSNumber *dive1;
@property (nonatomic) NSNumber *dive2;
@property (nonatomic) NSNumber *dive3;
@property (nonatomic) NSNumber *dive4;
@property (nonatomic) NSNumber *dive5;
@property (nonatomic) NSNumber *dive6;
@property (nonatomic) NSNumber *dive7;
@property (nonatomic) NSNumber *dive8;
@property (nonatomic) NSNumber *dive9;
@property (nonatomic) NSNumber *dive10;
@property (nonatomic) NSNumber *dive11;
@property (nonatomic) NSNumber *totalScoreTotal;

-(BOOL)CreateResult:(int)meetid DiverID:(int)diverid Dive1:(NSNumber*)dive1 Dive2:(NSNumber*)dive2 Dive3:(NSNumber*)dive3 Dive4:(NSNumber*)dive4 Dive5:(NSNumber*)dive5 Dive6:(NSNumber*)dive6 Dive7:(NSNumber*)dive7 Dive8:(NSNumber*)dive8 Dive9:(NSNumber*)dive9 Dive10:(NSNumber*)dive10 Dive11:(NSNumber*)dive11 DiveScoreTotal:(NSNumber*)divescoretotal;

-(NSArray*)GetResults:(int)meetid DiverId:(int)diverid;

-(NSNumber*)GetResultTotal:(int)meetid DiverID:(int)diverid;

-(NSString*)CheckResults:(int)meetid DiverID:(int)diverid;

@end
