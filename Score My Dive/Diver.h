//
//  Diver.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Diver : NSObject

@property (nonatomic, copy) NSString *diverID;
@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *Age;
@property (nonatomic, copy) NSString *Grade;
@property (nonatomic, copy) NSString *School;

-(BOOL)UpdateDiver:(int)diverid Name:(NSString*)name Age:(NSString*)age Grade:(NSString*)grade School:(NSString*)school;

-(NSArray*)DiversAtMeet:(int)meetid;

-(NSArray*)GetAllDivers;

-(NSArray*)LoadDiver:(int)diverid;

-(void)DeleteDiver:(int)diverid;

-(void)RemoveDiverFromMeet:(int)meetid diverid:(int)diverid;

-(NSArray*)RankingsByDiverAtMeet:(int)meetid boardSize:(NSNumber*)boardsize;

-(BOOL)CheckDiverForRankings:(int)meetid boardsize:(NSNumber*)boardsize;

@end
