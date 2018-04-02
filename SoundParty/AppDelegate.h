//
//  AppDelegate.h
//  SoundParty
//
//  Created by Emilio Castrejon Guerrero on 4/2/18.
//  Copyright © 2018 Opindes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property UIActivityIndicatorView *spinner;

- (void)saveContext;
- (NSString *)ResponseFromUrl: (NSString *)UrlString Async:(BOOL)Asynchronous SpinnerColor: (UIColor *)Color;


@end

