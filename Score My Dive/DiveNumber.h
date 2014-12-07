//
//  DiveNumber.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiveNumber : NSObject

@property (nonatomic, copy) NSNumber *number;
@property (nonatomic, copy) NSNumber *boardSize;

-(BOOL)CreateDiveNumber:(int)meetid diverid:(int)diverid number:(NSNumber*)number boardsize:(NSNumber*)boardsize;

-(NSNumber*)WhatDiveNumber:(int)meetid diverid:(int)diverid;

-(void)UpdateDiveNumber:(int)meetid diverid:(int)diverid divenumber:(NSNumber*)divenumber;

@end
