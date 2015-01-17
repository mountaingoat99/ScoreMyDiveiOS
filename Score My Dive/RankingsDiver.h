//
//  RankingsDiver.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingsDiver : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int meetId;
@property (nonatomic, strong) NSNumber *boardSize;
@property (weak, nonatomic) IBOutlet UITableView *tblDiverRankings;

- (IBAction)btnReturnClick:(id)sender;


@end
