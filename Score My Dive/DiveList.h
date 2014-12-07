//
//  DiveList.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DiveList : NSObject

@property (nonatomic, copy) NSNumber *listFilled;
@property (nonatomic, copy) NSNumber *noList;

-(BOOL)UpdateDiveList:(int)meetid diverid:(int)diverid listfilled:(NSNumber*)listfilled noList:(NSNumber*)nolist;

-(NSArray*)GetDiveList:(int)meetid diverid:(int)diverid;

-(BOOL)CheckForNoList:(int)meetid diverid:(int)diverid;

-(void)MarkNoList:(int)meetid diverid:(int)diverid;

-(void)UpdateListFilled:(int)meetid diverid:(int)diverid key:(NSNumber*)key;

-(NSNumber*)IsListFinished:(int)meetid diverid:(int)diverid;

@end
