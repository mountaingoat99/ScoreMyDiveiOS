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

@interface QuickScoreEdit : UIViewController 

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
