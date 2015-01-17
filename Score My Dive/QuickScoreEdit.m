//
//  QuickScoreEdit.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/15/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "QuickScoreEdit.h"
#import "QuickScores.h"

@interface QuickScoreEdit ()

@property (nonatomic, strong) NSString *nameText;
@property (nonatomic, strong) NSString *dive1;
@property (nonatomic, strong) NSString *dive2;
@property (nonatomic, strong) NSString *dive3;
@property (nonatomic, strong) NSString *dive4;
@property (nonatomic, strong) NSString *dive5;
@property (nonatomic, strong) NSString *dive6;
@property (nonatomic, strong) NSString *dive7;
@property (nonatomic, strong) NSString *dive8;
@property (nonatomic, strong) NSString *dive9;
@property (nonatomic, strong) NSString *dive10;
@property (nonatomic, strong) NSString *dive11;
@property (nonatomic, strong) NSString *scoreTotal;
@property (nonatomic) double totalScore;
@property (nonatomic) int textBoxAlert;

//private method to load the edited data
-(void)loadInfoToEdit;

@end

@implementation QuickScoreEdit

#pragma View Controller Events

-(void)viewDidLoad {
    [super viewDidLoad];
    
    // sets a border around the label to make it look like a text box
    [[self.btnName layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnName layer] setBorderWidth:1.0];
    [[self.btnName layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnName layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnName layer] setMasksToBounds:NO];
    [[self.btnName layer] setShadowOpacity:.3];
    
    [[self.btnDive1 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive1 layer] setBorderWidth:1.0];
    [[self.btnDive1 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive1 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive1 layer] setMasksToBounds:NO];
    [[self.btnDive1 layer] setShadowOpacity:.3];
    
    [[self.btnDive2 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive2 layer] setBorderWidth:1.0];
    [[self.btnDive2 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive2 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive2 layer] setMasksToBounds:NO];
    [[self.btnDive2 layer] setShadowOpacity:.3];
    
    [[self.btnDive3 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive3 layer] setBorderWidth:1.0];
    [[self.btnDive3 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive3 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive3 layer] setMasksToBounds:NO];
    [[self.btnDive3 layer] setShadowOpacity:.3];
    
    [[self.btnDive4 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive4 layer] setBorderWidth:1.0];
    [[self.btnDive4 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive4 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive4 layer] setMasksToBounds:NO];
    [[self.btnDive4 layer] setShadowOpacity:.3];
    
    [[self.btnDive5 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive5 layer] setBorderWidth:1.0];
    [[self.btnDive5 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive5 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive5 layer] setMasksToBounds:NO];
    [[self.btnDive5 layer] setShadowOpacity:.3];
    
    [[self.btnDive6 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive6 layer] setBorderWidth:1.0];
    [[self.btnDive6 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive6 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive6 layer] setMasksToBounds:NO];
    [[self.btnDive6 layer] setShadowOpacity:.3];
    
    [[self.btnDive7 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive7 layer] setBorderWidth:1.0];
    [[self.btnDive7 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive7 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive7 layer] setMasksToBounds:NO];
    [[self.btnDive7 layer] setShadowOpacity:.3];
    
    [[self.btnDive8 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive8 layer] setBorderWidth:1.0];
    [[self.btnDive8 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive8 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive8 layer] setMasksToBounds:NO];
    [[self.btnDive8 layer] setShadowOpacity:.3];
    
    [[self.btnDive9 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive9 layer] setBorderWidth:1.0];
    [[self.btnDive9 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive9 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive9 layer] setMasksToBounds:NO];
    [[self.btnDive9 layer] setShadowOpacity:.3];
    
    [[self.btnDive10 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive10 layer] setBorderWidth:1.0];
    [[self.btnDive10 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive10 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive10 layer] setMasksToBounds:NO];
    [[self.btnDive10 layer] setShadowOpacity:.3];
    
    [[self.btnDive11 layer] setBorderColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive11 layer] setBorderWidth:1.0];
    [[self.btnDive11 layer] setShadowColor:[[UIColor blackColor] CGColor]];
    [[self.btnDive11 layer] setShadowOffset:CGSizeMake(.1f, .1f)];
    [[self.btnDive11 layer] setMasksToBounds:NO];
    [[self.btnDive11 layer] setShadowOpacity:.3];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // check if we load a specific record to edit
    if(self.recordIDToEdit != -1){
        [self loadInfoToEdit];
    }
    
    [self updateTotal];
}

