//
//  ReportsViewController.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportsViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

// send reports
- (IBAction)sendClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtxChooseDiver;
@property (weak, nonatomic) IBOutlet UITextField *txtChooseMeet;
@property (weak, nonatomic) IBOutlet UITextField *txtChooseReport;

@end
