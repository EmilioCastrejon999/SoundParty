//
//  AppDelegate.m
//  SoundParty
//
//  Created by Emilio Castrejon Guerrero on 4/2/18.
//  Copyright © 2018 Opindes. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	// Override point for customization after application launch.
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	// Saves changes in the application's managed object context before the application terminates.
	[self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"SoundParty"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}



- (NSString *)ResponseFromUrl: (NSString *)UrlString Async:(BOOL)Asynchronous SpinnerColor: (UIColor *)Color{
	 
	 if (Asynchronous == NO) {
		  [self spinnerSetup :Color];
	 }
	 
	 NSString *UrlPath = @"http://192.168.0.35/SoundPartyServer/";
	 UrlString = [UrlPath stringByAppendingString:UrlString];
	 
	 UrlString = [UrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
	 
	 NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:25];
	 __block NSString *RespuestaInternet;
	 __block BOOL ResponseHasArrived = NO;
	 
	 NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
	 
	 [request setURL:[NSURL URLWithString:UrlString]];
	 
	 NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	 [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
		  if (error) {
				NSLog(@"Error,%@", [error localizedDescription]);
		  }
		  else {
				ResponseHasArrived = YES;
				RespuestaInternet = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		  }
	 }];
	 
	 while (ResponseHasArrived == NO && ([timeoutDate timeIntervalSinceNow] > 0))
	 {
		  CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.01, YES);
	 }
	 
	 
	 
	 [_spinner stopAnimating];
	 [[UIApplication sharedApplication] endIgnoringInteractionEvents];
	 
	 if (ResponseHasArrived == NO) {
		  UIAlertController *alert = [UIAlertController
												alertControllerWithTitle:@"Error con la conexion a internet"
												message:@"Intente de nuevo mas tarde"
												preferredStyle:UIAlertControllerStyleAlert];
		  
		  [self.window.rootViewController presentViewController:alert animated:YES completion:nil];
		  
		  [NSTimer scheduledTimerWithTimeInterval:2 repeats:NO block:^(NSTimer *timer) {
				[self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
		  }];
		  
		  return nil;
	 }
	 
	 else{
		  return RespuestaInternet;
		  
	 }
}

-(void)spinnerSetup :(UIColor *)Color{
	 _spinner =
	 [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	 
	 _spinner.hidden = NO;
	 _spinner.center = self.window.center;
	 _spinner.color = Color;
	 _spinner.hidesWhenStopped = YES;
	 [self.window addSubview:_spinner];
	 [self.window bringSubviewToFront:_spinner];
	 [_spinner startAnimating];
	 [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}

@end
