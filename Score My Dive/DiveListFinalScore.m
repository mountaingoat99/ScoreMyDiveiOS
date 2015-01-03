//
//  DiveListFinalScore.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveListFinalScore.h"
#import "DiveListChoose.h"
#import "JudgeScores.h"
#import "Results.h"
#import "DiveNumber.h"
#import "DiverBoardSize.h"
#import "DiveEnter.h"
#import "DiveList.h"

@interface DiveListFinalScore ()

@property (nonatomic, strong) NSNumber *totalScore;
@property (nonatomic, strong) NSNumber *boardSize;

-(void)DiveText;
-(BOOL)CalcScores;
-(BOOL)updateFailedDive;
-(void)DiverBoardSize;

@end

@implementation DiveListFinalScore

#pragma viewcontroller methods

- (void)viewDidLoad {
    [super viewDidLoad];

    self.txtTotalScore.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtTotalScore.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtTotalScore.layer.masksToBounds = NO;
    self.txtTotalScore.layer.shadowRadius = 4.0f;
    self.txtTotalScore.layer.shadowOpacity = .3;
    self.txtTotalScore.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0);
    self.txtTotalScore.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtTotalScore.keyboardType = UIKeyboardTypeDecimalPad;
    self.txtTotalScore.delegate = self;
    
    self.btnTotal.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnTotal.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnTotal.layer.masksToBounds = NO;
    self.btnTotal.layer.shadowOpacity = .7;
    
    [self DiveText];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// hide the Keyboard on outside touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"idSegueFinalListToListChoose"]) {
        
        DiveListChoose *choose = [segue destinationViewController];
        
        choose.diverRecordID = self.diverRecordID;
        choose.meetRecordID = self.meetRecordID;
        
    }
    
    if ([segue.identifier isEqualToString:@"idListFinalScoreToDiveEnter"]) {
        
        DiveEnter *choose = [segue destinationViewController];
        
        choose.diverRecordID = self.diverRecordID;
        choose.meetRecordID = self.meetRecordID;
        
    }
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (!string.length)
        return YES;
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *expression = @"^([0-9]{1,3}+)?(\\.([0-9]{1,2})?)?$";
    NSError *error = nil;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString options:0 range:NSMakeRange(0, [newString length])];
    if (numberOfMatches == 0) return NO;
    return YES;
}

- (IBAction)btnTotalClick:(id)sender {
    
    bool good;
    
    if (self.txtTotalScore.text.length > 0) {
        
        if ((good = [self CalcScores])) {
            
            // here we need to test the self.listOrNot and see who sent us, then return to them
            if (self.listOrNot == 0) {
                [self performSegueWithIdentifier:@"idSegueFinalListToListChoose" sender:self];
            } else {
                [self performSegueWithIdentifier:@"idListFinalScoreToDiveEnter" sender:self];
            }
            
            
        } else {
            
            UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                            message:@"Score was not valid, please try again"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [error show];
            [error reloadInputViews];
            
        }
        
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"You forgot to enter the score"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

- (IBAction)btnFailedClick:(id)sender {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Fail Dive!"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleAlert];
    
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
                                   
                                   bool good;
                                   
                                   if ((good = [self updateFailedDive])) {
                                       
                                       // here we need to test the self.listOrNot and see who sent us, then return to them
                                       if (self.listOrNot == 0) {
                                           [self performSegueWithIdentifier:@"idSegueFinalListToListChoose" sender:self];
                                       } else {
                                           [self performSegueWithIdentifier:@"idListFinalScoreToDiveEnter" sender:self];
                                       }
                                       
                                   } else {
                                       
                                       UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                                                       message:@"Dive couldn't be failed, please try again"
                                                                                      delegate:nil
                                                                             cancelButtonTitle:@"OK"
                                                                             otherButtonTitles:nil];
                                       [error show];
                                       [error reloadInputViews];
                                   }
                               }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
}

- (IBAction)btnReturnClick:(id)sender {
    
    if (self.listOrNot == 0) {
        [self performSegueWithIdentifier:@"idSegueFinalListToListChoose" sender:self];
    } else {
        [self performSegueWithIdentifier:@"idListFinalScoreToDiveEnter" sender:self];
    }
}

#pragma private methods

-(void)DiveText {
    
    if (self.listOrNot == 1) {
        
        NSRange dash;
        NSString *diveName;
        NSString *divePos;
        
        //now lets parse the diveNumber out of the dive
        dash = [self.diveNameForDB rangeOfString:@"-"];
        if (dash.location != NSNotFound) {
            diveName = [self.diveNameForDB substringWithRange:NSMakeRange(0, (dash.location - 1))];
        }
        // now parse the dive Position
        dash = [self.divePosition rangeOfString:@"-"];
        if (dash.location != NSNotFound) {
            divePos = [self.divePosition substringWithRange:NSMakeRange(0, (dash.location - 1))];
        }
        
        NSString *divetype = self.diveCategory;
        divetype = [divetype stringByAppendingString:@" - "];
        divetype = [divetype stringByAppendingString:diveName];
        divetype = [divetype stringByAppendingString:divePos];
        divetype = [divetype stringByAppendingString:@" - DD: "];
        divetype = [divetype stringByAppendingString:[self.multiplierToSend stringValue]];
        self.lbldiveType.text = divetype;
        
    } else {
    
        JudgeScores *scores = [[JudgeScores alloc] init];
        self.lbldiveType.text = [scores GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:self.diveNumber];
    }
    
    NSString *diveNumberString = @"Score Dive ";
    
    diveNumberString = [diveNumberString stringByAppendingString:[NSString stringWithFormat:@"%d", self.diveNumber]];
    
    self.lblDiveNumber.text = diveNumberString;
    
}

