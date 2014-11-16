//
//  HomeViewController.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 10/30/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "HomeViewController.h"
#import "DBManager.h"

@interface HomeViewController ()

// database
@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // drop shadow for the buttons
    self.btnQuick.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnQuick.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnQuick.layer.masksToBounds = NO;
    self.btnQuick.layer.shadowOpacity = .5;
    
    self.btnDetails.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnDetails.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnDetails.layer.masksToBounds = NO;
    self.btnDetails.layer.shadowOpacity = .5;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToMainMenu:(UIStoryboardSegue *)segue{
    
}

@end
