//
//  DiverEdit.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/19/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiverEdit.h"
#import "Diver.h"


@interface DiverEdit ()

-(void)loadInfoToEdit;

@end

@implementation DiverEdit


#pragma View Controller Events

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // drop shadow for the text boxes
    self.txtName.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtName.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtName.layer.masksToBounds = NO;
    self.txtName.layer.shadowRadius = 4.0f;
    self.txtName.layer.shadowOpacity = .5;
    self.txtName.keyboardAppearance = UIKeyboardAppearanceDark;
    
    self.txtSchool.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtSchool.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtSchool.layer.masksToBounds = NO;
    self.txtSchool.layer.shadowRadius = 4.0f;
    self.txtSchool.layer.shadowOpacity = .5;
    self.txtSchool.keyboardAppearance = UIKeyboardAppearanceDark;
    
    self.txtAge.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtAge.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtAge.layer.masksToBounds = NO;
    self.txtAge.layer.shadowRadius = 4.0f;
    self.txtAge.layer.shadowOpacity = .5;
    self.txtAge.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtAge.keyboardType = UIKeyboardTypeNumberPad;
    
    self.txtGrade.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtGrade.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtGrade.layer.masksToBounds = NO;
    self.txtGrade.layer.shadowRadius = 4.0f;
    self.txtGrade.layer.shadowOpacity = .5;
    self.txtGrade.keyboardAppearance = UIKeyboardAppearanceDark;
    
    self.txtName.delegate = self;
    self.txtSchool.delegate = self;
    self.txtAge.delegate = self;
    self.txtGrade.delegate = self;
    
    if (self.recordIDToEdit != -1) {
        [self loadInfoToEdit];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

// hide the keyboard on outside touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

// database insert
-(IBAction)saveInfo:(id)sender {
    
    // make sure all text fields have an entry
    if (self.txtName.text.length == 0 || self.txtAge.text.length == 0 ||
        self.txtGrade.text.length == 0 || self.txtSchool.text.length == 0) {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"Please enter a value for all fields"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
        
    } else {
        
        Diver *diver = [[Diver alloc] init];
        
        if ([diver UpdateDiver:self.recordIDToEdit Name:self.txtName.text Age:self.txtAge.text Grade:self.txtGrade.text School:self.txtSchool.text]) {
            
            //inform the delegate that the edit was finished and update previous
            //viewcontroller table rows
            [self.delegate editInfoWasFinished];
            
            // pop the view controller
            //[self.navigationController popViewControllerAnimated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            
         } else {
            //TODO: figure out something to do
        }
    }
}

#pragma private methods

// loads a current record into the text fields
-(void)loadInfoToEdit {
    
    // send the id to the class method to get the results array for the text boxes
    Diver *diver = [[Diver alloc] init];
    NSArray *diverArray = [diver LoadDiver:self.recordIDToEdit];
    
    // set the data to the correct text boxes to edit
    self.txtName.text = [[diverArray objectAtIndex:0] objectAtIndex:1];
    self.txtAge.text = [[diverArray objectAtIndex:0] objectAtIndex:2];
    self.txtGrade.text = [[diverArray objectAtIndex:0] objectAtIndex:3];
    self.txtSchool.text = [[diverArray objectAtIndex:0] objectAtIndex:4];
    
}

@end
