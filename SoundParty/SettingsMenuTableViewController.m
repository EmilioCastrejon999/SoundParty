//
//  SettingsMenuTableViewController.m
//  SoundParty
//
//  Created by Silvestre Castrejon Sanchez on 03/04/18.
//  Copyright © 2018 Opindes. All rights reserved.
//

#import "SettingsMenuTableViewController.h"
#import "LogInViewController.h"

@interface SettingsMenuTableViewController ()

@end

@implementation SettingsMenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)logOut:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs removeObjectForKey:@"Usuario"];
    [prefs synchronize];
    
    LogInViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"LogIn"];
    [self.navigationController pushViewController:view animated:YES];
}

@end
