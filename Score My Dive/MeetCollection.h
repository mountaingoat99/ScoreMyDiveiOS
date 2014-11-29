//
//  MeetCollection.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/26/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeetCollection : NSObject

@property (nonatomic, strong) NSArray *collectionOfMeetObjects;

-(NSArray*)GetMeetCollection:(int)meetid;

@end
