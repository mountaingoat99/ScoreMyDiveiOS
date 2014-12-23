//
//  DiveListScore.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 12/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "DiveListScore.h"
#import "ValidScores.h"

@interface DiveListScore ()

@property (nonatomic, strong) NSNumber *judgesTotal;
@property (nonatomic, strong) NSArray *validScores;

-(void)whatJudgeTotal;
-(void)ScoreOptions;

@end

@implementation DiveListScore

#pragma View Controller methods

- (void)viewDidLoad {
    [super viewDidLoad];

    [self whatJudgeTotal];
    
    self.txtScore1.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtScore1.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtScore1.layer.masksToBounds = NO;
    self.txtScore1.layer.shadowRadius = 4.0f;
    self.txtScore1.layer.shadowOpacity = .3;
    self.txtScore1.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtScore1.keyboardType = UIKeyboardTypeDecimalPad;
    self.txtScore1.delegate = self;
    
    self.txtScore2.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtScore2.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtScore2.layer.masksToBounds = NO;
    self.txtScore2.layer.shadowRadius = 4.0f;
    self.txtScore2.layer.shadowOpacity = .3;
    self.txtScore2.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtScore2.keyboardType = UIKeyboardTypeDecimalPad;
    self.txtScore2.delegate = self;
    
    self.txtScore3.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtScore3.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtScore3.layer.masksToBounds = NO;
    self.txtScore3.layer.shadowRadius = 4.0f;
    self.txtScore3.layer.shadowOpacity = .3;
    self.txtScore3.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtScore3.keyboardType = UIKeyboardTypeDecimalPad;
    self.txtScore3.delegate = self;
    
    self.txtScore4.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtScore4.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtScore4.layer.masksToBounds = NO;
    self.txtScore4.layer.shadowRadius = 4.0f;
    self.txtScore4.layer.shadowOpacity = .3;
    self.txtScore4.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtScore4.keyboardType = UIKeyboardTypeDecimalPad;
    self.txtScore4.delegate = self;
    
    self.txtScore5.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtScore5.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtScore5.layer.masksToBounds = NO;
    self.txtScore5.layer.shadowRadius = 4.0f;
    self.txtScore5.layer.shadowOpacity = .3;
    self.txtScore5.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtScore5.keyboardType = UIKeyboardTypeDecimalPad;
    self.txtScore5.delegate = self;
    
    self.txtScore6.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtScore6.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtScore6.layer.masksToBounds = NO;
    self.txtScore6.layer.shadowRadius = 4.0f;
    self.txtScore6.layer.shadowOpacity = .3;
    self.txtScore6.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtScore6.keyboardType = UIKeyboardTypeDecimalPad;
    self.txtScore6.delegate = self;
    
    self.txtScore7.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtScore7.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtScore7.layer.masksToBounds = NO;
    self.txtScore7.layer.shadowRadius = 4.0f;
    self.txtScore7.layer.shadowOpacity = .3;
    self.txtScore7.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtScore7.keyboardType = UIKeyboardTypeDecimalPad;
    self.txtScore7.delegate = self;
    
    self.txtScore8.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtScore8.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtScore8.layer.masksToBounds = NO;
    self.txtScore8.layer.shadowRadius = 4.0f;
    self.txtScore8.layer.shadowOpacity = .3;
    self.txtScore8.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtScore8.keyboardType = UIKeyboardTypeDecimalPad;
    self.txtScore8.delegate = self;
    
    self.txtScore9.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtScore9.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtScore9.layer.masksToBounds = NO;
    self.txtScore9.layer.shadowRadius = 4.0f;
    self.txtScore9.layer.shadowOpacity = .3;
    self.txtScore9.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtScore9.keyboardType = UIKeyboardTypeDecimalPad;
    self.txtScore9.delegate = self;
    
    self.txtScore10.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtScore10.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtScore10.layer.masksToBounds = NO;
    self.txtScore10.layer.shadowRadius = 4.0f;
    self.txtScore10.layer.shadowOpacity = .3;
    self.txtScore10.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtScore10.delegate = self;
    
    self.txtScore11.layer.shadowColor = [UIColor blackColor].CGColor;
    self.txtScore11.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.txtScore11.layer.masksToBounds = NO;
    self.txtScore11.layer.shadowRadius = 4.0f;
    self.txtScore11.layer.shadowOpacity = .3;
    self.txtScore11.keyboardAppearance = UIKeyboardAppearanceDark;
    self.txtScore11.keyboardType = UIKeyboardTypeDecimalPad;
    self.txtScore11.delegate = self;
    
    self.btnTotal.layer.shadowColor = [UIColor blackColor].CGColor;
    self.btnTotal.layer.shadowOffset = CGSizeMake(.1f, .1f);
    self.btnTotal.layer.masksToBounds = NO;
    self.btnTotal.layer.shadowOpacity = .7;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// hide the keyboard on outside touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (IBAction)btnTotalClick:(id)sender {
    
}

- (IBAction)btnFailedClick:(id)sender {
    
}

#pragma private methods
-(void)whatJudgeTotal {
    
}

-(void)ScoreOptions {
    
    ValidScores *score = [[ValidScores alloc] init];
    self.validScores = [score GetValidScores];
    
}


@end
