//
//  RankingsMeet.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/28/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "RankingsMeet.h"
#import "Meet.h"
#import "Diver.h"
#import "RankingsDiver.h"

@interface RankingsMeet ()

// for the table
@property (nonatomic, strong) NSArray *arrMeets;
@property (nonatomic) int meetId;
@property (nonatomic, strong) NSNumber *boardSize;

-(void)loadData;
-(BOOL)NoScore;

@end

@implementation RankingsMeet

#pragma ViewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblRankings.delegate = self;
    self.tblRankings.dataSource = self;
    
    // drop shadow for the table
    self.tblRankings.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tblRankings.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.tblRankings.layer.masksToBounds = NO;
    self.tblRankings.layer.shadowOpacity = 1.0;
    [self.tblRankings setSeparatorColor:[UIColor blackColor]];
    
    [self loadData];
}

// only allow portrait in iphone
-(BOOL)shouldAutorotate {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Send the id's to the Diver Meet Scores
    if ([segue.identifier isEqualToString:@"idSegueToRankingsDiver"]) {
        RankingsDiver *diver = [segue destinationViewController];
        
        diver.meetId = self.meetId;
        diver.boardSize = self.boardSize;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// return button from the meet scores page
-(IBAction)unwindToRankingsMeet:(UIStoryboardSegue*)segue {
    
}

// keeps the color of the selected cell the same -
// in Ipad because of some unknown apple logic
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // assigns the diverid clicked so it can be sent to the DiverMeetScore controller
    self.meetId = [[[self.arrMeets objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    self.boardSize = [[self.arrMeets objectAtIndex:indexPath.row] objectAtIndex:2];
    
    if ([self NoScore]) {
        
        // this actually send the chosen cell to the next screen
        [self performSegueWithIdentifier:@"idSegueToRankingsDiver" sender:self];
        
    } else {
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"There are no scores for this meet yet"
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
    return self.arrMeets.count;
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrMeets objectAtIndex:indexPath.row] objectAtIndex:1]];
    
    NSString *boardType = [NSString stringWithFormat:@"%@", [[self.arrMeets objectAtIndex:indexPath.row] objectAtIndex:2]];
    boardType = [boardType stringByAppendingString:@" Meter"];
    cell.detailTextLabel.text = boardType;
    
    return cell;
}

#pragma private methods

-(void)loadData{
    
    //get the results
    if (self.arrMeets != nil) {
        self.arrMeets = nil;
    }
    
    Meet *meets = [[Meet alloc] init];
    self.arrMeets = [meets GetNameForMeetRank];
    
    // reload the table
    [self.tblRankings reloadData];
}

-(BOOL)NoScore {
    
    Diver *divers = [[Diver alloc] init];
    
    if ([divers CheckDiverForRankings:self.meetId boardsize:self.boardSize]) {
        return true;
    } else {
        return false;
    }
}

@end
