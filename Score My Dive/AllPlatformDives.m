//
//  AllPlatformDives.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 1/18/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import "AllPlatformDives.h"
#import "DBManager.h"

@interface AllPlatformDives ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation AllPlatformDives

-(NSArray*)GetPlatformNames {
    
//    NSArray *dives = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select id from all_platform_dives"];
    
    NSArray *dives = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return dives;
    
}

-(NSArray*)GetPlatformCategories:(int)diveid {
    
    //NSArray *dives = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from all_platform_dives where id=%d", diveid];
    
    NSArray *dives = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return dives;
    
}

@end
