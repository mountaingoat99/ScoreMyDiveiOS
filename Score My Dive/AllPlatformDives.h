//
//  AllPlatformDives.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 1/18/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllPlatformDives : NSObject

-(NSArray*)GetPlatformNames;

-(NSArray*)GetPlatformCategories:(int)diveid;

@end
