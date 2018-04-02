//
//  SignUpTableViewController.h
//  SoundParty
//
//  Created by Emilio Castrejon Guerrero on 4/2/18.
//  Copyright © 2018 Opindes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *NombreTxt;
@property (weak, nonatomic) IBOutlet UITextField *UserTxt;
@property (weak, nonatomic) IBOutlet UITextField *PasswordText;
@property (weak, nonatomic) IBOutlet UITextField *CellTxt;
@property (weak, nonatomic) IBOutlet UITextField *EmailTxt;
@property (nonatomic, strong) IBOutletCollection(UITextField) NSArray *textfields;



@property (weak, nonatomic) IBOutlet UIDatePicker *Datebirth;
@property (weak, nonatomic) IBOutlet UILabel *DateLabel;



@end
