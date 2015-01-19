//
//  UIViewController+DiverDetailsVC.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/2/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiverDetailsVC.h"
#import "Diver.h"
#import "AppDelegate.h"
#import "DiverHistory.h"
#import "JudgeScores.h"

@interface DiverDetailsVC ()

@property (nonatomic, strong) NSArray *arrDiverInfo;

-(void)loadData;
-(void)TabBarSelection;

@end

@implementation DiverDetailsVC

@synthesize recordIDToEdit;

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
    
    [self TabBarSelection];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self loadData];
}

// make this viewcontroller the delegate of the MeetEdit ViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"idSegueEditInfo"]) {
        DiverEdit *diverEdit = [segue destinationViewController];
        diverEdit.delegate = self;
        
        // send the id to the MeetEdit VC
        diverEdit.recordIDToEdit = self.recordIDToEdit;
    }
    
    // send the id to the MeetHistory
    if ([segue.identifier isEqualToString:@"idSegueDiverHistory"]) {
        DiverHistory *history = [segue destinationViewController];
        
        history.recordIdToEdit = self.recordIDToEdit;
    }
}


-(IBAction)unwindToDiverDetails:(UIStoryboardSegue *)segue{
    
}

//// handles the return click
//-(IBAction)returnClick:(id)sender {
//    
//    [self performSegueWithIdentifier:@"idDiverDetailToHome" sender:self];
//}

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


// keeps the color of the selected cell the same -
// in Ipad because of some unknown apple logic
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL check;
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    check = [scores MeetsWithScores];
    
    if (check) {
    
        self.recordIDToEdit = [[[self.arrDiverInfo objectAtIndex:indexPath.row] objectAtIndex:0] intValue];
        
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed:.50 green:.50 blue:.50 alpha:1];
        
        [self performSegueWithIdentifier:@"idSegueDiverHistory" sender:self];
        
    } else {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"There are no meets with scores yet"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
        
        [self.tblDivers reloadData];
        
    }
    
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
    return self.arrDiverInfo.count;
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
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[self.arrDiverInfo objectAtIndex:indexPath.row] objectAtIndex:1]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[self.arrDiverInfo objectAtIndex:indexPath.row] objectAtIndex:4]];
    
    return cell;
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

-(void)TabBarSelection {
    
    UIColor *backgroundColor = [UIColor colorWithRed:.50 green:.50 blue:.50 alpha:1];
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
    [[UITabBar appearance] setBackgroundColor:[UIColor darkGrayColor]];
    
    // set the dark color to the selected tab
    [[UITabBar appearance] setSelectionIndicatorImage:[AppDelegate imageFromColor:[UIColor colorWithRed:.40 green:.40 blue:.40 alpha:1] forSize:CGSizeMake(screenWidth / 2, 49) withCornerRadius:0]];
}

@end
