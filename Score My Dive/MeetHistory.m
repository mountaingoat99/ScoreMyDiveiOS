//
//  MeetHistory.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/27/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "MeetHistory.h"
#import "Diver.h"
#import "DiverMeetScores.h"
#import "Meet.h"
#import "MeetCollection.h"
#import "Judges.h"

@interface MeetHistory ()

// for the table
@property (nonatomic, strong) NSArray *arrMeetHistory;


-(void)loadData;
-(void)CollectionOfMeets;

@end

@implementation MeetHistory

@synthesize recordIDToEdit;

#pragma View Controller Events

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
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    if (self.recordIDToEdit != -1) {
        [self loadData];
    }
}

// restore state
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super encodeRestorableStateWithCoder:coder];
    
    [coder encodeInt:self.recordIDToEdit forKey:@"RecordId"];
    [coder encodeInt:self.diverid forKey:@"DiverId"];
    [coder encodeInt:self.callingIdToReturnTo forKey:@"CallingId"];
    [coder encodeObject:self.meetInfo forKey:@"Info"];
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.recordIDToEdit = [coder decodeIntForKey:@"RecordId"];
    self.diverid = [coder decodeIntForKey:@"DiverId"];
    self.callingIdToReturnTo = [coder decodeIntForKey:@"CallingId"];
    self.meetInfo = [coder decodeObjectForKey:@"Info"];
}

// we will need to call a method to get the correct diver child for the meet
// and put it a new array of objects to send tp the DiverMeetScores
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Send the id's to the Diver Meet Scores
    if ([segue.identifier isEqualToString:@"idSegueMeetHistToScores"]) {
        DiverMeetScores *scores = [segue destinationViewController];
        
        // assign 1 to the DiverMeetScore Segue knows who to return to
        self.callingIdToReturnTo = 1;
        
        scores.meetInfo = self.meetInfo;
        scores.meetIdToView = self.recordIDToEdit;
        scores.diverIdToView = self.diverid;
        scores.callingIDToReturnTo = self.callingIdToReturnTo;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// return button from the meet scores page
-(IBAction)unwindToMeetHistory:(UIStoryboardSegue*)segue {
    
}

// keeps the color of the selected cell the same -
// in Ipad because of some unknown apple logic
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:.50 green:.50 blue:.50 alpha:1];
    
    // assigns the diverid clicked so it can be sent to the DiverMeetScore controller
    self.diverid = [[[self.arrMeetHistory objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    // load the meet collection array
    [self CollectionOfMeets];
    
    
    [self performSegueWithIdentifier:@"idSegueMeetHistToScores" sender:self];
    
    //old
    // this actually send the chosen cell to the next screen
    //[self performSegueWithIdentifier:@"idSegueMeetHistToScores" sender:self];
    
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
    return self.arrMeetHistory.count;
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrMeetHistory objectAtIndex:indexPath.row] objectAtIndex:1]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[self.arrMeetHistory objectAtIndex:indexPath.row] objectAtIndex:2]];
    
    return cell;
}


- (IBAction)btnReturnClick:(id)sender {

    [self performSegueWithIdentifier:@"idSegueMeetHistoryToDetail" sender:self];
    
}

#pragma  private methods

-(void)loadData{
    
    //get the results
    if (self.arrMeetHistory != nil) {
        self.arrMeetHistory = nil;
    }
    
    Diver *divers = [[Diver alloc] init];
    self.arrMeetHistory = [divers DiversAtMeet:recordIDToEdit];
    
    // reload the table
    [self.tblHistory reloadData];
}

// here we will get a collection of all the
// meets and thier children objects
-(void)CollectionOfMeets {
    
    MeetCollection *collection = [[MeetCollection alloc] init];
    
    self.meetInfo = [collection GetMeetAndDiverInfo:recordIDToEdit diverid:self.diverid];
    
//    // doing this to test and log that we get the correct data
//    Meet *testMeet = [[Meet alloc] init];
//    Judges *testJudges = [[Judges alloc] init];
//    
//    testMeet = [self.meetInfo objectAtIndex:0];
//    testJudges = [self.meetInfo objectAtIndex:1];
//    
//    // here we just want to let the log know we have the correct meet chosen
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
