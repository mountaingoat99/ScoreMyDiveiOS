//
//  Diver.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Diver : NSObject

@property (nonatomic, strong) NSString *Name;
@property (nonatomic, strong) NSString *Age;
@property (nonatomic, strong) NSString *Grade;
@property (nonatomic, strong) NSString *School;

-(BOOL)UpdateDiver:(int)diverid Name:(NSString*)name Age:(NSString*)age Grade:(NSString*)grade School:(NSString*)school;

-(NSArray*)GetAllDivers;

-(NSArray*)LoadDiver:(int)diverid;

-(void)DeleteDiver:(int)diverid;

@end
