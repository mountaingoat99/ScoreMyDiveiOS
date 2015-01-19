//
//  DiverEdit.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/19/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DiverDetailsViewControllerDelegate

-(void)editInfoWasFinished;

@end

@interface DiverEdit : UIViewController <UITextFieldDelegate>

// delegate property
@property (nonatomic, strong) id<DiverDetailsViewControllerDelegate> delegate;

// edit record property
@property (nonatomic) int recordIDToEdit;

@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextField *txtAge;
@property (weak, nonatomic) IBOutlet UITextField *txtGrade;
@property (weak, nonatomic) IBOutlet UITextField *txtSchool;

-(IBAction)saveInfo:(id)sender;
//- (IBAction)btnReturnClick:(id)sender;

@end
