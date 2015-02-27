//
//  UIViewController+DiverDetailsVC.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/2/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiverEdit.h"

@interface DiverDetailsVC : UIViewController <UITableViewDelegate, UITableViewDataSource, DiverDetailsViewControllerDelegate>

@property (nonatomic) int recordIDToEdit;

@property (weak, nonatomic) IBOutlet UITableView *tblDivers;

-(IBAction)addNewRecord:(id)sender;

@end
