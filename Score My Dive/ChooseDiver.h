//
//  ChooseDiver.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/23/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseDiver : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic) int meetRecordID;
@property (nonatomic) int diverRecordID;

@property (weak, nonatomic) IBOutlet UITextField *txtChooseDiver;
@property (weak, nonatomic) IBOutlet UILabel *lblMeetName;
@property (weak, nonatomic) IBOutlet UISegmentedControl *radioDiveTotals;

@end
