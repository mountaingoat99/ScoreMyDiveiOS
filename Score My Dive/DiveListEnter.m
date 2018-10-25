//
//  DiveListEnter.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveListEnter.h"
#import "Diver.h"
#import "Meet.h"
#import "DiveTotal.h"
#import "DiverBoardSize.h"
#import "DiveCategory.h"
#import "DiveTypes.h"
#import "DiveNumber.h"
#import "JudgeScores.h"
#import "DiveListChoose.h"
#import "DiveList.h"
#import "ChooseDiver.h"
#import "DiveNumberCheck.h"
#import "TypeDiveNumber.h"
#import "ChooseDiveNumber.h"
#import "SwitchDiver.h"
#import "WYPopoverController.h"
#import "AppDelegate.h"
#import "AlertControllerHelper.h"

@interface DiveListEnter () <WYPopoverControllerDelegate>
{
    WYPopoverController* popoverController;
}

@property (nonatomic, strong) NSNumber *onDiveNumber;
@property (nonatomic) int maxDiveNumber;
@property (nonatomic, strong) NSNumber *editDiveNumber;
@property (nonatomic, strong) NSNumber *boardSize;
@property (nonatomic, strong) NSNumber *multiplier;
@property (nonatomic) BOOL allDivesEntered;
@property (nonatomic, strong) NSString *oldDiveName;
@property (nonatomic) int diveTotal;

// new good methods
-(void)EnableStartMeet;
-(void)fillText;
-(void)DiverBoardSize;
-(void)fillDiveNumber;
-(void)fillDiveInfo;
-(void)hideInitialControls;
-(void)updateListFilled;
-(void)updateListStarted;
-(void)editDiverPopup;
-(void)editTypeNumber;
-(void)editChooseNumber;

@end

@implementation DiveListEnter

@synthesize popoverContr;

#pragma ViewController Events

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self restrictRotation:YES];
    
    
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // lets hide some controls
    [self hideInitialControls];
    [self fillDiveNumber];
    [self fillText];
    [self DiverBoardSize];
    [self fillDiveInfo];
    [self EnableStartMeet];
}

// only allow portrait in iphone
-(void) restrictRotation:(BOOL) restriction
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.restrictRotation = restriction;
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

// push id to the next view controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"idSegueDiveListChoose"]) {
        
        DiveListChoose *choose = [segue destinationViewController];
        choose.meetRecordID = self.meetRecordID;
        choose.diverRecordID = self.diverRecordID;
        choose.boardSize = self.boardSize;
    }
    
    if([segue.identifier isEqualToString:@"idSegueListToChooseDiver"]) {
        
        ChooseDiver *choose = [segue destinationViewController];
        choose.meetRecordID = self.meetRecordID;
    }
}

- (IBAction)btnEnterDive:(id)sender {
    
    if (self.allDivesEntered) {
        
        [self performSegueWithIdentifier:@"idSegueDiveListChoose" sender:self];
        
    } else {
        
        [AlertControllerHelper ShowAlert:@"Hold On!" message:@"You need to enter all the dives in the list first" view:self];
        
    }
}

- (IBAction)lblOptionsClick:(id)sender {
    
    [AlertControllerHelper ShowAlert:@"Edit Dive" message:@"To edit a Dive-List entry, just long-press the dive-name that you want to edit" view:self];
}

- (IBAction)btnSwitchDiver:(id)sender {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        UIStoryboard *sboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SwitchDiver *switchDiver = [sboard instantiateViewControllerWithIdentifier:@"SwitchDiver"];
        
        popoverController = [[WYPopoverController alloc] initWithContentViewController:switchDiver];
        popoverController.delegate = self;
        popoverController.popoverContentSize = CGSizeMake(300, 300);
        switchDiver.meetRecordID = self.meetRecordID;
        switchDiver.diverRecordID = self.diverRecordID;
        switchDiver.meetInfo = self.meetInfo;
        [popoverController presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:WYPopoverArrowDirectionNone animated:YES];
        
    } else {
    
        UIStoryboard *sboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SwitchDiver *switchDiver = [sboard instantiateViewControllerWithIdentifier:@"SwitchDiver"];
        
        switchDiver.meetRecordID = self.meetRecordID;
        switchDiver.diverRecordID = self.diverRecordID;
        switchDiver.meetInfo = self.meetInfo;
        switchDiver.preferredContentSize = CGSizeMake(400, 400);
        switchDiver.popoverPresentationController.sourceView = self.view;
        switchDiver.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionAny;
        popoverContr = [switchDiver popoverPresentationController];
        popoverContr.delegate = self;
        [self presentViewController:switchDiver animated:YES completion:nil];
        
    }
}

