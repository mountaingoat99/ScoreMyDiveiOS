//
//  DiveEnter.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/26/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveEnter.h"
#import "JudgeScores.h"
#import "Meet.h"
#import "Diver.h"
#import "DiverBoardSize.h"
#import "DiveTotal.h"
#import "DiveListScore.h"
#import "DiveListFinalScore.h"
#import "Results.h"
#import "MeetCollection.h"
#import "ChooseDiver.h"
#import "DiveNumberCheck.h"
#import "ChooseDiveNumberEnter.h"
#import "TypeDiveNumberEnter.h"
#import "SwitchDiver.h"

@interface DiveEnter ()

@property (nonatomic, strong) NSNumber *onDiveNumber;
@property (nonatomic) int maxDiveNumber;
@property (nonatomic, strong) NSNumber *editDiveNumber;
@property (nonatomic, strong) NSNumber *boardSize;
@property (nonatomic, strong) NSNumber *multiplier;
@property (nonatomic) BOOL allDivesEntered;
@property (nonatomic) int diveTotal;
@property (nonatomic, strong) NSNumber *scoreTotal;

@property (nonatomic, strong) NSString *diveCategory;
@property (nonatomic, strong) NSString *divePosition;
@property (nonatomic, strong) NSString *diveNameForDB;
@property (nonatomic, strong) NSNumber *multiplierToSend;
@property (nonatomic) int listOrNot;

-(void)LoadMeetCollection;
-(void)getTheDiveTotal;
-(void)fillText;
-(void)DiverBoardSize;
-(void)fillDiveNumber;
-(void)fillDiveInfo;
-(void)hideInitialControls;
-(void)checkFinishedScoring;
-(void)ShowScoreTotal:(NSNumber*)scoretotal;

@end

@implementation DiveEnter

#pragma  view controller methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundPanel1.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backgroundPanel1.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.backgroundPanel1.layer.masksToBounds = NO;
    self.backgroundPanel1.layer.shadowOpacity = 1.0;
    
    self.backgroundPanel2.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backgroundPanel2.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.backgroundPanel2.layer.masksToBounds = NO;
    self.backgroundPanel2.layer.shadowOpacity = 1.0;
    
    self.backgroundPanel3.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backgroundPanel3.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.backgroundPanel3.layer.masksToBounds = NO;
    self.backgroundPanel3.layer.shadowOpacity = 1.0;
    
    // sets up the following delegate method to disable horizontal scrolling
    // don't forget to declare the UIScrollViewDelegate in the .h file
    self.scrollView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self LoadMeetCollection];
    [self getTheDiveTotal];
    [self hideInitialControls];
    [self fillDiveNumber];
    [self fillText];
    [self DiverBoardSize];
    [self fillDiveInfo];
    [self checkFinishedScoring];
}

// only allow portrait in iphone
-(BOOL)shouldAutorotate {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

// restore state because Apple doesn't know how to write a modern OS
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    [super encodeRestorableStateWithCoder:coder];
    
    [coder encodeInt:self.meetRecordID forKey:@"meetId"];
    [coder encodeInt:self.diverRecordID forKey:@"diverId"];
    [coder encodeObject:self.meetInfo forKey:@"meetInfo"];
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    [super decodeRestorableStateWithCoder:coder];
    
    self.meetRecordID = [coder decodeIntForKey:@"meetId"];
    self.diverRecordID = [coder decodeIntForKey:@"diverId"];
    self.meetInfo = [coder decodeObjectForKey:@"meetInfo"];
}

// stops horitontal scrolling
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToEnterDive:(UIStoryboardSegue*)sender {
    
    [self LoadMeetCollection];
    [self hideInitialControls];
    [self fillDiveNumber];
    [self fillText];
    [self DiverBoardSize];
    [self fillDiveInfo];
}

