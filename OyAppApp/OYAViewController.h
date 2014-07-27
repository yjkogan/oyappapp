//
//  OYAViewController.h
//  OyAppApp
//
//  Created by Yonatan Kogan on 7/26/14.
//  Copyright (c) 2014 Yonatan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OYAViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *numberToOy;

- (IBAction)sendOyTapped:(id)sender;

@end
