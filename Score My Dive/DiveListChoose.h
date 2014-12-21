//
//  DiveListChoose.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/20/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiveListChoose : UIViewController <UIScrollViewDelegate>

@property (nonatomic) int meetRecordID;
@property (nonatomic) int diverRecordID;
@property (nonatomic, strong) NSArray *meetInfo;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
