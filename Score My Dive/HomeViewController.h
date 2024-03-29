//
//  ViewController.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 10/30/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface HomeViewController : UIViewController <MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnQuick;
@property (weak, nonatomic) IBOutlet UIButton *btnMeetsDivers;
@property (weak, nonatomic) IBOutlet UIButton *btnReports;
@property (weak, nonatomic) IBOutlet UIButton *btnDetailed;

- (IBAction)btnReportClick:(id)sender;
- (IBAction)btnDetailedScoringClick:(id)sender;
- (IBAction)btnMeetDiverClick:(id)sender;
- (IBAction)btnQuickScoreClick:(id)sender;
- (IBAction)btnAboutClick:(id)sender;

@end

