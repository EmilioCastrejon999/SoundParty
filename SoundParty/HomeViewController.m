
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

-(void)viewWillAppear:(BOOL)animated{
	 [super viewDidAppear:YES];
	 
	 self.navigationItem.hidesBackButton = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
