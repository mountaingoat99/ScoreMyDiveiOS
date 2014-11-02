//
//  UIViewController+QuickScoreViewController.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 10/31/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "QuickScoreViewController.h"

@interface QuickScoreViewController ()

@property (nonatomic, strong) IBOutlet UIButton *buttonNewQuickScore;
@property (nonatomic, strong) IBOutlet UIButton *buttonChooseDiver;

@end

@implementation QuickScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //drop shadow for the buttons
    self.buttonNewQuickScore.layer.shadowColor = [UIColor blackColor].CGColor;
    self.buttonNewQuickScore.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
    self.buttonNewQuickScore.layer.masksToBounds = NO;
    self.buttonNewQuickScore.layer.shadowRadius = 4.0f;
    self.buttonNewQuickScore.layer.shadowOpacity = 1.0;
    
    self.buttonChooseDiver.layer.shadowColor = [UIColor blackColor].CGColor;
    self.buttonChooseDiver.layer.shadowOffset = CGSizeMake(3.0f, 3.0f);
    self.buttonChooseDiver.layer.masksToBounds = NO;
    self.buttonChooseDiver.layer.shadowRadius = 4.0f;
    self.buttonChooseDiver.layer.shadowOpacity = 1.0;
    
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}

-(IBAction)unwideToQuickScore:(UIStoryboardSegue *)segue{
    
}

@end
