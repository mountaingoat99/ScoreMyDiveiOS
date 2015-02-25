//
//  SwitchDiver.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 2/25/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwitchDiver : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int diverRecordID;
@property (nonatomic) int meetRecordID;
@property (nonatomic, strong) NSArray *meetInfo;

@property (weak, nonatomic) IBOutlet UITableView *tblDiverRankings;

@end
