//
//  DBManager.h
//  ScoreMyDive
//
//  Created by Jeremey Rodriguez on 11/7/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

// custom init method declaration
-(instancetype)initWithDatabaseFilename:(NSString *)dive_dod;

// properties for db query
@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

// public methods for the db selects and querys
// select multiple results first
-(NSArray *)loadDataFromDB:(NSString *)query;

// selects one value
-(NSString *)loadOneDataFromDB:(NSString *)query;

// insert, update, and delete
-(void)executeQuery:(NSString *)query;

@end