- (IBAction)btnTypeNumber:(id)sender {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        UIStoryboard *sboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TypeDiveNumber *enter = [sboard instantiateViewControllerWithIdentifier:@"TypeDiveNumber"];
        
        popoverController = [[WYPopoverController alloc] initWithContentViewController:enter];
        popoverController.delegate = self;
        popoverController.popoverContentSize = CGSizeMake(250, 145);
        enter.delegate = self;
        // pass the instance of the custom class to the next class to dismiss it
        // need to declare this in the h file and then call dismissPopverAnimated on it
        enter.controller = popoverController;
        enter.boardSize = self.boardSize;
        enter.meetRecordID = self.meetRecordID;
        enter.diverRecordID = self.diverRecordID;
        enter.maxDiveNumber = self.maxDiveNumber;
        enter.onDiveNumber = self.onDiveNumber;
        enter.meetInfo = self.meetInfo;
        enter.whoCalled = 1;
        [popoverController presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:WYPopoverArrowDirectionNone animated:YES];
        
    } else {
    
        UIStoryboard *sboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TypeDiveNumber *enter = [sboard instantiateViewControllerWithIdentifier:@"TypeDiveNumber"];
        
        enter.delegate = self;
        enter.boardSize = self.boardSize;
        enter.meetRecordID = self.meetRecordID;
        enter.diverRecordID = self.diverRecordID;
        enter.maxDiveNumber = self.maxDiveNumber;
        enter.onDiveNumber = self.onDiveNumber;
        enter.meetInfo = self.meetInfo;
        enter.whoCalled = 1;
        enter.preferredContentSize = CGSizeMake(400, 150);
        enter.popoverPresentationController.sourceView = self.view;
        enter.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionLeft;
        popoverContr = [enter popoverPresentationController];
        popoverContr.delegate = self;
        [self presentViewController:enter animated:YES completion:nil];

    }
}

- (IBAction)btnChooseDives:(id)sender {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        UIStoryboard *sboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TypeDiveNumber *enter = [sboard instantiateViewControllerWithIdentifier:@"ChooseDiveNumber"];
        
        popoverController = [[WYPopoverController alloc] initWithContentViewController:enter];
        popoverController.delegate = self;
        popoverController.popoverContentSize = CGSizeMake(250, 235);
        enter.delegate = self;
        // pass the instance of the custom class to the next class to dismiss it
        // need to declare this in the h file and then call dismissPopverAnimated on it
        enter.controller = popoverController;
        enter.boardSize = self.boardSize;
        enter.meetRecordID = self.meetRecordID;
        enter.diverRecordID = self.diverRecordID;
        enter.maxDiveNumber = self.maxDiveNumber;
        enter.onDiveNumber = self.onDiveNumber;
        enter.meetInfo = self.meetInfo;
        enter.whoCalled = 1;
        [popoverController presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:WYPopoverArrowDirectionNone animated:YES];
        
    } else {
    
        UIStoryboard *sboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TypeDiveNumber *enter = [sboard instantiateViewControllerWithIdentifier:@"ChooseDiveNumber"];
        
        enter.delegate = self;
        enter.boardSize = self.boardSize;
        enter.meetRecordID = self.meetRecordID;
        enter.diverRecordID = self.diverRecordID;
        enter.maxDiveNumber = self.maxDiveNumber;
        enter.onDiveNumber = self.onDiveNumber;
        enter.meetInfo = self.meetInfo;
        enter.whoCalled = 1;
        enter.preferredContentSize = CGSizeMake(400, 235);
        enter.popoverPresentationController.sourceView = self.view;
        enter.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionRight;
        popoverContr = [enter popoverPresentationController];
        popoverContr.delegate = self;
        [self presentViewController:enter animated:YES completion:nil];
        
    }
}

-(BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)popoverController {
    return YES;
}

- (IBAction)Dive1EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive1 edit Test");
        self.editDiveNumber = @1;
        self.oldDiveName = self.lblDive1.text;
        [self editDiverPopup];
        //[self performSegueWithIdentifier:@"idSegueDiveListEdit" sender:self];
    }
}

