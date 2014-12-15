//
//  DiveCategory.m
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveCategory.h"
#import "DBManager.h"

@interface DiveCategory ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation DiveCategory

-(NSArray*)GetSpringboardCategories {
    
    NSArray *cats = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from springboard_category"];
    
    cats = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return cats;
    
}

-(NSArray*)GetPlatformCategories {
    
    NSArray *cats = [[NSArray alloc] init];
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
    
    NSString *query = [NSString stringWithFormat:@"select * from platform_category"];
    
    cats = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    return cats;
    
}

@end