// push id to the next view controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // send to the Choose Dive
    if ([segue.identifier isEqualToString:@"idSegueEnterToChooseDive"]) {
        
        ChooseDiveNumberEnter *score = [segue destinationViewController];
        
        self.listOrNot = 1;
        score.listOrNot = self.listOrNot;
        score.boardSize = self.boardSize;
        score.meetRecordID = self.meetRecordID;
        score.diverRecordID = self.diverRecordID;
        score.onDiveNumber = self.onDiveNumber;
        score.meetInfo = self.meetInfo;
    }
    
    // send to the TypeDive
    if ([segue.identifier isEqualToString:@"idSegueEnterToType"]) {
        
        TypeDiveNumberEnter *score = [segue destinationViewController];
        
        self.listOrNot = 1;
        score.listOrNot = self.listOrNot;
        score.boardSize = self.boardSize;
        score.meetRecordID = self.meetRecordID;
        score.diverRecordID = self.diverRecordID;
        score.onDiveNumber = self.onDiveNumber;
        score.meetInfo = self.meetInfo;
    }
    
    // send to the diveListScore for Edit
    if ([segue.identifier isEqualToString:@"idEnterDivetoEditJudgeScores"]) {
        
        DiveListScore *score = [segue destinationViewController];
        
        self.listOrNot = 2;
        score.listOrNot = self.listOrNot;
        score.meetRecordID = self.meetRecordID;
        score.diverRecordID = self.diverRecordID;
        score.diveNumber = [self.onDiveNumber intValue];
        score.meetInfo = self.meetInfo;
    }
    
    // send to the diveListFinalScore for Edit
    if ([segue.identifier isEqualToString:@"idEnterDiveToEditFinalScore"]) {
        
        DiveListFinalScore *score = [segue destinationViewController];
        
        self.listOrNot = 2;
        score.listOrNot = self.listOrNot;
        score.meetRecordID = self.meetRecordID;
        score.diverRecordID = self.diverRecordID;
        score.diveNumber = [self.onDiveNumber intValue];  //TODO: we need to make sure this is correct?
        score.meetInfo = self.meetInfo;
    }
    
    if([segue.identifier isEqualToString:@"idSegueEnterToChooseDiver"]) {
        
        ChooseDiver *choose = [segue destinationViewController];
        choose.meetRecordID = self.meetRecordID;
    }
    
    if([segue.identifier isEqualToString:@"SegueEnterToSwitch"]) {
        
        SwitchDiver *switchDiver = [segue destinationViewController];
        
        switchDiver.meetRecordID = self.meetRecordID;
        switchDiver.diverRecordID = self.diverRecordID;
        switchDiver.meetInfo = self.meetInfo;
    }
}

- (IBAction)lblOptionsClick:(id)sender {
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Edit a Score"
                                                    message:@"To edit a score just long-press the score for the dive you want to edit."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [error show];
    [error reloadInputViews];
}

- (IBAction)Dive1EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                   actionWithTitle:@"Edit Judge Scores"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Judges Action");
                                       // send to the DiveListScore
                                       self.onDiveNumber = @1;
                                       [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                      
                                   }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @1;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover) {
            popover.sourceView = self.view;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
}

- (IBAction)Dive2EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @2;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @2;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover) {
            popover.sourceView = self.view;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
}

- (IBAction)Dive3EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @3;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @3;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover) {
            popover.sourceView = self.view;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
}

- (IBAction)Dive4EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @4;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @4;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover) {
            popover.sourceView = self.view;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
}

- (IBAction)Dive5EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @5;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @5;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover) {
            popover.sourceView = self.view;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
}

- (IBAction)Dive6EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @6;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @6;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover) {
            popover.sourceView = self.view;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
}

- (IBAction)Dive7EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @7;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @7;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover) {
            popover.sourceView = self.view;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
}

- (IBAction)Dive8EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @8;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @8;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover) {
            popover.sourceView = self.view;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
}

- (IBAction)Dive9EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @9;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @9;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover) {
            popover.sourceView = self.view;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
}

- (IBAction)Dive10EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @10;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @10;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover) {
            popover.sourceView = self.view;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
}

- (IBAction)Dive11EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        // updated alertController for iOS 8
        UIAlertController *alertController = [UIAlertController
                                              alertControllerWithTitle:@"Edit Scores"
                                              message:nil
                                              preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction
                                       actionWithTitle:@"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction *action)
                                       {
                                           NSLog(@"Cancel Action");
                                       }];
        
        UIAlertAction *JudgeScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Judge Scores"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action)
                                           {
                                               NSLog(@"Judges Action");
                                               // send to the DiveListScore
                                               self.onDiveNumber = @11;
                                               [self performSegueWithIdentifier:@"idEnterDivetoEditJudgeScores" sender:self];
                                               
                                           }];
        
        UIAlertAction *finalScoreAction = [UIAlertAction
                                           actionWithTitle:@"Edit Final Score"
                                           style:UIAlertActionStyleDefault
                                           handler:^(UIAlertAction *action) {
                                               
                                               NSLog(@"FinalScore Action");
                                               // send to the DiveFinalListScore
                                               self.onDiveNumber = @11;
                                               [self performSegueWithIdentifier:@"idEnterDiveToEditFinalScore" sender:self];
                                               
                                           }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:JudgeScoreAction];
        [alertController addAction:finalScoreAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = alertController.popoverPresentationController;
        if (popover) {
            popover.sourceView = self.view;
            popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        }
    }
}

