//
//  SignUpTableViewController.m
//  SoundParty
//
//  Created by Emilio Castrejon Guerrero on 4/2/18.
//  Copyright © 2018 Opindes. All rights reserved.
//

#import "SignUpTableViewController.h"
#import "AppDelegate.h"

@interface SignUpTableViewController ()

@end

@implementation SignUpTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
	 
}

- (IBAction)UpdateDate:(id)sender {
	 
	 _DateLabel.text = [self FechaBonita:_Datebirth.date];
	 
	 NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	 [dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"es_MX"]];
	 dateFormatter.dateFormat = @"YYYY-MM-dd";
	 }

	 -(NSString *)FechaBonita :(NSDate *)date{
		  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
		  [dateFormatter setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"es_MX"]];
		  
		  dateFormatter.dateFormat = [NSDateFormatter dateFormatFromTemplate:@"EEEE" options:0 locale:[[NSLocale alloc]initWithLocaleIdentifier:@"es_MX"]];
		  
		  NSString *DiaNombre = [[dateFormatter stringFromDate:date]capitalizedString];
		  
		  dateFormatter.dateFormat = @"dd";
		  NSString *DiaNumero = [dateFormatter stringFromDate:date];
		  
		  dateFormatter.dateFormat = @"MMMM";
		  NSString *Mes = [[dateFormatter stringFromDate:date]capitalizedString];
		  
		  dateFormatter.dateFormat = @"YYYY";
		  NSString *Año = [dateFormatter stringFromDate:date];
		  
		  NSString *FechaFinal = [NSString stringWithFormat:@"%@, %@ de %@ de %@",DiaNombre,DiaNumero,Mes,Año];
		  
		  return FechaFinal;
}


- (IBAction)SignUp:(id)sender {
	 
	 [self RemoveWhiteSpaces:_textfields];
	 
		  if ([_UserTxt.text isEqualToString:@""] || [_NombreTxt.text isEqualToString:@""] ||[_PasswordText.text isEqualToString:@""] ||[_EmailTxt.text isEqualToString:@""]  ||[_CellTxt.text isEqualToString:@""]) {
				
				UIAlertController *alert = [UIAlertController
				alertControllerWithTitle:@"Introduzca todos los valores"
				message:nil
				preferredStyle:UIAlertControllerStyleAlert];
				
				[self presentViewController:alert animated:YES completion:nil];
				
				[NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer *timer) {
					 [self dismissViewControllerAnimated:YES completion:nil];
				}];
				
		  }
		  else{

		  _CellTxt.text = [self prepareNumber:_CellTxt.text];
				
		  _NombreTxt.text = [self prepareString:_NombreTxt.text];
		  _UserTxt.text = [self prepareString:_UserTxt.text];

		  
		  
		  if ([self validateNumberOnly:_CellTxt.text] == NO){
				
				UIAlertController *alert = [UIAlertController
													 alertControllerWithTitle:@"Algun valor numerico contiene letras"
													 message:nil
													 preferredStyle:UIAlertControllerStyleAlert];
				
				[self presentViewController:alert animated:YES completion:nil];
				
				[NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer *timer) {
					 [self dismissViewControllerAnimated:YES completion:nil];
				}];
				return;
		  }
		  
		  if ([_CellTxt.text length] < 10){
				UIAlertController *alert = [UIAlertController
				alertControllerWithTitle:@"Numero telefonico invalido"
				message:nil
				preferredStyle:UIAlertControllerStyleAlert];
				
				[self presentViewController:alert animated:YES completion:nil];
				
				[NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer *timer) {
					 [self dismissViewControllerAnimated:YES completion:nil];
				}];
				return;
		  }
		  
		  if ([self validateEmail:_EmailTxt.text] == NO) {
				UIAlertController *alert = [UIAlertController
													 alertControllerWithTitle:@"Formato de email incorrecto"
													 message:nil
													 preferredStyle:UIAlertControllerStyleAlert];
				
				[self presentViewController:alert animated:YES completion:nil];
				
				[NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer *timer) {
					 [self dismissViewControllerAnimated:YES completion:nil];
				}];
				return;
		  }
		  
		  if ([self ValidatePassword:_PasswordText.text] == NO) {
				UIAlertController *alert = [UIAlertController
													 alertControllerWithTitle:@"Contraseña Incorrecta"
													 message:@"La contraseña debe contener más de 6 caracteres, un numero y una letra"
													 preferredStyle:UIAlertControllerStyleAlert];
				
				[self presentViewController:alert animated:YES completion:nil];
				
				[NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer *timer) {
					 [self dismissViewControllerAnimated:YES completion:nil];
				}];
				return;
		  }}
	 
	 [self MandarInfoToBD];
	 
}