- (IBAction)Dive2EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive2 edit Test");
        self.editDiveNumber = @2;
        self.oldDiveName = self.lblDive2.text;
        [self editDiverPopup];
    }
}

- (IBAction)Dive3EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive3 edit Test");
        self.editDiveNumber = @3;
        self.oldDiveName = self.lblDive3.text;
        [self editDiverPopup];
    }
}

- (IBAction)Dive4EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive4 edit Test");
        self.editDiveNumber = @4;
        self.oldDiveName = self.lblDive4.text;
        [self editDiverPopup];
    }
}

- (IBAction)Dive5EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive5 edit Test");
        self.editDiveNumber = @5;
        self.oldDiveName = self.lblDive5.text;
        [self editDiverPopup];
    }
}

- (IBAction)Dive6EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive6 edit Test");
        self.editDiveNumber = @6;
        self.oldDiveName = self.lblDive6.text;
        [self editDiverPopup];
    }
}

- (IBAction)Dive7EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive7 edit Test");
        self.editDiveNumber = @7;
        self.oldDiveName = self.lblDive7.text;
        [self editDiverPopup];
    }
}

- (IBAction)Dive8EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive8 edit Test");
        self.editDiveNumber = @8;
        self.oldDiveName = self.lblDive8.text;
        [self editDiverPopup];
    }
}

- (IBAction)Dive9EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive9 edit Test");
        self.editDiveNumber = @9;
        self.oldDiveName = self.lblDive9.text;
        [self editDiverPopup];
    }
}

- (IBAction)Dive10EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive10 edit Test");
        self.editDiveNumber = @10;
        self.oldDiveName = self.lblDive10.text;
        [self editDiverPopup];
    }
}

- (IBAction)Dive11EditClick:(UILongPressGestureRecognizer *)sender {
    
    if (sender.state == UIGestureRecognizerStateBegan) {
        //NSLog(@"Dive11 edit Test");
        self.editDiveNumber = @11;
        self.oldDiveName = self.lblDive11.text;
        [self editDiverPopup];
    }
}

// delegate method to update after typing a dive number
-(void)typeDiveNumberWasFinished {
    
    [self fillDiveNumber];
    [self fillDiveInfo];
    [self EnableStartMeet];
}

// delegate method to update after choosing a dive
-(void)chooseDiveNumberWasFinished {
    
    [self fillDiveNumber];
    [self fillDiveInfo];
    [self EnableStartMeet];
}

#pragma private methods

-(void)editDiverPopup {
    
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"If you edit a dive which has already been scored you will need to update the score by selecting the Enter Scores button"
                                          message:nil
                                          preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *TypeNumber = [UIAlertAction
                                     actionWithTitle:@"Type Dive Number"
                                     style:UIAlertActionStyleDefault
                                     handler:^(UIAlertAction *action)
                                     {
                                         NSLog(@"Type Action");
                                         [self editTypeNumber];
                                     }];
    
    UIAlertAction *ChooseNumber = [UIAlertAction
                                  actionWithTitle:@"Choose Dive Number"
                                  style:UIAlertActionStyleDefault
                                  handler:^(UIAlertAction *action)
                                  {
                                      NSLog(@"Choose Action");
                                      [self editChooseNumber];
                                  }];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Dismiss Action");
                                   }];
    
    [alertController addAction:TypeNumber];
    [alertController addAction:ChooseNumber];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover) {
        popover.sourceView = self.view;
        CGRect rect = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 1, 1);
        popover.sourceRect = rect;
        popover.permittedArrowDirections = 0;
    }
    
}

