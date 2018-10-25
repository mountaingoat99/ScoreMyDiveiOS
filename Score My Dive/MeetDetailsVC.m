//
//  UIViewController+MeetDetailsVC.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/2/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "MeetDetailsVC.h"
#import "Meet.h"
#import "MeetHistory.h"
#import "AppDelegate.h"
#import "JudgeScores.h"
#import "AlertControllerHelper.h"
#import "AppDelegate.h"

@interface MeetDetailsVC ()

@property (nonatomic) int recordIDToEdit;

@property (nonatomic, strong) NSArray *arrMeetInfo;

-(void)loadData;
-(void)TabBarSelection;

@end

@implementation MeetDetailsVC

@synthesize recordIDToEdit;

#pragma mark - UIViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    [self restrictRotation:YES];
    
    self.tblMeets.delegate = self;
    self.tblMeets.dataSource = self;
    
    // drop shadow for the table
    self.tblMeets.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tblMeets.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.tblMeets.layer.masksToBounds = NO;
    self.tblMeets.layer.shadowOpacity = 1.0;
    [self.tblMeets setSeparatorColor:[UIColor blackColor]];
    
    [self TabBarSelection];
    
     [self loadData];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

// only allow portrait in iphone
-(void) restrictRotation:(BOOL) restriction
{
    AppDelegate* appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    appDelegate.restrictRotation = restriction;
}

// push the meetId to the next controller
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // send the id to the MeetEdit
    if ([segue.identifier isEqualToString:@"idSegueEditInfo"]) {
        MeetEdit *meetEdit = [segue destinationViewController];
        meetEdit.delegate = self;
        
        // send the id to the MeetEdit VC
        meetEdit.recordIDToEdit = self.recordIDToEdit;
    }
    
    // send the id to the MeetHistory
    if ([segue.identifier isEqualToString:@"idSegueMeetHistory"]) {
        MeetHistory *history = [segue destinationViewController];
        
        history.recordIDToEdit = self.recordIDToEdit;
    }
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

// keeps the color of the selected cell the same -
// in Ipad because of some unknown apple logic
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL check;
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    check = [scores MeetsWithScores];
    
    if (check) {
        
        self.recordIDToEdit = [[[self.arrMeetInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
        
        [self performSegueWithIdentifier:@"idSegueMeetHistory" sender:self];
        
    } else {
        
        [AlertControllerHelper ShowAlert:@"Hold On!" message:@"There are no meets with scores yet" view:self];
        [self.tblMeets reloadData];
        
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
    return self.arrMeetInfo.count;
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrMeetInfo objectAtIndex:indexPath.row] objectAtIndex:1]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[self.arrMeetInfo objectAtIndex:indexPath.row] objectAtIndex:5]];
    
    return cell;
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

-(void)TabBarSelection {
    
    UIColor *backgroundColor = [UIColor colorWithRed:.45 green:.79 blue:1.0 alpha:1];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    //CGFloat screenHeight = screenRect.size.height;
    
    // sets the background color
    [[UITabBar appearance] setBackgroundImage:[AppDelegate imageFromColor:backgroundColor forSize:CGSizeMake(screenWidth, 49) withCornerRadius:0]];
    
    // set the text color for selected state
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor blackColor], NSForegroundColorAttributeName,
                                                       [UIFont systemFontOfSize:16.0f], NSFontAttributeName, nil]forState:UIControlStateSelected];
    // set the text color for unselected state
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], NSForegroundColorAttributeName,
                                                       [UIFont systemFontOfSize:16.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    // set the selected icon color
    [[UITabBar appearance] setTintColor:[UIColor blackColor]];
    [[UITabBar appearance] setBackgroundColor:[UIColor blackColor]];
    
    // set the dark color to the selected tab
    [[UITabBar appearance] setSelectionIndicatorImage:[AppDelegate imageFromColor:[UIColor colorWithRed:.45 green:.79 blue:1.0 alpha:1] forSize:CGSizeMake(screenWidth / 2, 49) withCornerRadius:0]];
}

@end
