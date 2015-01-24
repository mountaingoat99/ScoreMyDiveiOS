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

-(void)OpenYouTube;
-(void)sendEmail;
-(void)canceledEmail;
-(void)SentEmail;
-(void)FailedEmail;

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

// only allow portrait in iphone
-(BOOL)shouldAutorotate {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        
        return NO;
        
    } else {
        
        return YES;
    }
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

- (IBAction)btnMeetDiverClick:(id)sender {
    
    [self performSegueWithIdentifier:@"idSegueToMeetDivers" sender:self];
}

- (IBAction)btnQuickScoreClick:(id)sender {
    
    [self performSegueWithIdentifier:@"idSegueHomeToQuickScore" sender:self];
}

- (IBAction)btnAboutClick:(id)sender {
    
    // updated alertController for iOS 8
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:@"Contact"
                                          message:@"Thanks for using my app. Please email me if you have any questions or recommendations."
                                          preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                       NSLog(@"Cancel Action");
                                   }];
    
    UIAlertAction *Email = [UIAlertAction
                                       actionWithTitle:@"Email"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           [self sendEmail];
                                       }];
    
    UIAlertAction *Youtube = [UIAlertAction
                                       actionWithTitle:@"How-To Video"
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction *action)
                                       {
                                           [self OpenYouTube];
                                       }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:Email];
    [alertController addAction:Youtube];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

// go to Youtube Link
-(void)OpenYouTube {
    
    
    
    [self performSegueWithIdentifier:@"idSegueToWebView" sender:self];
    
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://youtu.be/ndOXhtE_2hs"]];
    
}

// Email
-(void)sendEmail {
    
    NSString *EmailTo = @"jeremey.rodriguez@outlook.com";
    NSString *subject = @"Score My Dive Feedback";
    
    MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
    composer.mailComposeDelegate = self;
    [composer setToRecipients:@[EmailTo]];
    [composer setSubject:subject];
    

    
    // present it on the screen
    [self presentViewController:composer animated:YES completion:nil];
    
}

// delegate method
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            [self canceledEmail];
            break;
        case MFMailComposeResultSent:
            [self SentEmail];
            break;
        case MFMailComposeResultFailed:
            [self FailedEmail];
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
  // filling up
}

-(void)canceledEmail {
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Email Cancelled"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [error show];
    [error reloadInputViews];
    
}

-(void)SentEmail {
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Email Sent"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [error show];
    [error reloadInputViews];
    
}

-(void)FailedEmail {
    
    UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Email Failed"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [error show];
    [error reloadInputViews];
    
}

@end