-(void)MandarInfoToBD{
	 AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
	 
	 if ([_DateLabel.text isEqualToString:@"Birth date: (optional)"]) {
		  _DateLabel.text = @"";
	 }
	 
	 NSString *Url = [NSString stringWithFormat:@"Signup.php/?usuario=%@&codigo=%@&nombre=%@&email=%@&telcel=%@&edad=%@",
	 _UserTxt.text,_PasswordText.text,_NombreTxt.text,_EmailTxt.text,_CellTxt.text,_DateLabel.text];
	 
	 NSString *RespuetaInternet = [appDelegate ResponseFromUrl:Url Async:NO SpinnerColor:[UIColor whiteColor]];
	 
	 UIAlertController *alert = [UIAlertController
										  alertControllerWithTitle:RespuetaInternet
										  message:nil
										  preferredStyle:UIAlertControllerStyleAlert];
	 
	 [self presentViewController:alert animated:YES completion:nil];
	 
	 [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer *timer) {
		  [self dismissViewControllerAnimated:YES completion:nil];
	 }];
	 
}

-(void)RemoveWhiteSpaces:(NSArray *)allTextFields{
	 
	 NSMutableArray *textFieldExtraClean = [[NSMutableArray alloc]init];
	 
	 for(UITextField *TextField in allTextFields){
		  if (![TextField.text isEqualToString:@""]) {
				
				NSString *LastCharacter = [TextField.text substringFromIndex:[TextField.text length]-1];
				NSString *FirstCharacter = [TextField.text substringToIndex:1];
				
				if ([LastCharacter isEqualToString:@" "]){
					 NSString *NewString =
					 [TextField.text substringToIndex:[TextField.text length]-1];
					 [TextField setText:NewString];
					 [textFieldExtraClean addObject:TextField];}
				
				if ([FirstCharacter isEqualToString:@" "]) {
					 NSString *NewString =
					 [TextField.text substringFromIndex:[TextField.text length]-1];
					 [TextField setText:NewString];
					 [textFieldExtraClean addObject:TextField];}
				[self RemoveWhiteSpaces:textFieldExtraClean];
		  }
	 }
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
	 
	 NSInteger nextTag = textField.tag + 1;
	 // Try to find next responder
	 UIResponder* nextResponder = [_textfields objectAtIndex:nextTag];
	 
	 if (nextTag < [_textfields count]) {
		  // Found next responder, so set it.
		  [nextResponder becomeFirstResponder];
	 } else {
		  // Not found, so remove keyboard.
		  [self.view endEditing:YES];
	 }
	 return NO; // We do not want UITextField to insert line-breaks.
}


- (BOOL)validateNumberOnly:(NSString *)Number
{
	 NSCharacterSet *numbersOnly = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
	 NSCharacterSet *characterSetFromTextField = [NSCharacterSet characterSetWithCharactersInString:Number];
	 
	 return [numbersOnly isSupersetOfSet:characterSetFromTextField];
	 
}

-(BOOL)ValidatePassword:(NSString *)pwd{
	 
	 
	 if ( [pwd length] < 6 ) return NO;  // too long or too short
	 NSRange rang;
	 rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]];
	 if ( !rang.length ) return NO;  // no letter
	 rang = [pwd rangeOfCharacterFromSet:[NSCharacterSet decimalDigitCharacterSet]];
	 if ( !rang.length )  return NO;  // no number;
	 return YES;
}

- (BOOL)validateEmail:(NSString *)emailStr {
	 if ([emailStr containsString:@"@"] && [emailStr containsString:@"."] && emailStr.length > 9) {
		  return  YES;
	 }
	 else{
		  return NO;
	 }
}

-(NSString *) prepareNumber:(NSString *)number {
	 
	 NSString *numberWWS = [number stringByReplacingOccurrencesOfString:@" " withString:@""];
	 
	 return numberWWS;
}

-(NSString *) prepareString:(NSString *)string {
	 
	 NSString *unaccentedString = [string stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
	 
	 return unaccentedString;
}

@end

