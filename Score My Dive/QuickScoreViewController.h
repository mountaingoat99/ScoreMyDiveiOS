//
//  UIViewController+QuickScoreViewController.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 10/31/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuickScoreEdit.h"

@interface QuickScoreViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, QuickScoreViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblQuickScores;

-(IBAction)addNewRecord:(id)sender;

@end
