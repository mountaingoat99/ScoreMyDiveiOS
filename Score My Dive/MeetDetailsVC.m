//
//  UIViewController+MeetDetailsVC.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/2/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "MeetDetailsVC.h"

@interface MeetDetailsVC ()


@end

@implementation MeetDetailsVC

#pragma mark - UIViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    // drop shadow for the table
    self.tblPeople.layer.shadowColor = [UIColor blackColor].CGColor;
    self.tblPeople.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    self.tblPeople.layer.masksToBounds = NO;
    self.tblPeople.layer.shadowRadius = 4.0f;
    self.tblPeople.layer.shadowOpacity = 1.0;
    
}

// handles the return button
-(IBAction)unwindToMeetDetails:(UIStoryboardSegue *)segue{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