-(void)editTypeNumber {
    
    CGRect rect = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 1, 1);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        UIStoryboard *sboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TypeDiveNumber *enter = [sboard instantiateViewControllerWithIdentifier:@"TypeDiveNumber"];
        
        popoverController = [[WYPopoverController alloc] initWithContentViewController:enter];
        popoverController.delegate = self;
        popoverController.popoverContentSize = CGSizeMake(250, 145);
        enter.delegate = self;
        // pass the instance of the custom class to the next class to dismiss it
        // need to declare this in the h file and then call dismissPopverAnimated on it
        enter.controller = popoverController;
        enter.boardSize = self.boardSize;
        enter.meetRecordID = self.meetRecordID;
        enter.diverRecordID = self.diverRecordID;
        enter.onDiveNumber = self.editDiveNumber;
        enter.meetInfo = self.meetInfo;
        enter.whoCalled = 2;
        [popoverController presentPopoverFromRect:rect inView:self.view permittedArrowDirections:WYPopoverArrowDirectionNone animated:YES];
        
    } else {
        
        UIStoryboard *sboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TypeDiveNumber *enter = [sboard instantiateViewControllerWithIdentifier:@"TypeDiveNumber"];
        
        enter.delegate = self;
        enter.boardSize = self.boardSize;
        enter.meetRecordID = self.meetRecordID;
        enter.diverRecordID = self.diverRecordID;
        enter.onDiveNumber = self.editDiveNumber;
        enter.meetInfo = self.meetInfo;
        enter.whoCalled = 2;
        enter.preferredContentSize = CGSizeMake(400, 150);
        enter.popoverPresentationController.sourceView = self.view;
        enter.popoverPresentationController.permittedArrowDirections = 0;
        popoverContr = [enter popoverPresentationController];
        popoverContr.delegate = self;
        [self presentViewController:enter animated:YES completion:nil];
        
    }
}

-(void)editChooseNumber {
    
    CGRect rect = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height/2, 1, 1);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        UIStoryboard *sboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TypeDiveNumber *enter = [sboard instantiateViewControllerWithIdentifier:@"ChooseDiveNumber"];
        
        popoverController = [[WYPopoverController alloc] initWithContentViewController:enter];
        popoverController.delegate = self;
        popoverController.popoverContentSize = CGSizeMake(250, 235);
        enter.delegate = self;
        // pass the instance of the custom class to the next class to dismiss it
        // need to declare this in the h file and then call dismissPopverAnimated on it
        enter.controller = popoverController;
        enter.boardSize = self.boardSize;
        enter.meetRecordID = self.meetRecordID;
        enter.diverRecordID = self.diverRecordID;
        enter.onDiveNumber = self.editDiveNumber;
        enter.meetInfo = self.meetInfo;
        enter.whoCalled = 2;
        [popoverController presentPopoverFromRect:rect inView:self.view permittedArrowDirections:WYPopoverArrowDirectionNone animated:YES];
        
    } else {
        
        UIStoryboard *sboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TypeDiveNumber *enter = [sboard instantiateViewControllerWithIdentifier:@"ChooseDiveNumber"];
        
        enter.delegate = self;
        enter.boardSize = self.boardSize;
        enter.meetRecordID = self.meetRecordID;
        enter.diverRecordID = self.diverRecordID;
        enter.onDiveNumber = self.editDiveNumber;
        enter.meetInfo = self.meetInfo;
        enter.whoCalled = 2;
        enter.preferredContentSize = CGSizeMake(400, 235);
        enter.popoverPresentationController.sourceView = self.view;
        enter.popoverPresentationController.permittedArrowDirections = 0;
        popoverContr = [enter popoverPresentationController];
        popoverContr.delegate = self;
        [self presentViewController:enter animated:YES completion:nil];
        
    }
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
}

-(void)fillDiveNumber {
    
    JudgeScores *scores = [[JudgeScores alloc] init];
    self.maxDiveNumber = [scores GetMaxDiveNumber:self.meetRecordID diverid:self.diverRecordID];
    
    // we need to see what the dive total is first and set it for the whole class
    DiveTotal *total = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:2];
    self.diveTotal = [total.diveTotal intValue];
    
    if (self.maxDiveNumber != self.diveTotal) {
        
        NSString *diveNum = @"Dive ";
        // here we will set the value for the whole class to use
        self.onDiveNumber = [NSNumber numberWithInt:self.maxDiveNumber + 1];
        
        diveNum = [diveNum stringByAppendingString:[NSString stringWithFormat:@"%@", self.onDiveNumber]];
        self.lblDiveNumber.text = diveNum;
    } else {
        
        self.lblDiveNumber.text = @"Begin Scoring";
    }
    
}

