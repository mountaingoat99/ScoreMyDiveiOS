//
//  ChooseDiveNumber.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 2/22/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYPopoverController.h"

@protocol ChooseDiveNumberDelegate

-(void)chooseDiveNumberWasFinished;

@end

@interface ChooseDiveNumber : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (nonatomic, strong) id<ChooseDiveNumberDelegate> delegate;

//WYPopoverController delegate
@property (nonatomic, assign) WYPopoverController *controller;

@property (nonatomic, strong) NSNumber *boardSize;
@property (nonatomic) int meetRecordID;
@property (nonatomic) int diverRecordID;
@property (nonatomic, strong) NSArray *meetInfo;
@property (nonatomic) int maxDiveNumber;
@property (nonatomic, strong) NSNumber *onDiveNumber;
// this lets the class know who called them
// 1 is the DiveListEnter
// 2 is the DiveListEdit
// 3 is the DiveEnter
@property (nonatomic) int whoCalled;

@property (nonatomic) int diveGroupID;
@property (nonatomic) int diveID;
@property (nonatomic) int divePositionID;

@property (weak, nonatomic) IBOutlet UITextField *txtDiveGroup;
@property (weak, nonatomic) IBOutlet UITextField *txtDive;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SCPosition;
@property (weak, nonatomic) IBOutlet UILabel *lblDiveddText;
@property (weak, nonatomic) IBOutlet UILabel *lblDivedd;

@property (weak, nonatomic) IBOutlet UILabel *backgroundPanel;

- (IBAction)PositionIndexChanged:(UISegmentedControl *)sender;
- (IBAction)btnEnter:(id)sender;

@end
