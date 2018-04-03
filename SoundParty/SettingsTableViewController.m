//
//  SettingsTableViewController.m
//  SoundParty
//
//  Created by Emilio Castrejon Guerrero on 4/2/18.
//  Copyright © 2018 Opindes. All rights reserved.
//

#import "SettingsTableViewController.h"
#import "AppDelegate.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	 if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		  
		  UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
																				  message:@"Device has no camera"
																				 delegate:nil
																	 cancelButtonTitle:@"OK"
																	 otherButtonTitles: nil];
		  
		  [myAlertView show];
		  
	 }
    
}
- (IBAction)takePhoto:(UIButton *)sender {
	 UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	 picker.delegate = self;
	 picker.allowsEditing = YES;
	 picker.sourceType = UIImagePickerControllerSourceTypeCamera;
	 
	 [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)usePhoto:(UIButton *)sender {
	 UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	 picker.delegate = self;
	 picker.allowsEditing = YES;
	 picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	 
	 [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	 
	 UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
	 self.imageView.image = chosenImage;
	 
	 [picker dismissViewControllerAnimated:YES completion:NULL];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	 
	 [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)ChangeName:(id)sender {
	 AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
	 
	 NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	 
	 NSString *UrlInfo = [NSString stringWithFormat:@"userid=%@&nombre=%@&user=%@",[prefs objectForKey:@"Usuario"],_Nombretxt.text, _Usuariotxt.text];
	 
	 NSString *Url = [NSString stringWithFormat:@"Settings.php/?%@",UrlInfo];
	 
	NSString *Response =  [appDelegate ResponseFromUrl:Url Async:YES SpinnerColor:nil];
	 
	 if ([Response isEqualToString:@"Modificado"]) {
		  UIAlertController *alert = [UIAlertController
												alertControllerWithTitle:@"Ready"
												message:@"the info has been updated successfully"
												preferredStyle:UIAlertControllerStyleAlert];
		  
		  [self presentViewController:alert animated:YES completion:nil];
		  
		  [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer *timer) {
				[self dismissViewControllerAnimated:YES completion:nil];
		  }];
		  
		  [self.navigationController popViewControllerAnimated:YES];
	 }
}



@end
