//
//  YouTubeWebViewViewController.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 1/23/15.
//  Copyright (c) 2015 SingleCog Software. All rights reserved.
//

#import "YouTubeWebViewViewController.h"

@interface YouTubeWebViewViewController ()

@end

@implementation YouTubeWebViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //load url into webview
    NSString *strURL = @"http://youtu.be/ndOXhtE_2hs";
    NSURL *url = [NSURL URLWithString:strURL];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