#pragma private methods

-(void)LoadMeetCollection {
    
    MeetCollection *meets = [[MeetCollection alloc] init];
    self.meetInfo = [meets GetMeetAndDiverInfo:self.meetRecordID diverid:self.diverRecordID];
}

-(void)getTheDiveTotal {
    
    DiveTotal *total = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:2];
    self.diveTotal = [total.diveTotal intValue];
}

-(void)fillText {
    
    // meet info
    Meet *meet = [self.meetInfo objectAtIndex:0];
    self.lblMeetName.text = meet.meetName;
    
    // diver info
    Diver *diver = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:0];
    self.lblDiverName.text = diver.Name;
}

-(void)DiverBoardSize {
    
    DiverBoardSize *board = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:4];
    
    self.boardSize = board.firstSize;
    
    NSNumber *boardSize = board.firstSize;
    
    NSString *boardSizeText = [boardSize stringValue];
    
    boardSizeText = [boardSizeText stringByAppendingString:@" Meter"];
    
    self.lblBoardType.text = boardSizeText;
    
}

-(void)fillDiveNumber {
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    self.maxDiveNumber = [scores GetMaxDiveNumber:self.meetRecordID diverid:self.diverRecordID];
    
    // we need to see what the dive total is first and set it for the whole class
    DiveTotal *total = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:2];
    self.diveTotal = [total.diveTotal intValue];
    
    NSString *diveNum = @"Dive ";
    // here we will set the value for the whole class to use
    self.onDiveNumber = [NSNumber numberWithInt:self.maxDiveNumber + 1];
    
    diveNum = [diveNum stringByAppendingString:[NSString stringWithFormat:@"%@", self.onDiveNumber]];
    self.lblDiveNumber.text = diveNum;
    
}

