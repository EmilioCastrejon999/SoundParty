
//
//  HomeViewController.m
//  SoundParty
//
//  Created by Emilio Castrejon Guerrero on 4/2/18.
//  Copyright © 2018 Opindes. All rights reserved.
//

#import "HomeViewController.h"
#import "LogInViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
	 [super viewDidAppear:YES];
	 
	 self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)logOut:(id)sender {
	 NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
     [prefs removeObjectForKey:@"Usuario"];
	 [prefs synchronize];
	 
    LogInViewController *view = [self.storyboard instantiateViewControllerWithIdentifier:@"LogIn"];
	 [self.navigationController pushViewController:view animated:YES];
}

@end
