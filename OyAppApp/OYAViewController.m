//
//  OYAViewController.m
//  OyAppApp
//
//  Created by Yonatan Kogan on 7/26/14.
//  Copyright (c) 2014 Yonatan. All rights reserved.
//

#import "OYAViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Configs.h"

static const NSUInteger lengthOfPhoneNumber = 12;
static NSString const * oyAppServerUrl = @"http://oy-app-server-staging.herokuapp.com/";
//static NSString const * oyAppServerUrl = "http://localhost:8000/";

@interface OYAViewController ()

@end

@implementation OYAViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)sendOyTapped:(id)sender {
    NSString *numberToOy = self.numberToOy.text;
    if (numberToOy.length != lengthOfPhoneNumber) {
        UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Invalid Phone Number" message:@"" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
        [errorAlert show];
        return;
        //        self.numberToOy.layer.borderColor = [[UIColor redColor] CGColor];
        //        self.numberToOy.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:.8];
    }
    
    self.numberToOy.enabled = NO;
    [self sendOyRequestToServer:numberToOy];

    [UIView animateWithDuration:0.8 animations:^{
        self.numberToOy.alpha = 0.0;
        self.numberToOy.text = @"Success";
        self.numberToOy.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.8 animations:^{
            self.numberToOy.alpha = 0.0;
            self.numberToOy.text = @"";
            self.numberToOy.alpha = 1.0;
        } completion:^(BOOL finished) {
            self.numberToOy.enabled = YES;
        }];
    }];
}

- (void)sendOyRequestToServer:(NSString *)numberToOy {
    NSString *url = [NSString stringWithFormat:@"%@send_oy?to_oy=%@&token=%@", oyAppServerUrl, numberToOy, oyAppServerToken];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    
    [request setHTTPMethod: @"GET"];
    
    NSError *requestError;
    NSURLResponse *urlResponse = nil;
    
    
    NSData *response1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&requestError];
    NSLog (@"%@", response1);
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationPortrait;
}

@end
