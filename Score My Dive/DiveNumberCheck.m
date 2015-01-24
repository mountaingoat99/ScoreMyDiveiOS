//
//  DiveNumberCheck.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 1/18/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import "DiveNumberCheck.h"
#import "DiveTypes.h"
#import "AllSpringboardDives.h"
#import "AllPlatformDives.h"

@interface DiveNumberCheck ()

-(NSArray*)GetDiveSpringboardInfo:(NSArray*)divetypes Position:(NSString*)position BoardSize:(NSNumber*)boardsize;
-(NSArray*)GetDivePlatformInfo:(NSArray*)divetypes Position:(NSString*)position BoardSize:(NSNumber*)boardsize;

@end

@implementation DiveNumberCheck

#pragma Public Methods

// this will get all the diveinfo for what ever divenumber and position is sent in a returns just the id Name, and DD
-(NSArray*)CheckDiveNumberInput:(NSString*)diveString Position:(NSString*)position BoardSize:(NSNumber*)boardsize {
    
    NSArray *diveTypes = [[NSArray alloc] init];
    NSArray *reloadDiveTypes = [[NSArray alloc] init];
    
    int diveNumber = [diveString intValue];
    
    if ([boardsize isEqualToNumber:@1] || [boardsize isEqualToNumber:@3]) {
    
        AllSpringboardDives *types = [[AllSpringboardDives alloc] init];
        diveTypes = [types GetSpringboardCategories:diveNumber];
        if (diveTypes.count > 0) {
            reloadDiveTypes = [self GetDiveSpringboardInfo:diveTypes Position:position BoardSize:boardsize];
        } else {
            return diveTypes;
        }
        
    } else {
        
        AllPlatformDives *types = [[AllPlatformDives alloc] init];
        diveTypes = [types GetPlatformCategories:diveNumber];
        if (diveTypes.count > 0) {
            reloadDiveTypes = [self GetDivePlatformInfo:diveTypes Position:position BoardSize:boardsize];
        } else {
            return diveTypes;
        }
    }
    
    return reloadDiveTypes;
}

#pragma private methods

// these two methods get the dive id, name, and DD based on board and position
-(NSArray*)GetDiveSpringboardInfo:(NSArray*)divetypes Position:(NSString*)position BoardSize:(NSNumber*)boardsize {
    
    NSArray *diveInfo;
    
    NSString *diveId = [[divetypes objectAtIndex:0] objectAtIndex:0];
    NSString *diveName = [[divetypes objectAtIndex:0] objectAtIndex:3];
    NSString *diveDD;
    
    if ([boardsize isEqualToNumber:@1]) {
        if ([position isEqualToString:@"a"] || [position isEqualToString:@"A"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:4];
        } else if ([position isEqualToString:@"b"] || [position isEqualToString:@"B"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:5];
        } else if ([position isEqualToString:@"c"] || [position isEqualToString:@"C"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:6];
        } else if ([position isEqualToString:@"d"] || [position isEqualToString:@"D"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:7];
        }
    } else {
        if ([position isEqualToString:@"a"] || [position isEqualToString:@"A"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:8];
        } else if ([position isEqualToString:@"b"] || [position isEqualToString:@"B"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:9];
        } else if ([position isEqualToString:@"c"] || [position isEqualToString:@"C"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:10];
        } else if ([position isEqualToString:@"d"] || [position isEqualToString:@"D"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:11];
        }
    }
    
    return diveInfo = [[NSArray alloc] initWithObjects:diveId, diveName, diveDD, nil];

}

-(NSArray*)GetDivePlatformInfo:(NSArray*)divetypes Position:(NSString*)position BoardSize:(NSNumber*)boardsize {
    
    NSArray *diveInfo;
    
    NSString *diveId = [[divetypes objectAtIndex:0] objectAtIndex:0];
    NSString *diveName = [[divetypes objectAtIndex:0] objectAtIndex:4];
    NSString *diveDD;
    
    if ([boardsize isEqualToNumber:@10]) {
        if ([position isEqualToString:@"a"] || [position isEqualToString:@"A"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:5];
        } else if ([position isEqualToString:@"b"] || [position isEqualToString:@"B"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:6];
        } else if ([position isEqualToString:@"c"] || [position isEqualToString:@"C"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:7];
        } else if ([position isEqualToString:@"d"] || [position isEqualToString:@"D"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:8];
        }
    } else if ([boardsize isEqualToNumber:@7.5]) {
        if ([position isEqualToString:@"a"] || [position isEqualToString:@"A"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:9];
        } else if ([position isEqualToString:@"b"] || [position isEqualToString:@"B"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:10];
        } else if ([position isEqualToString:@"c"] || [position isEqualToString:@"C"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:11];
        } else if ([position isEqualToString:@"d"] || [position isEqualToString:@"D"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:12];
        }
    } else {
        if ([position isEqualToString:@"a"] || [position isEqualToString:@"A"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:13];
        } else if ([position isEqualToString:@"b"] || [position isEqualToString:@"B"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:14];
        } else if ([position isEqualToString:@"c"] || [position isEqualToString:@"C"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:15];
        } else if ([position isEqualToString:@"d"] || [position isEqualToString:@"D"]) {
            diveDD = [[divetypes objectAtIndex:0] objectAtIndex:16];
        }
    }
    
    return diveInfo = [[NSArray alloc] initWithObjects:diveId, diveName, diveDD, nil];
    
}

@end
