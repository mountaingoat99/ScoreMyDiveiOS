//
//  QuickScoreEdit.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/15/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

// lets us tell the QuickScoreViewController we have updated
// a field when we pop this ViewController off the stack
@protocol QuickScoreViewControllerDelegate

-(void)editInfoWasFinished;

@end

@interface QuickScoreEdit : UIViewController<UITextFieldDelegate>

// Outlets for button drop shadows
@property (weak, nonatomic) IBOutlet UIButton *btnName;
@property (weak, nonatomic) IBOutlet UIButton *btnDive1;
@property (weak, nonatomic) IBOutlet UIButton *btnDive2;
@property (weak, nonatomic) IBOutlet UIButton *btnDive3;
@property (weak, nonatomic) IBOutlet UIButton *btnDive4;
@property (weak, nonatomic) IBOutlet UIButton *btnDive5;
@property (weak, nonatomic) IBOutlet UIButton *btnDive6;
@property (weak, nonatomic) IBOutlet UIButton *btnDive7;
@property (weak, nonatomic) IBOutlet UIButton *btnDive8;
@property (weak, nonatomic) IBOutlet UIButton *btnDive9;
@property (weak, nonatomic) IBOutlet UIButton *btnDive10;
@property (weak, nonatomic) IBOutlet UIButton *btnDive11;


// declaration for the delegate property
@property (nonatomic, strong) id<QuickScoreViewControllerDelegate> delegate;

// edit record property
@property (nonatomic) int recordIDToEdit;

// button properties to change the text
@property (strong, nonatomic) IBOutlet UILabel *nameTxt;
@property (strong, nonatomic) IBOutlet UILabel *dive1Txt;
@property (strong, nonatomic) IBOutlet UILabel *dive2Txt;
@property (strong, nonatomic) IBOutlet UILabel *dive3Txt;
@property (strong, nonatomic) IBOutlet UILabel *dive4Txt;
@property (strong, nonatomic) IBOutlet UILabel *dive5Txt;
@property (strong, nonatomic) IBOutlet UILabel *dive6Txt;
@property (strong, nonatomic) IBOutlet UILabel *dive7Txt;
@property (strong, nonatomic) IBOutlet UILabel *dive8Txt;
@property (strong, nonatomic) IBOutlet UILabel *dive9Txt;
@property (strong, nonatomic) IBOutlet UILabel *dive10Txt;
@property (strong, nonatomic) IBOutlet UILabel *dive11Txt;
@property (strong, nonatomic) IBOutlet UILabel *totalTxt;


// button long presses to edit the data
- (IBAction)nameClick:(id)sender;
- (IBAction)diveOneClick:(id)sender;
- (IBAction)diveTwoClick:(id)sender;
- (IBAction)diveThreeClick:(id)sender;
- (IBAction)diveFourClick:(id)sender;
- (IBAction)diveFiveClick:(id)sender;
- (IBAction)diveSixClick:(id)sender;
- (IBAction)diveSevenClick:(id)sender;
- (IBAction)diveEightClick:(id)sender;
- (IBAction)diveNineClick:(id)sender;
- (IBAction)diveTenClick:(id)sender;
- (IBAction)diveElevenClick:(id)sender;

// save to the database
- (IBAction)saveInfo:(id)sender;

@end
