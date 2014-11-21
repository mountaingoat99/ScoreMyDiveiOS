//
//  UIViewController+DiverDetailsVC.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/2/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiverDetailsVC.h"
#import "Diver.h"

@interface DiverDetailsVC ()

@property (nonatomic) int recordIDToEdit;

@property (nonatomic, strong) NSArray *arrDiverInfo;

-(void)loadData;

@end

@implementation DiverDetailsVC

#pragma mark  - UIViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblDivers.delegate = self;
    self.tblDivers.dataSource = self;
    
    //drop shadow for the table
    self.tblDivers.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tblDivers.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.tblDivers.layer.masksToBounds = NO;
    self.tblDivers.layer.shadowRadius = 4.0f;
    self.tblDivers.layer.shadowOpacity = 1.0;
    
    [self loadData];
  
}

-(IBAction)unwindToDiverDetails:(UIStoryboardSegue *)segue{
    
}

// handles the return click
-(IBAction)returnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addNewRecord:(id)sender {
    self.recordIDToEdit = -1;
    
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

// delete a row
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // delete the selected record find the record id
        int recordIDToDelete = [[[self.arrDiverInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
        
        // call the class method to delete a record
        Diver *divers = [[Diver alloc] init];
        [divers DeleteDiver:recordIDToDelete];
        
        //reload the table view
        [self loadData];
    }
}

// calls the cell to edit
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    // get the record ID of the selected name and set to the recordIDToEdit property
    self.recordIDToEdit = [[[self.arrDiverInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    // perform the segue
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

// make this viewcontroller the delegate of the MeetEdit ViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DiverEdit *diverEdit = [segue destinationViewController];
    diverEdit.delegate = self;
    
    // send the id to the MeetEdit VC
    diverEdit.recordIDToEdit = self.recordIDToEdit;
}

// delegate method to update info after the edit info is popped off
-(void)editInfoWasFinished{
    [self loadData];
}

#pragma private methods
-(void)loadData{
    
    // get the result
    if(self.arrDiverInfo != nil){
        self.arrDiverInfo = nil;
    }
    
    // call the class method to load the data
    Diver *divers = [[Diver alloc] init];
    self.arrDiverInfo = [divers GetAllDivers];
    
    // reload the table
    [self.tblDivers reloadData];
}

// tells the tableView we want to have just one section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// specifies the total number of rows displayed in the table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrDiverInfo.count;
}

// sets each rows height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

// displays a row's data
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // dequeue the cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellRecord" forIndexPath:indexPath];
    
    //set the text sizes
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.numberOfLines = 2;
    
    // set the loaded data to the appropriate cell labels
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrDiverInfo objectAtIndex:indexPath.row] objectAtIndex:1]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[self.arrDiverInfo objectAtIndex:indexPath.row] objectAtIndex:4]];
    
    return cell;
}

@end
