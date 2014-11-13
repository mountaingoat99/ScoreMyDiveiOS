//
//  UIViewController+DiverDetailsVC.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/2/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiverDetailsVC.h"

@interface DiverDetailsVC ()



@end

@implementation DiverDetailsVC

#pragma mark  - UIViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    // drop shadow for the buttons
    self.btnDiverNew.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnDiverNew.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.btnDiverNew.layer.masksToBounds = NO;
    self.btnDiverNew.layer.shadowRadius = 4.0f;
    self.btnDiverNew.layer.shadowOpacity = 1.0;
    self.btnDiverReports.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnDiverReports.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.btnDiverReports.layer.masksToBounds = NO;
    self.btnDiverReports.layer.shadowRadius = 4.0f;
    self.btnDiverReports.layer.shadowOpacity = 1.0;
    self.btnDiverHistory.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnDiverHistory.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.btnDiverHistory.layer.masksToBounds = NO;
    self.btnDiverHistory.layer.shadowRadius = 4.0f;
    self.btnDiverHistory.layer.shadowOpacity = 1.0;
    self.btnDiverEdit.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnDiverEdit.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.btnDiverEdit.layer.masksToBounds = NO;
    self.btnDiverEdit.layer.shadowRadius = 4.0f;
    self.btnDiverEdit.layer.shadowOpacity = 1.0;
}

-(IBAction)unwindToDiverDetails:(UIStoryboardSegue *)segue{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newDiver_click:(id)sender {
}

- (IBAction)diverReports_click:(id)sender {
}

- (IBAction)diverHistory_click:(id)sender {
}

- (IBAction)diverEdit_click:(id)sender {
}
@end