// restore state
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super encodeRestorableStateWithCoder:coder];
    
    [coder encodeObject:self.delegate forKey:@"Delegate"];
    [coder encodeInt:self.recordIDToEdit forKey:@"RecordId"];
    self.savedData = YES;
    [coder encodeBool:self.savedData forKey:@"savedData"];
    
    // get everything out of the txt fields
    if (self.lblnameTxt.text.length > 0) {
        [coder encodeObject:self.lblnameTxt.text forKey:@"name"];
    }
    if (self.lbldive1Txt.text.length > 0) {
        [coder encodeObject:self.lbldive1Txt.text forKey:@"dive1"];
    }
    if (self.lbldive2Txt.text.length > 0) {
        [coder encodeObject:self.lbldive2Txt.text forKey:@"dive2"];
    }
    if (self.lbldive3Txt.text.length > 0) {
        [coder encodeObject:self.lbldive3Txt.text forKey:@"dive3"];
    }
    if (self.dive4Txt.text.length > 0) {
        [coder encodeObject:self.dive4Txt.text forKey:@"dive4"];
    }
    if (self.dive5Txt.text.length > 0) {
        [coder encodeObject:self.dive5Txt.text forKey:@"dive5"];
    }
    if (self.dive6Txt.text.length > 0) {
        [coder encodeObject:self.dive6Txt.text forKey:@"dive6"];
    }
    if (self.dive7Txt.text.length > 0) {
        [coder encodeObject:self.dive7Txt.text forKey:@"dive7"];
    }
    if (self.dive8Txt.text.length > 0) {
        [coder encodeObject:self.dive8Txt.text forKey:@"dive8"];
    }
    if (self.dive9Txt.text.length > 0) {
        [coder encodeObject:self.dive9Txt.text forKey:@"dive9"];
    }
    if (self.dive10Txt.text.length > 0) {
        [coder encodeObject:self.dive10Txt.text forKey:@"dive10"];
    }
    if (self.dive11Txt.text.length > 0) {
        [coder encodeObject:self.dive11Txt.text forKey:@"dive11"];
    }
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.delegate = [coder decodeObjectForKey:@"Delegate"];
    self.recordIDToEdit = [coder decodeIntForKey:@"RecordId"];
    self.savedData = [coder decodeBoolForKey:@"savedData"];
    
    self.lblnameTxt.text = [coder decodeObjectForKey:@"name"];
    self.lbldive1Txt.text = [coder decodeObjectForKey:@"dive1"];
    self.lbldive2Txt.text = [coder decodeObjectForKey:@"dive2"];
    self.lbldive3Txt.text = [coder decodeObjectForKey:@"dive3"];
    self.dive4Txt.text = [coder decodeObjectForKey:@"dive4"];
    self.dive5Txt.text = [coder decodeObjectForKey:@"dive5"];
    self.dive6Txt.text = [coder decodeObjectForKey:@"dive6"];
    self.dive7Txt.text = [coder decodeObjectForKey:@"dive7"];
    self.dive8Txt.text = [coder decodeObjectForKey:@"dive8"];
    self.dive9Txt.text = [coder decodeObjectForKey:@"dive9"];
    self.dive10Txt.text = [coder decodeObjectForKey:@"dive10"];
    self.dive11Txt.text = [coder decodeObjectForKey:@"dive11"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// save the info
- (IBAction)saveInfo:(id)sender {
    
    // here we will send the params to the class to do the update
    QuickScores *quick = [[QuickScores alloc] init];
    if ([quick updateQuickScore:self.recordIDToEdit Name:_nameText Dive1:_dive1 Dive2:_dive2 Dive3:_dive3 Dive4:_dive4 Dive5:_dive5 Dive6:_dive6 Dive7:_dive7 Dive8:_dive8 Dive9:_dive9 Dive10:_dive10 Dive11:_dive11 Total:_scoreTotal]) {
        
        //inform the delegate that the edit was finished and update previous
        //viewcontroller table rows
        [self.delegate editInfoWasFinished];
        
        // pop the view controller
        //[self.navigationController popViewControllerAnimated:YES];
        //[self dismissViewControllerAnimated:YES completion:nil];
        [self performSegueWithIdentifier:@"idSegueEditToQuick" sender:self];
        
    } else {
        //TODO: not sure if I should do some error handling here
    }
}

- (IBAction)btnReturnClick:(id)sender {
    
    [self performSegueWithIdentifier:@"idSegueEditToQuick" sender:self];
}

- (IBAction)diveOneClick:(id)sender {
    
    _textBoxAlert = 1;
    
    [self DiveAlert:_textBoxAlert TextField:self.lbldive1Txt];
    
}

- (IBAction)diveTwoClick:(id)sender {
    
    _textBoxAlert = 2;
    
    [self DiveAlert:_textBoxAlert TextField:self.lbldive2Txt];
    
}

- (IBAction)diveThreeClick:(id)sender {
    
    _textBoxAlert = 3;
    
    [self DiveAlert:_textBoxAlert TextField:self.lbldive3Txt];
    
}

- (IBAction)diveFourClick:(id)sender {
    
    _textBoxAlert = 4;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive4Txt];
    
}

