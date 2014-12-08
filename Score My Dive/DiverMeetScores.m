//
//  DiverMeetScores.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiverMeetScores.h"
#import "Diver.h"
#import "Meet.h"
#import "Results.h"
#import "DiverBoardSize.h"
#import "DiveInfo.h"

@interface DiverMeetScores ()

// private methods to load the data
-(void)loadDiverInfo;
-(void)loadMeetInfo;
-(void)loadType;
-(void)loadResults;

// test
//-(void)GetMeetCollection;

@end

@implementation DiverMeetScores

#pragma ViewController Events

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //sets the border for the label/buttons
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
    
    if (self.meetInfo.count > 0) {
        [self loadDiverInfo];
        [self loadMeetInfo];
        [self loadType];
        [self loadResults];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToDiverMeetScores:(UIStoryboardSegue*)segue {
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"idSegueDiverScores"]) {
        DiveInfo *info = [segue destinationViewController];
        
        info.callingIDToReturnTo = self.callingIDToReturnTo;
        info.meetIdToView = self.meetIdToView;
        info.diverIdToView = self.diverIdToView;
        info.diveNumber = self.diveNumber;
        info.meetInfo = self.meetInfo;
    }
}

- (IBAction)btnDive1Click:(id)sender {
    
    self.diveNumber = 1;
    
    [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
}

- (IBAction)btnDive2Click:(id)sender {
    
    self.diveNumber = 2;
    
    [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
}

- (IBAction)btnDive3Click:(id)sender {
    
    self.diveNumber = 3;
    
    [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
}

- (IBAction)btnDive4Click:(id)sender {
    
    self.diveNumber = 4;
    
    [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
}

- (IBAction)btnDive5Click:(id)sender {
    
    self.diveNumber = 5;
    
    [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
}

- (IBAction)btnDive6Click:(id)sender {
    
    self.diveNumber = 6;
    
    [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
}

- (IBAction)btnDive7Click:(id)sender {
    
    self.diveNumber = 7;
    
    [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
}

- (IBAction)btnDive8Click:(id)sender {
    
    self.diveNumber = 8;
    
    [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
}

- (IBAction)btnDive9Click:(id)sender {
    
    self.diveNumber = 9;
    
    [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
}

- (IBAction)btnDive10Click:(id)sender {
    
    self.diveNumber = 10;
    
    [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
}

- (IBAction)btnDive11Click:(id)sender {
    
    self.diveNumber = 11;
    
    [self performSegueWithIdentifier:@"idSegueDiverScores" sender:self];
}

- (IBAction)btnReturnClick:(id)sender {
    
    if (self.callingIDToReturnTo == 1) {
        [self performSegueWithIdentifier:@"idSegueMeetHistToScores" sender:self];
    } else {
        [self performSegueWithIdentifier:@"idSegueDiverHistToScores" sender:self];
    }
}

#pragma Private methods

// loads the current record to update
-(void)loadDiverInfo {
    
    Diver *diver = [[Diver alloc] init];
    
    diver = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:0];
    
    self.lblName.text = diver.Name;
    self.lblSchool.text = diver.School;
    
}

-(void)loadMeetInfo {
    
    Meet *meet = [[Meet alloc] init];
    NSString *schoolAndDate;
    NSString *cityState;
    
    meet = [self.meetInfo objectAtIndex:0];
    
    self.lblMeetName.text = meet.meetName;
    schoolAndDate = meet.schoolName;
    schoolAndDate = [schoolAndDate stringByAppendingString:@" - "];
    self.lblSchoolName.text = [schoolAndDate stringByAppendingString:meet.date];
    cityState = meet.city;
    cityState = [cityState stringByAppendingString:@", "];
    self.lblCity.text = [cityState stringByAppendingString:meet.state];

}

-(void)loadType {
    
    DiverBoardSize *board = [[DiverBoardSize alloc] init];
    
    board = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:4];
    NSString *boardType;
    
    boardType = [board.firstSize stringValue];
    self.lblBoardType.text = [boardType stringByAppendingString:@" Meter"];
    
}

-(void)loadResults {
    
    Results *result = [[Results alloc] init];
    
    result = [[[self.meetInfo objectAtIndex:2] objectAtIndex:0] objectAtIndex:5];
    
    self.lblDive1.text = [result.dive1 stringValue];
    self.lblDive2.text = [result.dive2 stringValue];
    self.lblDive3.text = [result.dive3 stringValue];
    self.lblDive4.text = [result.dive4 stringValue];
    self.lblDive5.text = [result.dive5 stringValue];
    self.lblDive6.text = [result.dive6 stringValue];
    self.lblDive7.text = [result.dive7 stringValue];
    self.lblDive8.text = [result.dive8 stringValue];
    self.lblDive9.text = [result.dive9 stringValue];
    self.lblDive10.text = [result.dive10 stringValue];
    self.lblDive11.text = [result.dive11 stringValue];
    self.lblTotal.text = [result.totalScoreTotal stringValue];
    
}










































@end
