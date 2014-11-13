//
//  UIViewController+QuickScoreViewController.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 10/31/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "QuickScoreViewController.h"

@interface QuickScoreViewController ()

@end

@implementation QuickScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //drop shadow for the buttons
    self.btnNewSheet.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnNewSheet.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnNewSheet.layer.masksToBounds = NO;
    self.btnNewSheet.layer.shadowOpacity = .5;
    
    self.btnChooseSheet.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnChooseSheet.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnChooseSheet.layer.masksToBounds = NO;
    self.btnChooseSheet.layer.shadowOpacity = .5;

    // draw the picker view container off the frame
    _pickerViewContainer.frame = CGRectMake(0, 800, 353, 224);

}




-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
}

-(IBAction)unwideToQuickScore:(UIStoryboardSegue *)segue{
    
}

- (IBAction)btnNewSheet_click:(id)sender {
}

- (IBAction)btnChooseDiver_click:(id)sender {
}

- (IBAction)btnDiverChoosen_click:(id)sender {
}
@end
