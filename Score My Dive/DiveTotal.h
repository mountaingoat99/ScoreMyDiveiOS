//
//  DiveTotal.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiveTotal : NSObject <NSCoding>

@property (nonatomic, copy) NSString *totalId;
@property (nonatomic, copy) NSString *meetId;
@property (nonatomic, copy) NSString *diverId;
@property (nonatomic, copy) NSNumber *diveTotal;

-(BOOL)CreateDiveTotal:(int)meetid DiverID:(int)diverid Total:(int)total;

-(NSNumber*)GetDiveTotal:(int)meetid DiverID:(int)diverid;

-(NSArray*)GetDiveTotalObject:(int)meetid DiverID:(int)diverid;

@end
