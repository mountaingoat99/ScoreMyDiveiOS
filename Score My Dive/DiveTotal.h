//
//  DiveTotal.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiveTotal : NSObject

@property (nonatomic, copy) NSNumber *diveTotal;

-(BOOL)CreateDiveTotal:(int)meetid DiverID:(int)diverid Total:(int)total;

-(NSNumber*)GetDiveTotal:(int)meetid DiverID:(int)diverid;

@end
