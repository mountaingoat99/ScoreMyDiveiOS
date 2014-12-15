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

@end

@implementation DiveTypes

// springboard
-(NSArray*)GetForwardOneSpringboard {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_forward where one_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetForwardThreeSpringboard {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_forward where three_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetBackOneSpringboard {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_back where one_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetBackThreeSpringboard {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_back where three_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetInwardOneSpringboard {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_inward where one_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetInwardThreeSpringboard {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_inwardwhere three_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetReverseOneSpringboard {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_reverse where one_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetReverseThreeSpringboard {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_reverse where three_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetTwistOneSpringboard {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_twist where one_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetTwistThreeSpringboard {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_tewist where three_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

// platform
-(NSArray*)GetForwardFivePlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_front where five_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetForwardSevenFivePlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_front where seven_five_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetForwardTenPlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_front where ten_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetBackFivePlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_back where five_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetBackSevenFivePlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_back where seven_five_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetBackTenPlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_back where ten_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetInwardFivePlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_inward where five_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetInwardSevenFivePlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_inward where seven_five_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetInwardTenPlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_inward where ten_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetReverseFivePlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_reverse where five_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetReverseSevenFivePlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_reverse where seven_five_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetReverseTenPlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_reverse where ten_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetTwistFivePlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_twist where five_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetTwistSevenFivePlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_twist where seven_five_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetTwistTenPlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_twist where ten_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetArmstandFivePlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_armstand where five_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}

-(NSArray*)GetArmstandSevenFivePlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_armstand where seven_five_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return names;
    
}
-(NSArray*)GetArmstandTenPlatform {
    
    NSArray *names = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_armstand where ten_meter=1"];
    
    names = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
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

// gets the id from the dive by dive name
-(NSNumber*)GetDiveID:(NSString*)diveName DivePosition:(NSNumber*)diveposition BoardType:(NSNumber*)boardtype {
    
    //TODO: here we will decide how we can get a dive id froma dive and return it
    
    NSNumber* diveid;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select id from"];
    
    
    return diveid;
}

// gets the dive dod
-(NSNumber*)getDiveDOD:(NSNumber*)diveid DivePosition:(NSNumber*)diveposition BoardType:(NSNumber*)boardtype {
    
    NSNumber* dod;
    
    
    return dod;
}

@end
