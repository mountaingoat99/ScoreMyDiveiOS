//
//  DiverHistory.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/27/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiverHistory.h"
#import "Meet.h"
#import "DiverMeetScores.h"
#import "Diver.h"
#import "DiverCollection.h"
#import "MeetCollection.h"
#import "Judges.h"

@interface DiverHistory ()

@property (nonatomic, strong) NSArray *arrDiverHistory;

-(void)loadData;
-(void)CollectionOfDivers;

@end

@implementation DiverHistory

#pragma ViewController events

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblHistory.delegate = self;
    self.tblHistory.dataSource = self;
    
    // drop shadow for the table
    self.tblHistory.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tblHistory.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.tblHistory.layer.masksToBounds = NO;
    self.tblHistory.layer.shadowRadius = 4.0f;
    self.tblHistory.layer.shadowOpacity = 1.0;
    //NSLog(@"DiverHistory ViewDidLoad");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    if (self.recordIdToEdit != -1) {
        [self loadData];
    }
    //NSLog(@"DiverHistory viewWillAppear");
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //NSLog(@"DiverHistory ViewDidAppear");
}

// restore state
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super encodeRestorableStateWithCoder:coder];
    
    [coder encodeInt:self.recordIdToEdit forKey:@"RecordId"];
    [coder encodeInt:self.meetId forKey:@"MeetId"];
    [coder encodeInt:self.callingIdToReturnTo forKey:@"CallingId"];
    [coder encodeObject:self.diverInfo forKey:@"Info"];
    
    //NSLog(@"DiverHistory encode");
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.recordIdToEdit = [coder decodeIntForKey:@"RecordId"];
    self.meetId = [coder decodeIntForKey:@"MeetId"];
    self.callingIdToReturnTo = [coder decodeIntForKey:@"CallingId"];
    self.diverInfo = [coder decodeObjectForKey:@"Info"];
    
    //NSLog(@"DiverHistory Decode");
}

-(void)viewMeetScoreWasFinished {
    [self loadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Send the id's to the Diver Meet Scores
    if ([segue.identifier isEqualToString:@"idSegueDiverHistToScores"]) {
        DiverMeetScores *scores = [segue destinationViewController];
        
        // assign 1 to the DiverMeetScore Segue knows who to return to
        self.callingIdToReturnTo = 2;
        
        scores.meetInfo = self.diverInfo;
        scores.diverIdToView = self.recordIdToEdit;
        scores.meetIdToView = self.meetId;
        scores.callingIDToReturnTo = self.callingIdToReturnTo;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToDiverHistory:(UIStoryboardSegue*)segue {
    
}

// keeps the color of the selected cell the same -
// in Ipad because of some unknown apple logic
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:.50 green:.50 blue:.50 alpha:1];
    
    // assigns the meetid clicked so it can be sent to the DivermeetScore controller
    self.meetId = [[[self.arrDiverHistory objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    [self CollectionOfDivers];
    
    // this actually sends the chosen cell to the next screen
    [self performSegueWithIdentifier:@"idSegueDiverHistToScores" sender:self];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:.40 green:.40 blue:.40 alpha:1];
    
}

-(void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.contentView.backgroundColor = [UIColor colorWithRed:.40 green:.40 blue:.40 alpha:1];
    
}

// tells the tableView we want to have just one section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// specifies the total number of rows displayed in the table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrDiverHistory.count;
}

// sets each rows height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        return 50.0;
        
    } else {
        
        return 50.0;
    }
}

// displays a row's data
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // dequeue the cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    //set the text size
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
        cell.textLabel.numberOfLines = 2;
        cell.contentView.backgroundColor = [UIColor colorWithRed:.40 green:.40 blue:.40 alpha:1];
        
    } else {
        
        cell.textLabel.font = [UIFont systemFontOfSize:20.0];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:16.0];
        cell.textLabel.numberOfLines = 2;
        cell.contentView.backgroundColor = [UIColor colorWithRed:.40 green:.40 blue:.40 alpha:1];
        
    }

    
    // set the loaded data to the appropriate cell labels
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrDiverHistory objectAtIndex:indexPath.row] objectAtIndex:1]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[self.arrDiverHistory objectAtIndex:indexPath.row] objectAtIndex:2]];
    
    return cell;
}


//- (IBAction)btnReturnClick:(id)sender {
//    
//    [self performSegueWithIdentifier:@"idSegueDiveHistoryToDetails" sender:self];
//}

#pragma  private methods

-(void)loadData{
    
    //get the results
    if (self.arrDiverHistory != nil) {
        self.arrDiverHistory = nil;
    }
    
    Meet *meets = [[Meet alloc] init];
    self.arrDiverHistory = [meets GetMeetHistory:self.recordIdToEdit];
    
    // reload the table
    [self.tblHistory reloadData];
}

//here we will get a collection of all the meet and thier children objects
-(void)CollectionOfDivers {
    
    MeetCollection *collection = [[MeetCollection alloc] init];
    
    self.diverInfo = [collection GetMeetAndDiverInfo:self.meetId diverid:self.recordIdToEdit];
    
    // doing this to test and log that we get the correct data
    //Meet *testMeet = [[Meet alloc] init];
    //Judges *testJudges = [[Judges alloc] init];
    
    //testMeet = [self.diverInfo objectAtIndex:0];
    //testJudges = [self.diverInfo objectAtIndex:1];
    
    // here we just want to let the log know we have the correct meet chosen
//    NSString *test = testMeet.meetID;
//    NSString *testName = testMeet.meetName;
//    NSString *testSchool = testMeet.schoolName;
//    NSString *testCity = testMeet.city;
//    NSString *testState = testMeet.state;
//    NSString *testDate = testMeet.date;
//    NSNumber *testJudgeTotal = testJudges.judgeTotal;
//    
//    NSLog(@"the meetid is %@", test);
//    NSLog(@"the meetname is %@", testName);
//    NSLog(@"the meetschool is %@", testSchool);
//    NSLog(@"the meetcity is %@", testCity);
//    NSLog(@"the meetstate is %@", testState);
//    NSLog(@"the meetdate is %@", testDate);
//    NSLog(@"the judgetotal is %@", testJudgeTotal);
    
}

@end
