//
//  HomeViewController.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 10/30/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@property (nonatomic,strong) IBOutlet UIButton *buttonQuick;
@property (nonatomic,strong) IBOutlet UIButton *buttonDetails;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // drop shadow for the buttons
    self.buttonQuick.layer.shadowColor = [UIColor blackColor].CGColor;
    self.buttonQuick.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
    self.buttonQuick.layer.masksToBounds = NO;
    self.buttonQuick.layer.shadowRadius = 4.0f;
    self.buttonQuick.layer.shadowOpacity = 1.0;
    
    self.buttonDetails.layer.shadowColor = [UIColor blackColor].CGColor;
    self.buttonDetails.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
    self.buttonDetails.layer.masksToBounds = NO;
    self.buttonDetails.layer.shadowRadius = 4.0f;
    self.buttonDetails.layer.shadowOpacity = 1.0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
