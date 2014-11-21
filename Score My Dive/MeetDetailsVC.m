//
//  UIViewController+MeetDetailsVC.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/2/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "MeetDetailsVC.h"
#import "Meet.h"

@interface MeetDetailsVC ()

@property (nonatomic) int recordIDToEdit;

@property (nonatomic, strong) NSArray *arrMeetInfo;

-(void)loadData;

@end

@implementation MeetDetailsVC

#pragma mark - UIViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblMeets.delegate = self;
    self.tblMeets.dataSource = self;
    
    // drop shadow for the table
    self.tblMeets.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tblMeets.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.tblMeets.layer.masksToBounds = NO;
    self.tblMeets.layer.shadowRadius = 4.0f;
    self.tblMeets.layer.shadowOpacity = 1.0;
    
    [self loadData];
    
}

// handles the return button from meetEdit
-(IBAction)unwindToMeetDetails:(UIStoryboardSegue *)segue{
    
}

// handles the return click
-(IBAction)returnClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addNewRecord:(id)sender {
    self.recordIDToEdit = -1;
    
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

// delete a row
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // delete the selected record find the record id
        int recordIDToDelete = [[[self.arrMeetInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
        
        // call the class method to delete a record
         Meet *meets = [[Meet alloc] init];
        [meets DeleteMeet:recordIDToDelete];
        
        //reload the table view
        [self loadData];
    }
}

// calls the cell to edit
-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    // get the record ID of the selected name and set to the recordIDToEdit property
    self.recordIDToEdit = [[[self.arrMeetInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
    
    // perform the segue
    [self performSegueWithIdentifier:@"idSegueEditInfo" sender:self];
}

// make this viewcontroller the delegate of the MeetEdit ViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MeetEdit *meetEdit = [segue destinationViewController];
    meetEdit.delegate = self;
    
    // send the id to the MeetEdit VC
    meetEdit.recordIDToEdit = self.recordIDToEdit;
}

// delegate method to update info after the edit info is popped off
-(void)editInfoWasFinished{
    [self loadData];
}

#pragma private methods
-(void)loadData{
    
    // get the result
    if(self.arrMeetInfo != nil){
        self.arrMeetInfo = nil;
    }
    
    // call the class method to load the data
    Meet *meets = [[Meet alloc] init];
    self.arrMeetInfo = [meets GetAllMeets];
    
    // reload the table
    [self.tblMeets reloadData];
}

// tells the tableView we want to have just one section
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// specifies the total number of rows displayed in the table view
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrMeetInfo.count;
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrMeetInfo objectAtIndex:indexPath.row] objectAtIndex:1]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[self.arrMeetInfo objectAtIndex:indexPath.row] objectAtIndex:5]];
    
    return cell;
}

@end
