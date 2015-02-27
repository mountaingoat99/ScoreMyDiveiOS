//
//  RankingsMeet.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RankingsMeet : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblRankings;

@end
