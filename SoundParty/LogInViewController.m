//
//  LogInViewController.m
//  SoundParty
//
//  Created by Emilio Castrejon Guerrero on 4/2/18.
//  Copyright © 2018 Opindes. All rights reserved.
//

#import "LogInViewController.h"
#import "AppDelegate.h"

@interface LogInViewController ()

@end

@implementation LogInViewController


-(void)viewWillAppear:(BOOL)animated{
	 [super viewWillAppear:YES];

    /*
	 NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	 
	 if ([prefs objectForKey:@"Usuario"] != nil) {
		  [self performSegueWithIdentifier:@"Home" sender:nil];
	 }
	 */

}

- (void)viewDidLoad {
	 [super viewDidLoad];
	 
	 _PassTxt.delegate = self;
	 _UsrTxt.delegate = self;
	 
	 [self.navigationItem setHidesBackButton:YES];
	 
}


- (IBAction)LogIn:(id)sender {
	 
	 AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
	 
	 if (([_UsrTxt.text isEqualToString:@""]) || ([_PassTxt.text isEqualToString:@""])) {
		  
		  UIAlertController *alert = [UIAlertController
												alertControllerWithTitle:@"Error"
												message:@"Rellene todos los campos"
												preferredStyle:UIAlertControllerStyleAlert];
		  
		  [self presentViewController:alert animated:YES completion:nil];
		  
		  [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer *timer) {
				[self dismissViewControllerAnimated:YES completion:nil];
		  }];
		  
	 }
	 else{
		  
		  ///Usuario Comun//
				
		  NSString *UrlInfo = [NSString stringWithFormat:
		  @"user=%@&password=%@",_UsrTxt.text,_PassTxt.text];
				
		  NSString *Url = [NSString stringWithFormat:
		  @"login.php/?%@",UrlInfo];
				
		  NSString *RespuetaInternet =
		  [appDelegate ResponseFromUrl:Url Async:NO SpinnerColor:[UIColor whiteColor]];
				
		  if ([RespuetaInternet floatValue]) {
								
		  NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
		  [prefs setObject:RespuetaInternet forKey:@"Usuario"];
		  [prefs synchronize];
				
		  _PassTxt.text = @"";
		  _UsrTxt.text = @"";
					 

		  [self performSegueWithIdentifier:@"Home" sender:nil];
          [self.view endEditing:YES];

		  }
		  else{
					 UIAlertController *alert = [UIAlertController
					 alertControllerWithTitle:@"Error"
					 message:RespuetaInternet
					 preferredStyle:UIAlertControllerStyleAlert];
					 
					 [self presentViewController:alert animated:YES completion:nil];
					 
					 [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer *timer) {
						  [self dismissViewControllerAnimated:YES completion:nil];
					 }];
				}
		  }
}

- (IBAction)Contraseña:(id)sender {
	 

	 if ([_UsrTxt.text isEqualToString:@""]) {
		  
		  UIAlertController *alert = [UIAlertController
												alertControllerWithTitle:@"Primero introduzca un usuario"
												message:nil
												preferredStyle:UIAlertControllerStyleAlert];
		  
		  [self presentViewController:alert animated:YES completion:nil];
		  
		  [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer *timer) {
				[self dismissViewControllerAnimated:YES completion:nil];
		  }];
	 }
	 else{
		  
		  UIAlertController *alert =
		  [UIAlertController alertControllerWithTitle:@"For restablish"
														  message: @"Wait an email with information. For you security your user will be invalideted\n Please check the junk in your email"
												 preferredStyle:UIAlertControllerStyleActionSheet];
		  
		  
		  
		  UIAlertAction *Restablecer = [UIAlertAction actionWithTitle:@"Restablecer"
		  style:UIAlertActionStyleDefault
		  handler:^(UIAlertAction * action)
												  {
														
		  AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
														
		  NSString *Url = [NSString stringWithFormat:@"https://opindes.com/RentaEstacionamiento/OlvidoContraseña.php/?user=%@",_UsrTxt.text];
														
		  NSString *RespuetaInternet = [appDelegate ResponseFromUrl:Url Async:NO SpinnerColor:[UIColor whiteColor]];
														
														
														
				if ([RespuetaInternet isEqualToString:@"Email enviado con exito"]) {
					 UIAlertController *alert = [UIAlertController
					 alertControllerWithTitle:RespuetaInternet
					 message:nil
					 preferredStyle:UIAlertControllerStyleAlert];
															 
					 [self presentViewController:alert animated:YES completion:nil];
															 
					 [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer *timer) {
					 [self dismissViewControllerAnimated:YES completion:nil];
					 	}];
					 }
				}];
		  
		  UIAlertAction* noButton = [UIAlertAction actionWithTitle:@"Cancelar"
																			  style:UIAlertActionStyleCancel
																			handler:nil];
		  
		  [alert addAction:Restablecer];
		  [alert addAction:noButton];
		  
		  [self presentViewController:alert animated:YES completion:nil];
	 }
}


-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
	 NSInteger nextTag = textField.tag + 1;
	 // Try to find next responder
	 UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
	 if (nextResponder) {
		  // Found next responder, so set it.
		  [nextResponder becomeFirstResponder];
	 } else {
		  // Not found, so remove keyboard.
		  [self LogIn:nil];
	 }
	 return NO; // We do not want UITextField to insert line-breaks.
}

- (IBAction)Click:(id)sender {
	 
	 [self.view endEditing:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
	 if ([segue.identifier isEqualToString:@"Home"]){
		  [self aumentarContadorUsuario];
	 }
}

-(void)aumentarContadorUsuario{
	 AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
	 
	 NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	 
	 NSString *UrlInfo = [NSString stringWithFormat:@"user=%@",[prefs objectForKey:@"Usuario"]];
	 
	 NSString *Url = [NSString stringWithFormat:@"AumentarContadorUsuario.php/?%@",UrlInfo];
	 
	 [appDelegate ResponseFromUrl:Url Async:YES SpinnerColor:nil];
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
	 if ([identifier isEqualToString:@"Registro"]) {
		  return YES;
	 }
	 return NO;
}


	 


@end
