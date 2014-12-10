//
//  HomeViewController.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 10/30/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "HomeViewController.h"
#import "JudgeScores.h"
#import "Meet.h"
#import "Diver.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // drop shadow for the buttons
    self.btnQuick.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnQuick.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnQuick.layer.masksToBounds = NO;
    self.btnQuick.layer.shadowOpacity = .5;
    
    self.btnMeetsDivers.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnMeetsDivers.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnMeetsDivers.layer.masksToBounds = NO;
    self.btnMeetsDivers.layer.shadowOpacity = .5;
    
    self.btnReports.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnReports.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnReports.layer.masksToBounds = NO;
    self.btnReports.layer.shadowOpacity = .5;
    
    self.btnDetailed.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnDetailed.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnDetailed.layer.masksToBounds = NO;
    self.btnDetailed.layer.shadowOpacity = .5;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindToMainMenu:(UIStoryboardSegue *)segue{
    
}

- (IBAction)btnReportClick:(id)sender {
    
    BOOL check;
    JudgeScores *scores = [[JudgeScores alloc] init];
    
    check = [scores MeetsWithScores];
    
    if (check) {
        
        [self performSegueWithIdentifier:@"idSegueHomeToReports" sender:self];
        
    } else {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                      message:@"There are no meets with scores yet"
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
      [error show];
      [error reloadInputViews];
        
    }
}

- (IBAction)btnDetailedScoringClick:(id)sender {
    
    NSArray *meets;
    NSArray *divers;
    
    Meet *meet = [[Meet alloc] init];
    Diver *diver = [[Diver alloc] init];
    
    meets = [meet GetAllMeets];
    divers = [diver GetAllDivers];
    
    if (meets.count > 0 && divers.count > 0) {
        
        [self performSegueWithIdentifier:@"idSegueHomeToChooseMeet" sender:self];
        
    } else {
        
        UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Hold On!"
                                                        message:@"Add at least one meet and one diver to go here."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [error show];
        [error reloadInputViews];
        
    }
}
@end
