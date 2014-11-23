//
//  ChooseMeet.h
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 11/22/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseMeet : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *txtChooseMeet;

- (IBAction)nextClick:(id)sender;

@end
