//
//  RankingsDiver.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "RankingsDiver.h"
#import "Diver.h"
#import "Meet.h"
#import "MeetCollection.h"
#import "DiveNumber.h"
#import "DiverMeetScores.h"
#import "RankingsMeet.h"
#import "AlertControllerHelper.h"
#import "AppDelegate.h"

@interface RankingsDiver ()

@property (nonatomic, strong) NSArray *arrDivers;
@property (nonatomic, strong) NSArray *meetInfo;
@property (nonatomic) int diverId;
@property (nonatomic) int callingIdToReturnTo;

-(void)loadData;
-(void)CollectionOfMeets;
-(BOOL)NoScore;

@end

#pragma ViewController Methods

@implementation RankingsDiver

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self restrictRotation:YES];
    
    self.tblDiverRankings.delegate = self;
    self.tblDiverRankings.dataSource = self;
    
    // drop shadow for the table
    self.tblDiverRankings.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tblDiverRankings.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.tblDiverRankings.layer.masksToBounds = NO;
    self.tblDiverRankings.layer.shadowOpacity = 1.0;
    [self.tblDiverRankings setSeparatorColor:[UIColor blackColor]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self loadData];
}

// only allow portrait in iphone
-(void) restrictRotation:(BOOL) restriction
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.restrictRotation = restriction;
}

// restore state
-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super encodeRestorableStateWithCoder:coder];
    
    [coder encodeInt:self.meetId forKey:@"meetId"];
    [coder encodeObject:self.boardSize forKey:@"boardSize"];
}

-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    
    [super decodeRestorableStateWithCoder:coder];
    
    self.meetId = [coder decodeIntForKey:@"meetId"];
    self.boardSize = [coder decodeObjectForKey:@"boardSize"];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Send the id's to the Diver Meet Scores
    if ([segue.identifier isEqualToString:@"idRankToDiverMeetScores"]) {
        DiverMeetScores *diver = [segue destinationViewController];
        
        self.callingIdToReturnTo = 3;
        
        diver.meetInfo = self.meetInfo;
        diver.diverIdToView = self.diverId;
        diver.meetIdToView = self.meetId;
        diver.callingIDToReturnTo = self.callingIdToReturnTo;
        diver.boardSize = self.boardSize;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// keeps the color of the selected cell the same -
// in Ipad because of some unknown apple logic
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // assigns the diverid clicked so it can be sent to the DiverMeetScore controller
    self.diverId = [[[self.arrDivers objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    if ([self NoScore]) {
        
        // load the meet collection array
        [self CollectionOfMeets];
        
        // this actually send the chosen cell to the next screen
        [self performSegueWithIdentifier:@"idRankToDiverMeetScores" sender:self];
        
    } else {
        
        [AlertControllerHelper ShowAlert:@"Hold On!" message:@"There are no score for this diver yet" view:self];
        
    }
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.contentView.backgroundColor = cell.contentView.backgroundColor;
    
}

-(void)tableView:(UITableView*)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.contentView.backgroundColor = cell.contentView.backgroundColor;
}

// tells the tableView we want to have just one section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// specifies the total number of rows displayed in the table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrDivers.count;
}

// sets each rows height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        return 50.0;
        
    } else {
        
        return 80.0;
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
        cell.backgroundColor = [UIColor clearColor];
        
    } else {
        
        cell.textLabel.font = [UIFont systemFontOfSize:30.0];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:26.0];
        cell.textLabel.numberOfLines = 2;
        cell.backgroundColor = [UIColor clearColor];
        
    }
    
    // set the loaded data to the appropriate cell labels
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrDivers objectAtIndex:indexPath.row] objectAtIndex:1]];
    
    NSString *points = [NSString stringWithFormat:@"%@", [[self.arrDivers objectAtIndex:indexPath.row] objectAtIndex:2]];
    points = [points stringByAppendingString:@" Points"];
    cell.detailTextLabel.text = points;
    
    return cell;
}

#pragma Private Methods

-(void)loadData{
    
    //get the results
    if (self.arrDivers != nil) {
        self.arrDivers = nil;
    }
    
    Diver *divers = [[Diver alloc] init];
    self.arrDivers = [divers RankingsByDiverAtMeet:self.meetId boardSize:self.boardSize];
    
    // reload the table
    [self.tblDiverRankings reloadData];
}

// here we will get a collection of all the
// meets and thier children objects
-(void)CollectionOfMeets {
    
    MeetCollection *collection = [[MeetCollection alloc] init];
    
    self.meetInfo = [collection GetMeetAndDiverInfo:self.meetId diverid:self.diverId];

}

-(BOOL)NoScore {
    
    DiveNumber *nums = [[DiveNumber alloc] init];
    
    if ([nums DiveNumberForRankings:self.meetId diverid:self.diverId]) {
        return true;
    } else {
        return false;
    }
}

@end