-(void)fillDiveInfo {
    
    // text for the label
    NSString *diveInfoText;
    
    //result object for the label
    JudgeScores *diveInfo = [[JudgeScores alloc] init];
    
    // for checking a failed dive
    JudgeScores *failInfo = nil;
    NSString *failedDive;
    
    // lets get the results from the meetcollection object for the whole method to use
    Results *score = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:5];
    
    if (self.maxDiveNumber >= 1) {
        
        // getting the failed check out of the meet collection object
        failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:0];
        failedDive = failInfo.failed;
        if ([failedDive isEqualToString:@"1"]) {
            diveInfoText = @"Failed - ";
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:1]];
        } else {
            // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
            double scoreDouble = [score.dive1 doubleValue];
            diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
            diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:1]];
        }
        
        self.lblDive1.text = diveInfoText;
        //[self.backgroundPanel3 setHidden:NO];
        [self.lblDive1 setHidden:NO];
        [self.lblDive1text setHidden:NO];
        [self.label1 setHidden:NO];
        [self.view1 setUserInteractionEnabled:YES];
        
    }
    
    if (self.maxDiveNumber >= 2) {
        
        // getting the failed check out of the meet collection object
        failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:1];
        failedDive = failInfo.failed;
        if ([failedDive isEqualToString:@"1"]) {
            diveInfoText = @"Failed - ";
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:2]];
        } else {
            // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
            double scoreDouble = [score.dive2 doubleValue];
            diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
            diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:2]];
        }
        
        self.lblDive2.text = diveInfoText;
        [self.lblDive2 setHidden:NO];
        [self.lblDive2text setHidden:NO];
        [self.label2 setHidden:NO];
        [self.view2 setUserInteractionEnabled:YES];
        
    }
    
    if (self.maxDiveNumber >= 3) {
        
        // getting the failed check out of the meet collection object
        failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:2];
        failedDive = failInfo.failed;
        if ([failedDive isEqualToString:@"1"]) {
            diveInfoText = @"Failed - ";
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:3]];
        } else {
            // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
            double scoreDouble = [score.dive3 doubleValue];
            diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
            diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:3]];
        }
        
        self.lblDive3.text = diveInfoText;
        [self.lblDive3 setHidden:NO];
        [self.lblDive3text setHidden:NO];
        [self.label3 setHidden:NO];
        [self.view3 setUserInteractionEnabled:YES];
        
    }
    
    if (self.maxDiveNumber >= 4) {
        
        // getting the failed check out of the meet collection object
        failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:3];
        failedDive = failInfo.failed;
        if ([failedDive isEqualToString:@"1"]) {
            diveInfoText = @"Failed - ";
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:4]];
        } else {
            // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
            double scoreDouble = [score.dive4 doubleValue];
            diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
            diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:4]];
        }
        
        self.lblDive4.text = diveInfoText;
        [self.lblDive4 setHidden:NO];
        [self.lblDive4text setHidden:NO];
        [self.label4 setHidden:NO];
        [self.view4 setUserInteractionEnabled:YES];
        
    }
    
    if (self.maxDiveNumber >= 5) {
        
        // getting the failed check out of the meet collection object
        failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:4];
        failedDive = failInfo.failed;
        if ([failedDive isEqualToString:@"1"]) {
            diveInfoText = @"Failed - ";
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:5]];
        } else {
            // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
            double scoreDouble = [score.dive5 doubleValue];
            diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
            diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:5]];
        }
        
        self.lblDive5.text = diveInfoText;
        [self.lblDive5 setHidden:NO];
        [self.lblDive5text setHidden:NO];
        [self.label5 setHidden:NO];
        [self.view5 setUserInteractionEnabled:YES];
        
    }
    
    if (self.maxDiveNumber >= 6) {
        
        // getting the failed check out of the meet collection object
        failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:5];
        failedDive = failInfo.failed;
        if ([failedDive isEqualToString:@"1"]) {
            diveInfoText = @"Failed - ";
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:6]];
        } else {
            // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
            double scoreDouble = [score.dive6 doubleValue];
            diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
            diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
            diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:6]];
        }
        
        self.lblDive6.text = diveInfoText;
        [self.lblDive6 setHidden:NO];
        [self.lblDive6text setHidden:NO];
        [self.label6 setHidden:NO];
        [self.view6 setUserInteractionEnabled:YES];
    }
    
    // we won't even bother checking these unless the diveTotal is 11
    if (self.diveTotal == 11) {
        if (self.maxDiveNumber >= 7) {
            
            // getting the failed check out of the meet collection object
            failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:6];
            failedDive = failInfo.failed;
            if ([failedDive isEqualToString:@"1"]) {
                diveInfoText = @"Failed - ";
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:7]];
            } else {
                // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
                double scoreDouble = [score.dive7 doubleValue];
                diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
                diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:7]];
            }
            
            self.lblDive7.text = diveInfoText;
            [self.lblDive7 setHidden:NO];
            [self.lblDive7text setHidden:NO];
            [self.label7 setHidden:NO];
            [self.view7 setUserInteractionEnabled:YES];
            
        }
        
        if (self.maxDiveNumber >= 8) {
            
            // getting the failed check out of the meet collection object
            failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:7];
            failedDive = failInfo.failed;
            if ([failedDive isEqualToString:@"1"]) {
                diveInfoText = @"Failed - ";
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:8]];
            } else {
                // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
                double scoreDouble = [score.dive8 doubleValue];
                diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
                diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:8]];
            }
            
            self.lblDive8.text = diveInfoText;
            [self.lblDive8 setHidden:NO];
            [self.lblDive8text setHidden:NO];
            [self.label8 setHidden:NO];
            [self.view8 setUserInteractionEnabled:YES];
            
        }
        
        if (self.maxDiveNumber >= 9) {
            
            // getting the failed check out of the meet collection object
            failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:8];
            failedDive = failInfo.failed;
            if ([failedDive isEqualToString:@"1"]) {
                diveInfoText = @"Failed - ";
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:9]];
            } else {
                // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
                double scoreDouble = [score.dive9 doubleValue];
                diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
                diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:9]];
            }
            
            self.lblDive9.text = diveInfoText;
            [self.lblDive9 setHidden:NO];
            [self.lblDive9text setHidden:NO];
            [self.label9 setHidden:NO];
            [self.view9 setUserInteractionEnabled:YES];
            
        }
        
        if (self.maxDiveNumber >= 10) {
            
            // getting the failed check out of the meet collection object
            failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:9];
            failedDive = failInfo.failed;
            if ([failedDive isEqualToString:@"1"]) {
                diveInfoText = @"Failed - ";
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:10]];
            } else {
                // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
                double scoreDouble = [score.dive10 doubleValue];
                diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
                diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:10]];
            }
            
            self.lblDive10.text = diveInfoText;
            [self.lblDive10 setHidden:NO];
            [self.lblDive10text setHidden:NO];
            [self.label10 setHidden:NO];
            [self.view10 setUserInteractionEnabled:YES];
        }
        
        if (self.maxDiveNumber >= 11) {
            
            // getting the failed check out of the meet collection object
            failInfo = [[[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:6] objectAtIndex:10];
            failedDive = failInfo.failed;
            if ([failedDive isEqualToString:@"1"]) {
                diveInfoText = @"Failed - ";
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:11]];
            } else {
                // ObjectiveC data types suck, here we convert it to a double, then back to a NSNumber
                double scoreDouble = [score.dive11 doubleValue];
                diveInfoText = [NSString stringWithFormat:@"%.2f", scoreDouble];
                diveInfoText = [diveInfoText stringByAppendingString:@" Points - "];
                diveInfoText = [diveInfoText stringByAppendingString:[diveInfo GetName:self.meetRecordID diverid:self.diverRecordID divenumber:11]];
            }
            
            self.lblDive11.text = diveInfoText;
            [self.lblDive11 setHidden:NO];
            [self.lblDive11text setHidden:NO];
            [self.label11 setHidden:NO];
            [self.view11 setUserInteractionEnabled:YES];
        }
    }
    
    // sets the score total
    [self ShowScoreTotal:score.totalScoreTotal];
}

