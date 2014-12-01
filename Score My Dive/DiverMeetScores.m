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

@interface DiverMeetScores ()

@property (nonatomic, strong) NSString *nameAgeText;
@property (nonatomic, strong) NSString *schoolText;
@property (nonatomic, strong) NSString *meetNameText;
@property (nonatomic, strong) NSString *meetSchoolDateText;
@property (nonatomic, strong) NSString *CityStateText;
@property (nonatomic, strong) NSString *scoreTotalText;
@property (nonatomic, strong) NSString *boardTypeText;
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

// private methods to load the data
-(void)loadDiverInfo;
-(void)loadMeetInfo;
-(void)loadType;
-(void)loadResults;

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToDiverMeetScores:(UIStoryboardSegue*)segue {
    
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

#pragma Private methods

// loads the current record to update
-(void)loadDiverInfo {
    
    Diver *diver = [[Diver alloc] init];
    
    NSArray *diverInfo = [diver LoadDiver:self.diverIdToView];
    
    self.lblName.text = [[diverInfo objectAtIndex:0 ] objectAtIndex:1];
    self.lblSchool.text = [[diverInfo objectAtIndex:0] objectAtIndex:4];
    
}

-(void)loadMeetInfo {
    
    Meet *meet = [[Meet alloc] init];
    NSString *schoolAndDate;
    NSString *cityState;
    
    NSArray *meetInfo = [meet LoadMeet:self.meetIdToView];
    
    self.lblMeetName.text = [[meetInfo objectAtIndex:0] objectAtIndex:1];
    schoolAndDate = [[meetInfo objectAtIndex:0] objectAtIndex:2];
    schoolAndDate = [schoolAndDate stringByAppendingString:@" - "];
    self.lblSchoolName.text = [schoolAndDate stringByAppendingString:[[meetInfo objectAtIndex:0] objectAtIndex:5]];
    cityState = [[meetInfo objectAtIndex:0] objectAtIndex:3];
    cityState = [cityState stringByAppendingString:@", "];
    self.lblCity.text = [cityState stringByAppendingString:[[meetInfo objectAtIndex:0] objectAtIndex:4]];

}

-(void)loadType {
    
    DiverBoardSize *board = [[DiverBoardSize alloc] init];
    NSString *boardType;
    
    int boardsize = 1;
    
    NSNumber *type = [board BoardSize:self.meetIdToView DiverID:self.diverIdToView BoardNumber:boardsize];
    
    boardType = [type stringValue];
    self.lblBoardType.text = [boardType stringByAppendingString:@" Meter"];
    
}

-(void)loadResults {
    
    
    
}











































@end
