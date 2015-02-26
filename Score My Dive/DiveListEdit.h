//
//  DiveListEdit.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/20/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTAutocompleteTextField.h"
#import "TypeDiveNumber.h"
#import "ChooseDiveNumber.h"

@protocol DiveListEnterViewControllerDelegate

-(void)editDiveListWasFinished;

@end

@interface DiveListEdit : UIViewController <TypeDiveNumberDelegate, ChooseDiveNumberDelegate>

//popover
@property (nonatomic, retain) UIPopoverController *popoverContr;

// delegate property
@property (nonatomic, strong) id<DiveListEnterViewControllerDelegate> delegate;

@property (nonatomic) int meetRecordID;
@property (nonatomic) int diverRecordID;
@property (nonatomic, strong) NSNumber *boardSize;
@property (nonatomic, strong) NSNumber *diveNumber;
@property (nonatomic, strong) NSString *oldDiveName;
@property (nonatomic, strong) NSArray *meetInfo;
@property (weak, nonatomic) IBOutlet UILabel *backgroundPanel;

@property (weak, nonatomic) IBOutlet UILabel *lblDiveNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblOldDiveName;

- (IBAction)btnTypeNumber:(id)sender;
- (IBAction)btnChooseDives:(id)sender;

@end
