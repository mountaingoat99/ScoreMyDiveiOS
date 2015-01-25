//
//  DiveTypes.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveTypes.h"
#import "DBManager.h"

@interface DiveTypes ()

@property (nonatomic, strong) DBManager *dbManager;

// springboard
-(NSArray*)GetForwardOneSpringboardById:(int)diveId;
-(NSArray*)GetForwardThreeSpringboardById:(int)diveId;
-(NSArray*)GetBackOneSpringboardById:(int)diveId;
-(NSArray*)GetBackThreeSpringboardById:(int)diveId;
-(NSArray*)GetInwardOneSpringboardById:(int)diveId;
-(NSArray*)GetInwardThreeSpringboardById:(int)diveId;
-(NSArray*)GetReverseOneSpringboardById:(int)diveId;
-(NSArray*)GetReverseThreeSpringboardById:(int)diveId;
-(NSArray*)GetTwistOneSpringboardById:(int)diveId;
-(NSArray*)GetTwistThreeSpringboardById:(int)diveId;

// platform
-(NSArray*)GetForwardFivePlatformById:(int)diveId;
-(NSArray*)GetForwardSevenFivePlatformById:(int)diveId;
-(NSArray*)GetForwardTenPlatformById:(int)diveId;
-(NSArray*)GetBackFivePlatformById:(int)diveId;
-(NSArray*)GetBackSevenFivePlatformById:(int)diveId;
-(NSArray*)GetBackTenPlatformById:(int)diveId;
-(NSArray*)GetInwardFivePlatformById:(int)diveId;
-(NSArray*)GetInwardSevenFivePlatformById:(int)diveId;
-(NSArray*)GetInwardTenPlatformById:(int)diveId;
-(NSArray*)GetReverseFivePlatformById:(int)diveId;
-(NSArray*)GetReverseSevenFivePlatformById:(int)diveId;
-(NSArray*)GetReverseTenPlatformById:(int)diveId;
-(NSArray*)GetTwistFivePlatformById:(int)diveId;
-(NSArray*)GetTwistSevenFivePlatformById:(int)diveId;
-(NSArray*)GetTwistTenPlatformById:(int)diveId;
-(NSArray*)GetArmstandFivePlatformById:(int)diveId;
-(NSArray*)GetArmstandSevenFivePlatformById:(int)diveId;
-(NSArray*)GetArmstandTenPlatformById:(int)diveId;

@end

@implementation DiveTypes

