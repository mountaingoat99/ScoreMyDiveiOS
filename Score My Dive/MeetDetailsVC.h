//
//  UIViewController+MeetDetailsVC.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/2/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetEdit.h"

@interface MeetDetailsVC : UIViewController <UITableViewDelegate, UITableViewDataSource, MeetDetailsViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tblMeets;
@property (weak, nonatomic) IBOutlet UITabBarItem *tbItem;


- (IBAction)addNewRecord:(id)sender;

@end
