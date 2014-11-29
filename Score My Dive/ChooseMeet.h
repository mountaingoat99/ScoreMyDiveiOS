//
//  ChooseMeet.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseMeet : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) int meetRecordID;
@property (nonatomic) NSNumber *judgeTotal;

@property (weak, nonatomic) IBOutlet UITextField *txtChooseMeet;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SCJudges;
@property (weak, nonatomic) IBOutlet UILabel *lblJudges;

- (IBAction)nextClick:(id)sender;
- (IBAction)JudgesClick:(UISegmentedControl *)sender;

@end
