//
//  MeetHistory.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/27/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeetHistory : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int recordIDToEdit;
@property (nonatomic) int diverid;
@property (nonatomic) int callingIdToReturnTo;

@property (weak, nonatomic) IBOutlet UITableView *tblHistory;


@end
