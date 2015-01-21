//
//  AllSpringboardDives.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 1/18/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import "AllSpringboardDives.h"
#import "DBManager.h"

@interface AllSpringboardDives ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation AllSpringboardDives

-(NSArray*)GetSpringboardName {
    
    NSArray *dives = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select id from all_springboard_dives"];
    
    dives = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return dives;
    
}

-(NSArray*)GetSpringboardCategories:(int)diveid {
    
    NSArray *dives = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from all_springboard_dives where id=%d", diveid];
    
    dives = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return dives;
    
}

@end
