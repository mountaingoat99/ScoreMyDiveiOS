//
//  DiverHistory.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/27/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiverHistory : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int recordIdToEdit;

@property (weak, nonatomic) IBOutlet UITableView *tblHistory;

@end
