//
//  UIViewController+DiverDetailsVC.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/2/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiverDetailsVC : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnDiverNew;
@property (weak, nonatomic) IBOutlet UIButton *btnDiverReports;
@property (weak, nonatomic) IBOutlet UIButton *btnDiverHistory;
@property (weak, nonatomic) IBOutlet UIButton *btnDiverEdit;

- (IBAction)newDiver_click:(id)sender;
- (IBAction)diverReports_click:(id)sender;
- (IBAction)diverHistory_click:(id)sender;
- (IBAction)diverEdit_click:(id)sender;

@end
