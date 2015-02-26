//
//  SwitchDiver.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 2/25/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import "SwitchDiver.h"
#import "Diver.h"
#import "Meet.h"
#import "MeetCollection.h"
#import "DiveNumber.h"
#import "DiveEnter.h"
#import "DiveListEnter.h"
#import "DiveListChoose.h"

@interface SwitchDiver ()

@property (nonatomic, strong) NSArray *arrDivers;
@property (nonatomic) int callingIdToReturnTo;

-(void)loadData;
-(void)CollectionOfMeets;
-(BOOL)NoScore;    // not sure

@end

@implementation SwitchDiver

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblDiverRankings.delegate = self;
    self.tblDiverRankings.dataSource = self;
    
    // drop shadow for the table
    self.tblDiverRankings.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tblDiverRankings.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.tblDiverRankings.layer.masksToBounds = NO;
    self.tblDiverRankings.layer.shadowOpacity = 1.0;
    [self.tblDiverRankings setSeparatorColor:[UIColor blackColor]];
    
    self.popoverPresentationController.backgroundColor = [UIColor colorWithRed:.16 green:.45 blue:.81 alpha:1];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self loadData];
}

// restore state
//-(void)encodeRestorableStateWithCoder:(NSCoder *)coder {
//    
//    [super encodeRestorableStateWithCoder:coder];
//    
//    [coder encodeInt:self.meetId forKey:@"meetId"];
//    [coder encodeObject:self.boardSize forKey:@"boardSize"];
//}
//
//-(void)decodeRestorableStateWithCoder:(NSCoder *)coder {
//    
//    [super decodeRestorableStateWithCoder:coder];
//    
//    self.meetId = [coder decodeIntForKey:@"meetId"];
//    self.boardSize = [coder decodeObjectForKey:@"boardSize"];
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Send the id's to the Diver Meet Scores
    if ([segue.identifier isEqualToString:@""]) {
        //DiverMeetScores *diver = [segue destinationViewController];
        
        self.callingIdToReturnTo = 3;
        
//        diver.meetInfo = self.meetInfo;
//        diver.diverIdToView = self.diverId;
//        diver.meetIdToView = self.meetId;
//        diver.callingIDToReturnTo = self.callingIdToReturnTo;
//        diver.boardSize = self.boardSize;
    }
}

// keeps the color of the selected cell the same -
// in Ipad because of some unknown apple logic
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // assigns the diverid clicked so it can be sent to the DiverMeetScore controller
    self.diverRecordID = [[[self.arrDivers objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    
    // this logic needs to be completely redone to send the diver to the correct page
    if ([self NoScore]) {
        
        // load the meet collection array
        [self CollectionOfMeets];
        
        // this actually send the chosen cell to the next screen
        [self performSegueWithIdentifier:@"idRankToDiverMeetScores" sender:self];
        
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"There are no scores for this diver yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
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
    
    return 40.0;
    
}

// displays a row's data
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // dequeue the cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    //cell.detailTextLabel.font = [UIFont systemFontOfSize:12.0];
    cell.textLabel.numberOfLines = 1;
    cell.backgroundColor = [UIColor clearColor];
    
            // set the loaded data to the appropriate cell labels
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrDivers objectAtIndex:indexPath.row] objectAtIndex:1]];
    
//    NSString *points = [NSString stringWithFormat:@"%@", [[self.arrDivers objectAtIndex:indexPath.row] objectAtIndex:2]];
//    points = [points stringByAppendingString:@" Points"];
//    cell.detailTextLabel.text = points;
    
    return cell;
}

#pragma Private Methods

-(void)loadData{
    
    //get the results
    if (self.arrDivers != nil) {
        self.arrDivers = nil;
    }
    
    Diver *divers = [[Diver alloc] init];
    self.arrDivers = [divers DiversAtMeet:self.meetRecordID];
    
    // reload the table
    [self.tblDiverRankings reloadData];
}

// here we will get a collection of all the
// meets and thier children objects
-(void)CollectionOfMeets {
    
    MeetCollection *collection = [[MeetCollection alloc] init];
    
    self.meetInfo = [collection GetMeetAndDiverInfo:self.meetRecordID diverid:self.diverRecordID];
    
}

-(BOOL)NoScore {
    
    DiveNumber *nums = [[DiveNumber alloc] init];
    
    if ([nums DiveNumberForRankings:self.meetRecordID diverid:self.diverRecordID]) {
        return true;
    } else {
        return false;
    }
}

@end
