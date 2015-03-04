//
//  DiveListEdit.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/20/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveListEdit.h"
#import "DiveListEnter.h"
#import "TypeDiveNumber.h"
#import "ChooseDiveNumber.h"
#import "WYPopoverController.h"

@interface DiveListEdit () <WYPopoverControllerDelegate>
{
    WYPopoverController* popoverController;
}

@property (nonatomic) BOOL noWarning;
@property (nonatomic, strong) NSNumber *multiplier;

-(void)fillText;
-(void)fillDiveNumber;
-(void)showFirstWarning;

@end

@implementation DiveListEdit

@synthesize popoverContr;

#pragma viewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundPanel.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backgroundPanel.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.backgroundPanel.layer.masksToBounds = NO;
    self.backgroundPanel.layer.shadowOpacity = 1.0;
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fillText];
    [self fillDiveNumber];
    [self showFirstWarning];
    
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
    
    [coder encodeObject:self.meetInfo forKey:@"meetInfo"];
    [coder encodeInt:self.meetRecordID forKey:@"meetId"];
    [coder encodeInt:self.diverRecordID forKey:@"diverId"];
    [coder encodeObject:self.boardSize forKey:@"boardSize"];
    [coder encodeObject:self.diveNumber forKey:@"diveNumber"];
    [coder encodeObject:self.oldDiveName forKey:@"oldDiveName"];
    self.noWarning = YES;
    [coder encodeBool:self.noWarning forKey:@"warning"];
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.meetInfo = [coder decodeObjectForKey:@"meetInfo"];
    self.meetRecordID = [coder decodeIntForKey:@"meetId"];
    self.diverRecordID = [coder decodeIntForKey:@"diverId"];
    self.boardSize = [coder decodeObjectForKey:@"boardSize"];
    self.diveNumber = [coder decodeObjectForKey:@"diveNumber"];
    self.oldDiveName = [coder decodeObjectForKey:@"oldDiveName"];
    self.noWarning = [coder decodeBoolForKey:@"warning"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"idEditListToEnterList"]) {
        
        DiveListEnter *enter = [segue destinationViewController];
        
        enter.meetInfo = self.meetInfo;
        enter.meetRecordID = self.meetRecordID;
        enter.diverRecordID = self.diverRecordID;
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
        enter.onDiveNumber = self.diveNumber;
        enter.meetInfo = self.meetInfo;
        enter.whoCalled = 2;
        [popoverController presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:WYPopoverArrowDirectionNone animated:YES];
        
    } else {
    
        UIStoryboard *sboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TypeDiveNumber *enter = [sboard instantiateViewControllerWithIdentifier:@"TypeDiveNumber"];
        
        popoverContr = [[UIPopoverController alloc] initWithContentViewController:enter];
        popoverContr.popoverContentSize = CGSizeMake(400, 150);
        enter.delegate = self;
        enter.boardSize = self.boardSize;
        enter.meetRecordID = self.meetRecordID;
        enter.diverRecordID = self.diverRecordID;
        enter.onDiveNumber = self.diveNumber;
        enter.meetInfo = self.meetInfo;
        enter.whoCalled = 2;
        [popoverContr presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionLeft animated:YES];
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
        enter.onDiveNumber = self.diveNumber;
        enter.meetInfo = self.meetInfo;
        enter.whoCalled = 2;
        [popoverController presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:WYPopoverArrowDirectionNone animated:YES];
        
    } else {
    
        UIStoryboard *sboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TypeDiveNumber *enter = [sboard instantiateViewControllerWithIdentifier:@"ChooseDiveNumber"];
        
        popoverContr = [[UIPopoverController alloc] initWithContentViewController:enter];
        popoverContr.popoverContentSize = CGSizeMake(400, 235);
        enter.delegate = self;
        enter.boardSize = self.boardSize;
        enter.meetRecordID = self.meetRecordID;
        enter.diverRecordID = self.diverRecordID;
        enter.onDiveNumber = self.diveNumber;
        enter.meetInfo = self.meetInfo;
        enter.whoCalled = 2;
        [popoverContr presentPopoverFromRect:[(UIButton *)sender frame] inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// delegate method from TypeDiveNumber calling delegate method to update EnterDiveList from here
-(void)editDiveNumberWasFinished {
    
    [self.delegate editDiveListWasFinished];
}

-(void)typeDiveNumberWasFinished {
    //unimplemented method
}

-(void)editChooseDiveNumberWasFinished {
    
    [self.delegate editDiveListWasFinished];
}

-(void)chooseDiveNumberWasFinished {
    //unimplemented method
}

#pragma private methods

-(void)showFirstWarning {
    
    if (!self.noWarning) {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Heads up!"
                                                        message:@"If you edit a dive that already has a score, you will want to update the dive score in the \"Score Meet\" Screen."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
    }
}

-(void)fillText {
    
    self.lblOldDiveName.text = self.oldDiveName;
}

-(void)fillDiveNumber {
    
    NSString *diveNum = @"Edit Dive ";
    
    diveNum = [diveNum stringByAppendingString:[NSString stringWithFormat:@"%@", self.diveNumber]];
    self.lblDiveNumber.text = diveNum;
}

@end
