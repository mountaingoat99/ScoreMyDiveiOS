//
//  DiveListChoose.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/20/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveListChoose.h"
#import "MeetCollection.h"
#import "Meet.h"
#import "Judges.h"

@interface DiveListChoose ()

-(void)GetCollectionofMeetInfo;

@end

@implementation DiveListChoose

#pragma viewController methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // lets grab all the meet info first
    [self GetCollectionofMeetInfo];
    
    // sets up the following delegate method to disable horizontal scrolling
    // don't forget to declare the UIScrollViewDelegate in the .h file
    self.scrollView.delegate = self;
    
}

// stops horitontal scrolling
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    scrollView.contentOffset = CGPointMake(0, scrollView.contentOffset.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma private methods

-(void)GetCollectionofMeetInfo {
    
    MeetCollection *meetCollection = [[MeetCollection alloc] init];
    
    self.meetInfo = [meetCollection GetMeetAndDiverInfo:self.meetRecordID diverid:self.diverRecordID];
    
    // doing this to test and log that we get the correct data
    Meet *testMeet = [[Meet alloc] init];
    Judges *testJudges = [[Judges alloc] init];
    
    testMeet = [self.meetInfo objectAtIndex:0];
    testJudges = [self.meetInfo objectAtIndex:1];
    
    // here we just want to let the log know we have the correct meet chosen
    NSString *test = testMeet.meetID;
    NSString *testName = testMeet.meetName;
    NSString *testSchool = testMeet.schoolName;
    NSString *testCity = testMeet.city;
    NSString *testState = testMeet.state;
    NSString *testDate = testMeet.date;
    NSNumber *testJudgeTotal = testJudges.judgeTotal;
    
    NSLog(@"the meetid is %@", test);
    NSLog(@"the meetname is %@", testName);
    NSLog(@"the meetschool is %@", testSchool);
    NSLog(@"the meetcity is %@", testCity);
    NSLog(@"the meetstate is %@", testState);
    NSLog(@"the meetdate is %@", testDate);
    NSLog(@"the judgetotal is %@", testJudgeTotal);
    
}

@end