- (IBAction)diveFiveClick:(id)sender {
    
    _textBoxAlert = 5;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive5Txt];
    
}

- (IBAction)diveSixClick:(id)sender {
    
    _textBoxAlert = 6;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive6Txt];
    
}

- (IBAction)diveSevenClick:(id)sender {
    
    _textBoxAlert = 7;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive7Txt];
    
}

- (IBAction)diveEightClick:(id)sender {
    
    _textBoxAlert = 8;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive8Txt];
    
}

- (IBAction)diveNineClick:(id)sender {
    
    _textBoxAlert = 9;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive9Txt];
    
}

- (IBAction)diveTenClick:(id)sender {
    
    _textBoxAlert = 10;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive10Txt];
    
}

- (IBAction)diveElevenClick:(id)sender {
    
    _textBoxAlert = 11;
    
    [self DiveAlert:_textBoxAlert TextField:self.dive11Txt];
    
}

#pragma private methods

- (void)updateTotal {
    // alloc an array and add the labels to it
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [array insertObject:self.lbldive1Txt.text atIndex:0];
    [array insertObject:self.lbldive2Txt.text atIndex:1];
    [array insertObject:self.lbldive3Txt.text atIndex:2];
    [array insertObject:self.dive4Txt.text atIndex:3];
    [array insertObject:self.dive5Txt.text atIndex:4];
    [array insertObject:self.dive6Txt.text atIndex:5];
    [array insertObject:self.dive7Txt.text atIndex:6];
    [array insertObject:self.dive8Txt.text atIndex:7];
    [array insertObject:self.dive9Txt.text atIndex:8];
    [array insertObject:self.dive10Txt.text atIndex:9];
    [array insertObject:self.dive11Txt.text atIndex:10];
    
    // add the labels to the properties, we will use these to add to the DB
    _dive1 = self.lbldive1Txt.text;
    _dive2 = self.lbldive2Txt.text;
    _dive3 = self.lbldive3Txt.text;
    _dive4 = self.dive4Txt.text;
    _dive5 = self.dive5Txt.text;
    _dive6 = self.dive6Txt.text;
    _dive7 = self.dive7Txt.text;
    _dive8 = self.dive8Txt.text;
    _dive9 = self.dive9Txt.text;
    _dive10 = self.dive10Txt.text;
    _dive11 = self.dive11Txt.text;
    
    _nameText = self.lblnameTxt.text;
    
    // calls the class method to add up all the scores
    // and then we format the double to a readable type and
    // put it in the total label
    QuickScores *quick = [[QuickScores alloc] init];
    _totalScore = [quick GetQuickScoreTotal:array];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setMaximumFractionDigits:2];
    [formatter setRoundingMode:NSNumberFormatterRoundUp];
    self.totalTxt.text = [formatter stringFromNumber:[NSNumber numberWithDouble:_totalScore]];
    _scoreTotal = [formatter stringFromNumber:[NSNumber numberWithDouble:_totalScore]];
    
}


