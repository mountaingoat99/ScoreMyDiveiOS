//
//  UIViewController+QuickScoreViewController.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 10/31/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuickScoreViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *btnNewSheet;
@property (weak, nonatomic) IBOutlet UIButton *btnChooseSheet;
@property (weak, nonatomic) IBOutlet UITableView *scoreSheetTable;
@property (strong, nonatomic) IBOutlet UIView *pickerViewContainer;

- (IBAction)btnNewSheet_click:(id)sender;
- (IBAction)btnChooseDiver_click:(id)sender;
- (IBAction)btnDiverChoosen_click:(id)sender;

@end
