//
//  ChooseMeet.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseMeet : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (nonatomic) int meetRecordID;

@property (weak, nonatomic) IBOutlet UITextField *txtChooseMeet;
@property (weak, nonatomic) IBOutlet UILabel *lblJudges;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;
@property (weak, nonatomic) IBOutlet UIButton *btnRank;

- (IBAction)nextClick:(id)sender;

@end