-(void)ShowScoreTotal:(NSNumber*)scoretotal {
    
    if (![scoretotal isEqual:@0]) {
        
        // have to do an idiodic convert to double, round and convert back to number because
        // of the insane apple datatypes
        double total = [scoretotal doubleValue];
        
        self.scoreTotal = scoretotal;
        self.lblTotalScore.text = [NSString stringWithFormat:@"%.2f", total];
        
    } else {
        self.lblTotalScore.text = @"0.0";
    }
}

-(void)checkFinishedScoring {
    
    if (self.diveTotal == self.maxDiveNumber) {
        
        self.lblDiveNumber.text = @"Complete";
        [self.btnEnterScore setEnabled:NO];
        [self.btnEnterTotalScore setEnabled:NO];
        [self.btnEnterScore setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.btnEnterTotalScore setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.lblDiveNumber.text = @"Finished";
    }
}

-(void)hideInitialControls {
    
    [self.lblDive1 setHidden:YES];
    [self.lblDive2 setHidden:YES];
    [self.lblDive3 setHidden:YES];
    [self.lblDive4 setHidden:YES];
    [self.lblDive5 setHidden:YES];
    [self.lblDive6 setHidden:YES];
    [self.lblDive7 setHidden:YES];
    [self.lblDive8 setHidden:YES];
    [self.lblDive9 setHidden:YES];
    [self.lblDive10 setHidden:YES];
    [self.lblDive11 setHidden:YES];
    [self.lblDive1text setHidden:YES];
    [self.lblDive2text setHidden:YES];
    [self.lblDive3text setHidden:YES];
    [self.lblDive4text setHidden:YES];
    [self.lblDive5text setHidden:YES];
    [self.lblDive6text setHidden:YES];
    [self.lblDive7text setHidden:YES];
    [self.lblDive8text setHidden:YES];
    [self.lblDive9text setHidden:YES];
    [self.lblDive10text setHidden:YES];
    [self.lblDive11text setHidden:YES];
    [self.label1 setHidden:YES];
    [self.label2 setHidden:YES];
    [self.label3 setHidden:YES];
    [self.label4 setHidden:YES];
    [self.label5 setHidden:YES];
    [self.label6 setHidden:YES];
    [self.label7 setHidden:YES];
    [self.label8 setHidden:YES];
    [self.label9 setHidden:YES];
    [self.label10 setHidden:YES];
    [self.label11 setHidden:YES];
    [self.view1 setUserInteractionEnabled:NO];
    [self.view2 setUserInteractionEnabled:NO];
    [self.view3 setUserInteractionEnabled:NO];
    [self.view4 setUserInteractionEnabled:NO];
    [self.view5 setUserInteractionEnabled:NO];
    [self.view6 setUserInteractionEnabled:NO];
    [self.view7 setUserInteractionEnabled:NO];
    [self.view8 setUserInteractionEnabled:NO];
    [self.view9 setUserInteractionEnabled:NO];
    [self.view10 setUserInteractionEnabled:NO];
    [self.view11 setUserInteractionEnabled:NO];
}

@end
