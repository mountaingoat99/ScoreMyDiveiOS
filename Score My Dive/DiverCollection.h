//
//  DiverCollection.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/6/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Diver;

@interface DiverCollection : NSObject

-(NSMutableArray*)GetDiverInfoByMeet:(int)meetid diverid:(int)diverid;

-(NSMutableArray*)GetDiverInfo:(int)diverid;

@end