-(void)fillDiveInfo {
    
    //int diveNumInt = [self.onDiveNumber integerValue];
    JudgeScores *diveInfo = [[JudgeScores alloc] init];
    
    if (self.maxDiveNumber >= 1) {
        self.lblDive1.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:1];
        [self.lblDive1 setHidden:NO];
        [self.lblDive1text setHidden:NO];
        [self.view1 setUserInteractionEnabled:YES];
        [self.label1 setHidden:NO];
    }
    
    if (self.maxDiveNumber >= 2) {
        self.lblDive2.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:2];
        [self.lblDive2 setHidden:NO];
        [self.lblDive2text setHidden:NO];
        [self.view2 setUserInteractionEnabled:YES];
        [self.label2 setHidden:NO];
    }
    
    if (self.maxDiveNumber >= 3) {
        self.lblDive3.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:3];
        [self.lblDive3 setHidden:NO];
        [self.lblDive3text setHidden:NO];
        [self.view3 setUserInteractionEnabled:YES];
        [self.label3 setHidden:NO];
    }
    
    if (self.maxDiveNumber >= 4) {
        self.lblDive4.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:4];
        [self.lblDive4 setHidden:NO];
        [self.lblDive4text setHidden:NO];
        [self.view4 setUserInteractionEnabled:YES];
        [self.label4 setHidden:NO];
    }
    
    if (self.maxDiveNumber >= 5) {
        self.lblDive5.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:5];
        [self.lblDive5 setHidden:NO];
        [self.lblDive5text setHidden:NO];
        [self.view5 setUserInteractionEnabled:YES];
        [self.label5 setHidden:NO];
    }
    
    if (self.maxDiveNumber >= 6) {
        self.lblDive6.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:6];
        [self.lblDive6 setHidden:NO];
        [self.lblDive6text setHidden:NO];
        [self.view6 setUserInteractionEnabled:YES];
        [self.label6 setHidden:NO];
    }
    
    // we won't even bother checking these unless the diveTotal is 11
    if (self.diveTotal == 11) {
        if (self.maxDiveNumber >= 7) {
            self.lblDive7.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:7];
            [self.lblDive7 setHidden:NO];
            [self.lblDive7text setHidden:NO];
            [self.view7 setUserInteractionEnabled:YES];
            [self.label7 setHidden:NO];
        }
        
        if (self.maxDiveNumber >= 8) {
            self.lblDive8.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:8];
            [self.lblDive8 setHidden:NO];
            [self.lblDive8text setHidden:NO];
            [self.view8 setUserInteractionEnabled:YES];
            [self.label8 setHidden:NO];
        }
        
        if (self.maxDiveNumber >= 9) {
            self.lblDive9.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:9];
            [self.lblDive9 setHidden:NO];
            [self.lblDive9text setHidden:NO];
            [self.view9 setUserInteractionEnabled:YES];
            [self.label9 setHidden:NO];
        }
        
        if (self.maxDiveNumber >= 10) {
            self.lblDive10.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:10];
            [self.lblDive10 setHidden:NO];
            [self.lblDive10text setHidden:NO];
            [self.view10 setUserInteractionEnabled:YES];
            [self.label10 setHidden:NO];
        }
        
        if (self.maxDiveNumber >= 11) {
            self.lblDive11.text = [diveInfo GetCatAndName:self.meetRecordID diverid:self.diverRecordID divenumber:11];
            [self.lblDive11 setHidden:NO];
            [self.lblDive11text setHidden:NO];
            [self.view11 setUserInteractionEnabled:YES];
            [self.label11 setHidden:NO];
        }
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

-(void)EnableStartMeet {
    
    if (self.maxDiveNumber < self.diveTotal) {
        
        self.allDivesEntered = NO;
        [self.btnTypeNum setEnabled:YES];
        [self.btnChooseDives setEnabled:YES];
        
    } else {
        
        [self.btnTypeNum setEnabled:NO];
        [self.btnChooseDives setEnabled:NO];
        [self.btnTypeNum setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.btnChooseDives setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        // lets see if the diveList is filled yet and only update it if not
        self.allDivesEntered = YES;
        DiveList *list = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:1];
        int filled = [list.listFilled intValue];
        
        if (filled == 1) {
            [self updateListFilled];
        }
    }
    
}

-(void)updateListFilled {
    
    DiveList *list = [[DiveList alloc] init];
    [list UpdateListFilled:self.meetRecordID diverid:self.diverRecordID key:@2];
}

-(void)updateListStarted {
    
    DiveList *list = [[DiveList alloc] init];
    
    [list updateListStarted:self.meetRecordID diverid:self.diverRecordID];
}

@end
