//
//  UIViewController+QuickScoreViewController.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 10/31/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "QuickScoreViewController.h"
#import "QuickScores.h"

@interface QuickScoreViewController ()

@property (nonatomic) int recordIDToEdit;

@property (nonatomic, strong) NSArray *arrQuickInfo;

-(void)loadData;

@end

@implementation QuickScoreViewController

#pragma ViewController Events

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // make self the delegate and datasource of the table view
    self.tblQuickScores.delegate = self;
    self.tblQuickScores.dataSource = self;
    
    // drop shadow for the table
    self.tblQuickScores.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tblQuickScores.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.tblQuickScores.layer.masksToBounds = NO;
    self.tblQuickScores.layer.shadowRadius = 4.0f;
    self.tblQuickScores.layer.shadowOpacity = 1.0;
    
    // call the load method
    [self loadData];
}


-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(IBAction)unwideToQuickScore:(UIStoryboardSegue *)segue{
    
}

-(IBAction)returnClick:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)addNewRecord:(id)sender {
    // before performing the segue , set the value to the recordIDToEdit
    // to indicate we want to add and not edit
    self.recordIDToEdit = -1;
    
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

// user chooses a row to delete
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // delete the selected record find the record id
        int recordIDToDelete = [[[self.arrQuickInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
        
        // call the class method to delete a record
        QuickScores *scores = [[QuickScores alloc] init];
        [scores DeleteQuickScore:recordIDToDelete];
        
        //reload the table view
        [self loadData];
    }
}

// calls the edit cell
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    // get the record ID of the selected name and set to the recordIDToEdit property
    self.recordIDToEdit = [[[self.arrQuickInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    // perform the segue
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

// now make this veiwcontroller class the delegate of the QuickScoreEdit ViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QuickScoreEdit *quickScoreEdit = [segue destinationViewController];
    quickScoreEdit.delegate = self;
    
    // sends the id to the QuickScoreEdit View Controller
    quickScoreEdit.recordIDToEdit = self.recordIDToEdit;
}

// delegate method to update info after the edit info is popped off
-(void)editInfoWasFinished{
    [self loadData];
}

#pragma private Methods
-(void)loadData{
    
    // get the result
    if(self.arrQuickInfo != nil){
        self.arrQuickInfo = nil;
    }
    
    // call the class method to load the data
    QuickScores *score = [[QuickScores alloc] init];
    self.arrQuickInfo = [score LoadAllQuickScores];
    
    // reload the table
    [self.tblQuickScores reloadData];
}

// tells the tableView we want to have just one section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// specifies the total number of rows displayed in the table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrQuickInfo.count;
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrQuickInfo objectAtIndex:indexPath.row] objectAtIndex:1]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Score: %@", [[self.arrQuickInfo objectAtIndex:indexPath.row] objectAtIndex:2]];
    
    return cell;
}

@end