//loads a current record to update
-(void)loadInfoToEdit{

    // send the id to the class method to get the results array for the text boxes
    QuickScores *quick  = [[QuickScores alloc] init];
    NSArray *results = [quick loadInfo:self.recordIDToEdit];
    
    if (!self.savedData) {
        // set the data to the correct labels
        self.lblnameTxt.text = [[results objectAtIndex:0] objectAtIndex:1];
        self.lbldive1Txt.text = [[results objectAtIndex:0] objectAtIndex:2];
        self.lbldive2Txt.text = [[results objectAtIndex:0] objectAtIndex:3];
        self.lbldive3Txt.text = [[results objectAtIndex:0] objectAtIndex:4];
        self.dive4Txt.text = [[results objectAtIndex:0] objectAtIndex:5];
        self.dive5Txt.text = [[results objectAtIndex:0] objectAtIndex:6];
        self.dive6Txt.text = [[results objectAtIndex:0] objectAtIndex:7];
        self.dive7Txt.text = [[results objectAtIndex:0] objectAtIndex:8];
        self.dive8Txt.text = [[results objectAtIndex:0] objectAtIndex:9];
        self.dive9Txt.text = [[results objectAtIndex:0] objectAtIndex:10];
        self.dive10Txt.text = [[results objectAtIndex:0] objectAtIndex:11];
        self.dive11Txt.text = [[results objectAtIndex:0] objectAtIndex:12];
        self.totalTxt.text = [[results objectAtIndex:0] objectAtIndex:13];
    }
}

// only allow numbers and two decimal places in the dive score text fields
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSArray *sep = [newString componentsSeparatedByString:@"."];
    if([sep count] >= 2)
    {
        NSString *sepStr=[NSString stringWithFormat:@"%@",[sep objectAtIndex:1]];
        return !([sepStr length]>2);
    }
    return YES;
}

#pragma AlertController Events

// AlertController for the sheet name
- (IBAction)nameClick:(id)sender {
    
    // updated alertController for iOS 8
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Edit Name"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"Enter Sheet Title";
         textField.keyboardAppearance = UIKeyboardAppearanceDark;
         textField.keyboardType = UIKeyboardTypeDefault;
         textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
     }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel Action");
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK Action");
                                   UITextField *name = alertController.textFields.firstObject;
                                   self.lblnameTxt.text = name.text;
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

// AlertController for the dive Numbers
-(void)DiveAlert:(int)diveNumber TextField:(UILabel*)diveText {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:[NSMutableString stringWithFormat:@"Edit Dive %d", diveNumber]
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField)
     {
         textField.placeholder = @"0.0";
         textField.keyboardAppearance = UIKeyboardAppearanceDark;
         textField.keyboardType = UIKeyboardTypeDecimalPad;
         // add the text field delegate here
         textField.delegate = self;
     }];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel Action");
                                   }];
    
    UIAlertAction *okAction = [UIAlertAction
                               actionWithTitle:@"OK"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action)
                               {
                                   NSLog(@"OK Action");
                                   UITextField *score = alertController.textFields.firstObject;
                                    diveText.text = score.text;
                                   [self updateTotal];
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
