//
//  DiveListEdit.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/20/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DiveListEnterViewControllerDelegate

-(void)editDiveListWasFinished;

@end

@interface DiveListEdit : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

// delegate property
@property (nonatomic, strong) id<DiveListEnterViewControllerDelegate> delegate;

@property (nonatomic) int meetRecordID;
@property (nonatomic) int diverRecordID;
@property (nonatomic, strong) NSNumber *boardSize;
@property (nonatomic, strong) NSNumber *diveNumber;
@property (nonatomic, strong) NSString *oldDiveName;
@property (nonatomic, strong) NSArray *meetInfo;

@property (weak, nonatomic) IBOutlet UILabel *lblDiveNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtDiveGroup;
@property (weak, nonatomic) IBOutlet UITextField *txtDive;
@property (weak, nonatomic) IBOutlet UISegmentedControl *SCPosition;
@property (weak, nonatomic) IBOutlet UILabel *lblDivedd;
@property (weak, nonatomic) IBOutlet UIButton *btnEnterDive;
@property (weak, nonatomic) IBOutlet UILabel *lblOldDiveName;

- (IBAction)PositionIndexChanged:(UISegmentedControl *)sender;
- (IBAction)btnEnterDive:(id)sender;
//- (IBAction)btnReturnClick:(id)sender;

@end
