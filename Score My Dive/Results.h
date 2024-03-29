//
//  Results.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//  Test

#import <Foundation/Foundation.h>

@interface Results : NSObject <NSCoding>

@property (nonatomic, copy) NSString *resultId;
@property (nonatomic, copy) NSString *meetId;
@property (nonatomic, copy) NSString *diverId;
@property (nonatomic, copy) NSNumber *dive1;
@property (nonatomic, copy) NSNumber *dive2;
@property (nonatomic, copy) NSNumber *dive3;
@property (nonatomic, copy) NSNumber *dive4;
@property (nonatomic, copy) NSNumber *dive5;
@property (nonatomic, copy) NSNumber *dive6;
@property (nonatomic, copy) NSNumber *dive7;
@property (nonatomic, copy) NSNumber *dive8;
@property (nonatomic, copy) NSNumber *dive9;
@property (nonatomic, copy) NSNumber *dive10;
@property (nonatomic, copy) NSNumber *dive11;
@property (nonatomic, copy) NSNumber *totalScoreTotal;

-(BOOL)CreateResult:(int)meetid DiverID:(int)diverid Dive1:(NSNumber*)dive1 Dive2:(NSNumber*)dive2 Dive3:(NSNumber*)dive3 Dive4:(NSNumber*)dive4 Dive5:(NSNumber*)dive5 Dive6:(NSNumber*)dive6 Dive7:(NSNumber*)dive7 Dive8:(NSNumber*)dive8 Dive9:(NSNumber*)dive9 Dive10:(NSNumber*)dive10 Dive11:(NSNumber*)dive11 DiveScoreTotal:(NSNumber*)divescoretotal;

-(BOOL)UpdateOneResult:(int)meetid DiverID:(int)diverid DiveNumber:(int)divenumber score:(NSNumber*)score;

-(BOOL)UpdateTotal:(int)meetid DiverID:(int)diverid Total:(NSNumber*)total;

-(NSArray*)GetResults:(int)meetid DiverId:(int)diverid;

-(NSArray*)GetScores:(int)meetid DiverId:(int)diverid;

-(NSArray*)GetResultObject:(int)meetid DiverId:(int)diverid;

-(NSNumber*)GetResultTotal:(int)meetid DiverID:(int)diverid;

-(NSString*)CheckResults:(int)meetid DiverID:(int)diverid;

-(BOOL)ResultsExist:(int)meetid;

@end