// springboard
-(NSArray*)GetForwardOneSpringboard {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_forward where one_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetForwardThreeSpringboard {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_forward where three_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetBackOneSpringboard {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_back where one_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetBackThreeSpringboard {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_back where three_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetInwardOneSpringboard {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_inward where one_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetInwardThreeSpringboard {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_inward where three_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetReverseOneSpringboard {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_reverse where one_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetReverseThreeSpringboard {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_reverse where three_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetTwistOneSpringboard {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_twist where one_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetTwistThreeSpringboard {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_twist where three_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

// platform
-(NSArray*)GetForwardFivePlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_front where five_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetForwardSevenFivePlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_front where seven_five_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetForwardTenPlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_front where ten_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetBackFivePlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_back where five_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetBackSevenFivePlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_back where seven_five_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetBackTenPlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_back where ten_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetInwardFivePlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_inward where five_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetInwardSevenFivePlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_inward where seven_five_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetInwardTenPlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_inward where ten_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetReverseFivePlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_reverse where five_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetReverseSevenFivePlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_reverse where seven_five_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetReverseTenPlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_reverse where ten_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetTwistFivePlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_twist where five_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetTwistSevenFivePlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_twist where seven_five_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetTwistTenPlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_twist where ten_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetArmstandFivePlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_armstand where five_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetArmstandSevenFivePlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_armstand where seven_five_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}
-(NSArray*)GetArmstandTenPlatform {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_armstand where ten_meter=1"];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

// gets the dive array based on category and boardsize
-(NSArray*)LoadDivePicker:(int)divecat BoardSize:(NSNumber*)boardsize {
    
    NSArray *diveTypes = [[NSArray alloc] init];
    
    switch (divecat) {
        case 1:
            if ([boardsize isEqual: @1.0]) {
                diveTypes = self.GetForwardOneSpringboard;
            } else if ([boardsize isEqual: @3.0]) {
                diveTypes = self.GetForwardThreeSpringboard;
            } else if ([boardsize isEqual: @5.0]) {
                diveTypes = self.GetForwardFivePlatform;
            } else if ([boardsize isEqual: @7.5]) {
                diveTypes = self.GetForwardSevenFivePlatform;
            } else {
                diveTypes = self.GetForwardTenPlatform;
            }
            break;
        case 2:
            if ([boardsize isEqual: @1.0]) {
                diveTypes = self.GetBackOneSpringboard;
            } else if ([boardsize isEqual: @3.0]) {
                diveTypes = self.GetBackThreeSpringboard;
            } else if ([boardsize isEqual: @5.0]) {
                diveTypes = self.GetBackFivePlatform;
            } else if ([boardsize isEqual: @7.5]) {
                diveTypes = self.GetBackSevenFivePlatform;
            } else {
                diveTypes = self.GetBackTenPlatform;
            }
            break;
        case 3:
            if ([boardsize isEqual: @1.0]) {
                diveTypes = self.GetReverseOneSpringboard;
            } else if ([boardsize isEqual: @3.0]) {
                diveTypes = self.GetReverseThreeSpringboard;
            } else if ([boardsize isEqual: @5.0]) {
                diveTypes = self.GetReverseFivePlatform;
            } else if ([boardsize isEqual: @7.5]) {
                diveTypes = self.GetReverseSevenFivePlatform;
            } else {
                diveTypes = self.GetReverseTenPlatform;
            }
            break;
        case 4:
            if ([boardsize isEqual: @1.0]) {
                diveTypes = self.GetInwardOneSpringboard;
            } else if ([boardsize isEqual: @3.0]) {
                diveTypes = self.GetInwardThreeSpringboard;
            } else if ([boardsize isEqual: @5.0]) {
                diveTypes = self.GetInwardFivePlatform;
            } else if ([boardsize isEqual: @7.5]) {
                diveTypes = self.GetInwardSevenFivePlatform;
            } else {
                diveTypes = self.GetInwardTenPlatform;
            }
            break;
        case 5:
            if ([boardsize isEqual: @1.0]) {
                diveTypes = self.GetTwistOneSpringboard;
            } else if ([boardsize isEqual: @3.0]) {
                diveTypes = self.GetTwistThreeSpringboard;
            } else if ([boardsize isEqual: @5.0]) {
                diveTypes = self.GetTwistFivePlatform;
            } else if ([boardsize isEqual: @7.5]) {
                diveTypes = self.GetTwistSevenFivePlatform;
            } else {
                diveTypes = self.GetTwistTenPlatform;
            }
            break;
        case 6:
            if ([boardsize isEqual: @5.0]) {
                diveTypes = self.GetArmstandFivePlatform;
            } else if ([boardsize isEqual: @7.5]) {
                diveTypes = self.GetArmstandSevenFivePlatform;
            } else {
                diveTypes = self.GetArmstandTenPlatform;
            }
            break;
    }
    
    return diveTypes;
}

// gets the dive dod
-(NSArray*)GetAllDiveDODs:(int)divecat DiveTypeId:(int)divetypeid BoardType:(NSNumber*)boardsize {
    
    NSArray *diveTypes = [[NSArray alloc] init];
    
    switch (divecat) {
        case 1:
            if ([boardsize isEqual: @1.0]) {
                diveTypes = [self GetForwardOneSpringboardById:divetypeid];
            } else if ([boardsize isEqual: @3.0]) {
                diveTypes = [self GetForwardThreeSpringboardById:divetypeid];
            } else if ([boardsize isEqual: @5.0]) {
                diveTypes = [self GetForwardFivePlatformById:divetypeid];
            } else if ([boardsize isEqual: @7.5]) {
                diveTypes = [self GetForwardSevenFivePlatformById:divetypeid];
            } else {
                diveTypes = [self GetForwardTenPlatformById:divetypeid];
            }
            break;
        case 2:
            if ([boardsize isEqual: @1.0]) {
                diveTypes = [self GetBackOneSpringboardById:divetypeid];
            } else if ([boardsize isEqual: @3.0]) {
                diveTypes = [self GetBackThreeSpringboardById:divetypeid];
            } else if ([boardsize isEqual: @5.0]) {
                diveTypes = [self GetBackFivePlatformById:divetypeid];
            } else if ([boardsize isEqual: @7.5]) {
                diveTypes = [self GetBackSevenFivePlatformById:divetypeid];
            } else {
                diveTypes = [self GetBackTenPlatformById:divetypeid];
            }
            break;
        case 3:
            if ([boardsize isEqual: @1.0]) {
                diveTypes = [self GetReverseOneSpringboardById:divetypeid];
            } else if ([boardsize isEqual: @3.0]) {
                diveTypes = [self GetReverseThreeSpringboardById:divetypeid];
            } else if ([boardsize isEqual: @5.0]) {
                diveTypes = [self GetReverseFivePlatformById:divetypeid];
            } else if ([boardsize isEqual: @7.5]) {
                diveTypes = [self GetReverseSevenFivePlatformById:divetypeid];
            } else {
                diveTypes = [self GetReverseTenPlatformById:divetypeid];
            }
            break;
        case 4:
            if ([boardsize isEqual: @1.0]) {
                diveTypes = [self GetInwardOneSpringboardById:divetypeid];
            } else if ([boardsize isEqual: @3.0]) {
                diveTypes = [self GetInwardThreeSpringboardById:divetypeid];
            } else if ([boardsize isEqual: @5.0]) {
                diveTypes = [self GetInwardFivePlatformById:divetypeid];
            } else if ([boardsize isEqual: @7.5]) {
                diveTypes = [self GetInwardSevenFivePlatformById:divetypeid];
            } else {
                diveTypes = [self GetInwardTenPlatformById:divetypeid];
            }
            break;
        case 5:
            if ([boardsize isEqual: @1.0]) {
                diveTypes = [self GetTwistOneSpringboardById:divetypeid];
            } else if ([boardsize isEqual: @3.0]) {
                diveTypes = [self GetTwistThreeSpringboardById:divetypeid];
            } else if ([boardsize isEqual: @5.0]) {
                diveTypes = [self GetTwistFivePlatformById:divetypeid];
            } else if ([boardsize isEqual: @7.5]) {
                diveTypes = [self GetTwistSevenFivePlatformById:divetypeid];
            } else {
                diveTypes = [self GetTwistTenPlatformById:divetypeid];
            }
            break;
        case 6:
            if ([boardsize isEqual: @5.0]) {
                diveTypes = [self GetArmstandFivePlatformById:divetypeid];
            } else if ([boardsize isEqual: @7.5]) {
                diveTypes = [self GetArmstandSevenFivePlatformById:divetypeid];
            } else {
                diveTypes = [self GetArmstandTenPlatformById:divetypeid];
            }
            break;
    }
    
    return diveTypes;
    
}

#pragma private methods

// springboard
-(NSArray*)GetForwardOneSpringboardById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select oneS, oneP, oneT, oneF from springboard_forward where one_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetForwardThreeSpringboardById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select threeS, threeP, threeT, threeF from springboard_forward where three_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetBackOneSpringboardById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select oneS, oneP, oneT, oneF from springboard_back where one_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetBackThreeSpringboardById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select threeS, threeP, threeT, threeF from springboard_back where three_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetInwardOneSpringboardById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select oneS, oneP, oneT, oneF from springboard_inward where one_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetInwardThreeSpringboardById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select threeS, threeP, threeT, threeF from springboard_inward where three_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetReverseOneSpringboardById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select oneS, oneP, oneT, oneF from springboard_reverse where one_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetReverseThreeSpringboardById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select threeS, threeP, threeT, threeF from springboard_reverse where three_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetTwistOneSpringboardById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select oneS, oneP, oneT, oneF from springboard_twist where one_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetTwistThreeSpringboardById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select threeS, threeP, threeT, threeF from springboard_twist where three_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

// platform
-(NSArray*)GetForwardFivePlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select fiveS, fiveP, fiveT, fiveF from platform_front where five_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetForwardSevenFivePlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select seven_fiveS, seven_fiveP, seven_fiveT, seven_fiveF from platform_front where seven_five_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetForwardTenPlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select tenS, tenP, tenT, tenF from platform_front where ten_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetBackFivePlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select fiveS, fiveP, fiveT, fiveF from platform_back where five_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetBackSevenFivePlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select seven_fiveS, seven_fiveP, seven_fiveT, seven_fiveF from platform_back where seven_five_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetBackTenPlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select tenS, tenP, tenT, tenF from platform_back where ten_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetInwardFivePlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select fiveS, fiveP, fiveT, fiveF from platform_inward where five_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetInwardSevenFivePlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select seven_fiveS, seven_fiveP, seven_fiveT, seven_fiveF from platform_inward where seven_five_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetInwardTenPlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select tenS, tenP, tenT, tenF from platform_inward where ten_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetReverseFivePlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select fiveS, fiveP, fiveT, fiveF from platform_reverse where five_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetReverseSevenFivePlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select seven_fiveS, seven_fiveP, seven_fiveT, seven_fiveF from platform_reverse where seven_five_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetReverseTenPlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select tenS, tenP, tenT, tenF from platform_reverse where ten_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetTwistFivePlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select fiveS, fiveP, fiveT, fiveF from platform_twist where five_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetTwistSevenFivePlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select seven_fiveS, seven_fiveP, seven_fiveT, seven_fiveF from platform_twist where seven_five_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetTwistTenPlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select tenS, tenP, tenT, tenF from platform_twist where ten_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetArmstandFivePlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select fiveS, fiveP, fiveT, fiveF from platform_armstand where five_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

-(NSArray*)GetArmstandSevenFivePlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select seven_fiveS, seven_fiveP, seven_fiveT, seven_fiveF from platform_armstand where seven_five_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}
-(NSArray*)GetArmstandTenPlatformById:(int)diveId {
    
    //NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select tenS, tenP, tenT, tenF from platform_armstand where ten_meter=1 and id=%d", diveId];
    
    NSArray *names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"query is: %@", query);
    
    return names;
    
}

@end