-(BOOL)CalcScores {
    
    BOOL validJudgeScoreInsert;
    BOOL validResultsInsert = false;
    BOOL validDiveNumberIncrement = false;
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    // if not a dive list we need to write the dive record first then update the score
    if (self.listOrNot == 1) {
        
        if (self.diveNumber == 1) {
            
            //convert the dive Number to nsnumber
            NSNumber *diveNumberNumber = [NSNumber numberWithInt:self.diveNumber];
            
            //update record
            [scores UpdateJudgeScoreTypes:self.meetRecordID diverid:self.diverRecordID divecat:self.diveCategory divetype:self.diveNameForDB divepos:self.divePosition  multiplier:self.multiplierToSend oldDiveNumber:@0 divenumber:diveNumberNumber];
            
            DiveList *list = [[DiveList alloc] init];
            [list MarkNoList:self.meetRecordID diverid:self.diverRecordID];
            
        } else {
            
            //convert the dive Number to nsnumber
            NSNumber *diveNumberNumber = [NSNumber numberWithInt:self.diveNumber];
            //convert the board size to a double
            double boardSizeDouble = [self.boardSize doubleValue];
            
            //create record
            [scores CreateJudgeScores:self.meetRecordID diverid:self.diverRecordID boardsize:boardSizeDouble divenumber:diveNumberNumber divecategory:self.diveCategory divetype:self.diveNameForDB diveposition:self.divePosition failed:@0 multiplier:self.multiplierToSend totalscore:@0 score1:@0 score2:@0 score3:@0 score4:@0 score5:@0 score6:@0 score7:@0];
        }
    }
    
    self.totalScore = @([self.txtTotalScore.text doubleValue]);
    
    validJudgeScoreInsert = [scores UpdateJudgeAllScores:self.meetRecordID diverid:self.diverRecordID divenumber:self.diveNumber totalscore:self.totalScore score1:@0 score2:@0 score3:@0 score4:@0 score5:@0 score6:@0 score7:@0];
    
    if (validJudgeScoreInsert) {
        //update the results table
        Results *result = [[Results alloc] init];
        validResultsInsert = [result UpdateOneResult:self.meetRecordID DiverID:self.diverRecordID DiveNumber:self.diveNumber score:self.totalScore];
    }
    
    if (validJudgeScoreInsert && validResultsInsert) {
        // increment the dive number in the dive_number table
        DiveNumber *number = [[DiveNumber alloc] init];
        validDiveNumberIncrement = [number UpdateDiveNumber:self.meetRecordID diverid:self.diverRecordID divenumber:self.diveNumber];
    }
    
    // now make sure everything was updated correctly
    if (validJudgeScoreInsert && validResultsInsert && validDiveNumberIncrement) {
        return true;
    } else {
        return false;
    }
}

-(BOOL)updateFailedDive {
    
    //lets create some bools yo!
    BOOL validJudgeScoreInsert;
    BOOL validResultsInsert;
    BOOL validDiveNumberIncrement;
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    // if not a dive list we need to write the dive record first then update the score
    if (self.listOrNot == 1) {
        
        if (self.diveNumber == 1) {
            
            //convert the dive Number to nsnumber
            NSNumber *diveNumberNumber = [NSNumber numberWithInt:self.diveNumber];
            
            //update record
            [scores UpdateJudgeScoreTypes:self.meetRecordID diverid:self.diverRecordID divecat:self.diveCategory divetype:self.diveNameForDB divepos:self.divePosition  multiplier:self.multiplierToSend oldDiveNumber:diveNumberNumber divenumber:diveNumberNumber];
            
            DiveList *list = [[DiveList alloc] init];
            [list MarkNoList:self.meetRecordID diverid:self.diverRecordID];
            
        } else {
            
            //convert the dive Number to nsnumber
            NSNumber *diveNumberNumber = [NSNumber numberWithInt:self.diveNumber];
            //convert the board size to a double
            double boardSizeDouble = [self.boardSize doubleValue];
            
            //create record
            [scores CreateJudgeScores:self.meetRecordID diverid:self.diverRecordID boardsize:boardSizeDouble divenumber:diveNumberNumber divecategory:self.diveCategory divetype:self.diveNameForDB diveposition:self.divePosition failed:@0 multiplier:self.multiplierToSend totalscore:@0 score1:@0 score2:@0 score3:@0 score4:@0 score5:@0 score6:@0 score7:@0];
        }
    }
    
    validJudgeScoreInsert = [scores UpdateJudgeAllScoresFailed:self.meetRecordID diverid:self.diverRecordID divenumber:self.diveNumber failed:@1 totalscore:@0 score1:@0 score2:@0 score3:@0 score4:@0 score5:@0 score6:@0 score7:@0];
    
    //update the results table
    Results *result = [[Results alloc] init];
    validResultsInsert = [result UpdateOneResult:self.meetRecordID DiverID:self.diverRecordID DiveNumber:self.diveNumber score:@0];
    
    // increment the dive number in the dive_number table
    DiveNumber *number = [[DiveNumber alloc] init];
    validDiveNumberIncrement = [number UpdateDiveNumber:self.meetRecordID diverid:self.diverRecordID divenumber:self.diveNumber];
    
    // now make sure everything was updated correctly
    if (validJudgeScoreInsert && validResultsInsert && validDiveNumberIncrement) {
        return true;
    } else {
        return false;
    }
}

-(void)DiverBoardSize {
    
    DiverBoardSize *board = [[DiverBoardSize alloc] init];
    
    board = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:4];
    
    self.boardSize = board.firstSize;
    
}

@end
