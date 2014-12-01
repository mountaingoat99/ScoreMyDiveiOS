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

@interface DiverHistory ()

@property (nonatomic, strong) NSArray *arrDiverHistory;

-(void)loadData;

@end

@implementation DiverHistory

#pragma ViewController events

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblHistory.delegate = self;
    self.tblHistory.dataSource = self;
    
    // drop shadow for the table
    self.tblHistory.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tblHistory.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.tblHistory.layer.masksToBounds = NO;
    self.tblHistory.layer.shadowRadius = 4.0f;
    self.tblHistory.layer.shadowOpacity = 1.0;
    
    [self loadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"idSegueDiverHistToScores"]) {
        DiverMeetScores *scores = [segue destinationViewController];
        
        // assign 1 to the DiverMeetScore Segue knows who to return to
        self.callingIdToReturnTo = 2;
        
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
        
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
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
    
    return cell;
}

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

@end
