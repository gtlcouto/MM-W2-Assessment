//
//  WebViewController.m
//  cityTableView
//
//  Created by Gustavo Couto on 2015-01-16.
//  Copyright (c) 2015 Gustavo Couto. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end

@implementation WebViewController

#pragma mark - View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = self;

    [self goToURLWithString:[self generateProperStringForURL]];

}

#pragma mark - Delegate Methods

//starting spinner when loading
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.spinner.hidden = NO;
    [self.spinner startAnimating];

}

//ending spinner when finished loading
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.spinner stopAnimating];
    self.spinner.hidden = YES;
}


#pragma mark - IBActions
//back button pressed - dismisses current view
- (IBAction)onBackButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - Helper Methods
//Helper method: Loads page using URL string
- (void) goToURLWithString:(NSString *)string
{
    if (![string hasPrefix:@"http://"])
    {
        string = [NSString stringWithFormat:@"http://%@", string];
    }

    NSURL *addressUrl = [NSURL URLWithString:string];
    NSURLRequest *addressRequest = [NSURLRequest requestWithURL:addressUrl];
    [self.webView loadRequest:addressRequest];
    
}

//helper method: replaces black spaces with underlines in order to get to the correct URL
-(NSString *)generateProperStringForURL
{
    NSString * string1 = [NSString stringWithFormat:@"http://en.wikipedia.org/wiki/%@", self.selectedCity.name];
    NSString * returnString = [string1 stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    return returnString;

}

@end
