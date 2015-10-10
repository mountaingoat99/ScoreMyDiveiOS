//
//  DiverEdit.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/19/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiverEdit.h"
#import "Diver.h"
#import "AlertControllerHelper.h"
#import "AppDelegate.h"

@interface DiverEdit ()

-(void)loadInfoToEdit;

@end

@implementation DiverEdit


#pragma View Controller Events

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self restrictRotation:YES];
    
    self.backgroundLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backgroundLabel.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.backgroundLabel.layer.masksToBounds = NO;
    self.backgroundLabel.layer.shadowOpacity = 1.0;

    self.txtName.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtName.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.txtName.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);

    self.txtSchool.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtSchool.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.txtSchool.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);

    self.txtAge.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtAge.keyboardType = UIKeyboardTypeNumberPad;
    self.txtAge.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);

    self.txtGrade.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtGrade.autocapitalizationType = UITextAutocapitalizationTypeWords;
    self.txtGrade.layer.sublayerTransform = CATransform3DMakeTranslation(5, 0, 0);
    
    self.txtName.delegate = self;
    self.txtSchool.delegate = self;
    self.txtAge.delegate = self;
    self.txtGrade.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.recordIDToEdit != -1) {
        [self loadInfoToEdit];
    }
}

// only allow portrait in iphone
-(void) restrictRotation:(BOOL) restriction
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.restrictRotation = restriction;
}

// saving state
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super encodeRestorableStateWithCoder:coder];
    
    [coder encodeObject:self.delegate forKey:@"Delegate"];
    [coder encodeInt:self.recordIDToEdit forKey:@"RecordId"];
    
    // lets see if there is any text in the fields and save that as well
    if (self.txtName.text.length > 0) {
        [coder encodeObject:self.txtName.text forKey:@"Name"];
    }
    if (self.txtAge.text.length > 0) {
        [coder encodeObject:self.txtAge.text forKey:@"Age"];
    }
    if (self.txtGrade.text.length > 0) {
        [coder encodeObject:self.txtGrade.text forKey:@"Grade"];
    }
    if (self.txtSchool.text.length > 0) {
        [coder encodeObject:self.txtSchool.text forKey:@"School"];
    }
    
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.delegate = [coder decodeObjectForKey:@"Delegate"];
    self.recordIDToEdit = [coder decodeIntForKey:@"RecordId"];
    self.txtName.text = [coder decodeObjectForKey:@"Name"];
    self.txtAge.text = [coder decodeObjectForKey:@"Age"];
    self.txtGrade.text = [coder decodeObjectForKey:@"Grade"];
    self.txtSchool.text = [coder decodeObjectForKey:@"School"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if (textField == self.txtName) {
        [self.txtAge becomeFirstResponder];
    }
    if (textField == self.txtAge) {
        [self.txtGrade becomeFirstResponder];
    }
    if (textField == self.txtGrade) {
        [self.txtSchool becomeFirstResponder];
    }
    if (textField == self.txtSchool) {
        [textField resignFirstResponder];
    }
    
    //[textField resignFirstResponder];
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
        
        [AlertControllerHelper ShowAlert:@"Hold On!" message:@"Please enter a value for all fields" view:self];
        
    } else {
        
        Diver *diver = [[Diver alloc] init];
        
        if ([diver UpdateDiver:self.recordIDToEdit Name:self.txtName.text Age:self.txtAge.text Grade:self.txtGrade.text School:self.txtSchool.text]) {
            
            //inform the delegate that the edit was finished and update previous
            //viewcontroller table rows
            [self.delegate editInfoWasFinished];
            
            [self performSegueWithIdentifier:@"idSegueDiveEnterToDetail" sender:self];
            
         } else {
            //TODO: figure out something to do
        }
    }
}

#pragma private methods

// loads a current record into the text fields
-(void)loadInfoToEdit {
    
    if (self.recordIDToEdit > 0) {
        
        // send the id to the class method to get the results array for the text boxes
        Diver *diver = [[Diver alloc] init];
        NSArray *diverArray = [diver LoadDiver:self.recordIDToEdit];
        
        if (diverArray.count > 0) {
            // set the data to the correct text boxes to edit
            self.txtName.text = [[diverArray objectAtIndex:0] objectAtIndex:1];
            self.txtAge.text = [[diverArray objectAtIndex:0] objectAtIndex:2];
            self.txtGrade.text = [[diverArray objectAtIndex:0] objectAtIndex:3];
            self.txtSchool.text = [[diverArray objectAtIndex:0] objectAtIndex:4];
        }
    }
}

@end
