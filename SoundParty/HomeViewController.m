
//
//  HomeViewController.m
//  SoundParty
//
//  Created by Emilio Castrejon Guerrero on 4/2/18.
//  Copyright © 2018 Opindes. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

-(void)viewDidAppear:(BOOL)animated{
	 [super viewDidAppear:YES];
	 
	 self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)logOut:(id)sender {
	 NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	 [prefs setObject:nil forKey:@"Usuario"];
	 [prefs synchronize];
	 
	 [self.navigationController popViewControllerAnimated:YES];
}

@end
