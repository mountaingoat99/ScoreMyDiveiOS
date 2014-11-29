//
//  MeetHistory.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/27/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "MeetHistory.h"
#import "Diver.h"

#import "Meet.h"

@interface MeetHistory ()

@property (nonatomic, strong) NSArray *arrMeetHistory;

-(void)loadData;

@end

@implementation MeetHistory

#pragma View Controller Events

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
    
    //TODO: Send the id to the Meet Scores
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// return button from the meet scores page
-(IBAction)unwindToMeetHistory:(UIStoryboardSegue*)segue {
    
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
    return 50.0;
}

// displays a row's data
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // dequeue the cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    //set the text size
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.numberOfLines = 2;
    
    // set the loaded data to the appropriate cell labels
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrMeetHistory objectAtIndex:indexPath.row] objectAtIndex:1]];
    
    return cell;
}

#pragma  private methods

-(void)loadData{
    
    //get the results
    if (self.arrMeetHistory != nil) {
        self.arrMeetHistory = nil;
    }
    
    Diver *diver = [[Diver alloc] init];
    self.arrMeetHistory = [diver DiversAtMeet:self.recordIdToEdit];
    
    // reload the table
    [self.tblHistory reloadData];
}

@end
