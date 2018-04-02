//
//  PDFReaderViewController.m
//  SoundParty
//
//  Created by Silvestre Castrejon Sanchez on 02/04/18.
//  Copyright © 2018 Opindes. All rights reserved.
//

#import "PDFReaderViewController.h"

@interface PDFReaderViewController ()

@end

@implementation PDFReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *targetURL = [[NSBundle mainBundle] URLForResource:@"Terminos_Condiciones" withExtension:@"pdf"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    
    [_PDFView loadRequest:request];
}

@end
