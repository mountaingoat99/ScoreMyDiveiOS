//
//  TypeDiveNumber.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 2/21/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTAutocompleteTextField.h"

@protocol TypeDiveNumberDelegate

-(void)typeDiveNumberWasFinished;

@end

@interface TypeDiveNumber : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) id<TypeDiveNumberDelegate> delegate;

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

@property (weak, nonatomic) IBOutlet UILabel *lblDiveddText;
@property (weak, nonatomic) IBOutlet UILabel *lblDivedd;
@property (weak, nonatomic) IBOutlet UILabel *backgroundPanel;

// autofill controls
@property (unsafe_unretained, nonatomic) IBOutlet HTAutocompleteTextField *txtDiveNumberEntry;
@property (unsafe_unretained, nonatomic) IBOutlet HTAutocompleteTextField *txtDivePositionEntry;

- (IBAction)btnEnter:(id)sender;

@end
