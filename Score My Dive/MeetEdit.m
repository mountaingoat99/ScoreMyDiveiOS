//
//  MeetEdit.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/11/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "MeetEdit.h"
#import "DBManager.h"

@interface MeetEdit ()

@property (nonatomic, strong) DBManager *dbManager;

@end

@implementation MeetEdit

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.txtMeetName.delegate = self;
    self.txtSchool.delegate = self;
    self.txtCity.delegate = self;
    self.txtState.delegate = self;
    
    self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"dive_dod.db"];
}

// handles the return button
-(IBAction)unwindAddMeet:(UIStoryboardSegue *)segue{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

// database insert
-(IBAction)saveInfo:(id)sender{
    // prepare the query string
    NSString *query = [NSString stringWithFormat:@"insert into meet(name, school, city, state, date) values('%@', '%@', '%@', '%@', null)", self.txtMeetName.text, self.txtSchool.text, self.txtCity.text, self.txtState.text];
    
    // execute the query
    [self.dbManager executeQuery:query];
    
    // if the query was succesfully executed then pop the view controller
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected Rows = %d", self.dbManager.affectedRows);
        
        // pop the view controller
        //[self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        NSLog(@"Could not execute the query");
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
