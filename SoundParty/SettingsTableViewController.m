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
-(void)ChangeNombre{
	 AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
	 
	 
	 
}



@end
