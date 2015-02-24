//
//  AppDelegate.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/6/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (IS_OS_8_OR_LATER) {
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    } else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
    [self tabbar];
    
    return YES;
}

- (void)tabbar {
    
    NSLog(@"tabbar reset");
    
    /* API */
    self.Api = [[PFApi alloc] init];
    self.Api.delegate = self;
    
    [self.Api saveReset:@"NO"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.event = [[PFEventViewController alloc] init];
    self.sniff = [[PFSniffViewController alloc] init];
    self.profile = [[PFProfileViewController alloc] init];
    
    self.event.delegate = self;
    self.sniff.delegate = self;
    self.profile.delegate = self;

    UITabBarController *tbc = [[UITabBarController alloc] init];
    tbc.delegate = self;
    
    if(IS_WIDESCREEN) {
        self.event = [[PFEventViewController alloc] initWithNibName:@"PFEventViewController_Wide" bundle:nil];
        self.sniff = [[PFSniffViewController alloc] initWithNibName:@"PFSniffViewController_Wide" bundle:nil];
        self.profile = [[PFProfileViewController alloc] initWithNibName:@"PFProfileViewController_Wide" bundle:nil];
    } else {
        self.event = [[PFEventViewController alloc] initWithNibName:@"PFEventViewController" bundle:nil];
        self.sniff = [[PFSniffViewController alloc] initWithNibName:@"PFSniffViewController" bundle:nil];
        self.profile = [[PFProfileViewController alloc] initWithNibName:@"PFProfileViewController" bundle:nil];
    }
    
    /* Event */
    
    UINavigationController *navFeed = [[UINavigationController alloc] initWithRootViewController:self.event];
    [[navFeed navigationBar] setBarTintColor:[UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]];
    [[navFeed navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0f/255.0f green:73.0f/255.0f blue:129.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName, nil]];
    
    navFeed.navigationBar.tintColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    if (![[self.Api getLanguage] isEqualToString:@"th"]) {
        [self.event.tabBarItem setTitle:@"Event"];
    } else {
        [self.event.tabBarItem setTitle:@"กิจกรรม"];
    }
    
    [self.event.tabBarItem setImage:[UIImage imageNamed:@"ic_tab_event_off"]];
    [self.event.tabBarItem setSelectedImage:[UIImage imageNamed:@"ic_tab_event_on"]];
    
    /* Sniff */
    
    UINavigationController *navSniff = [[UINavigationController alloc] initWithRootViewController:self.sniff];
    [[navSniff navigationBar] setBarTintColor:[UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]];
    [[navSniff navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0f/255.0f green:73.0f/255.0f blue:129.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName, nil]];
    
    navSniff.navigationBar.tintColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    if (![[self.Api getLanguage] isEqualToString:@"th"]) {
        [self.sniff.tabBarItem setTitle:@"Sniff"];
    } else {
        [self.sniff.tabBarItem setTitle:@"โดยรอบ"];
    }
    
    [self.sniff.tabBarItem setImage:[UIImage imageNamed:@"ic_tab_sniff_off"]];
    [self.sniff.tabBarItem setSelectedImage:[UIImage imageNamed:@"ic_tab_sniff_on"]];
    
    /* Profile */
    
    UINavigationController *navProfile = [[UINavigationController alloc] initWithRootViewController:self.profile];
    [[navProfile navigationBar] setBarTintColor:[UIColor colorWithRed:242.0f/255.0f green:242.0f/255.0f blue:242.0f/255.0f alpha:1.0f]];
    [[navProfile navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0f/255.0f green:73.0f/255.0f blue:129.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName, nil]];
    
    navProfile.navigationBar.tintColor = [UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1.0f];
    
    if (![[self.Api getLanguage] isEqualToString:@"th"]) {
        [self.profile.tabBarItem setTitle:@"Profile"];
    } else {
        [self.profile.tabBarItem setTitle:@"โปรไฟล์"];
    }
    
    [self.profile.tabBarItem setImage:[UIImage imageNamed:@"ic_tab_profile_off"]];
    [self.profile.tabBarItem setSelectedImage:[UIImage imageNamed:@"ic_tab_profile_on"]];
    
    /* tabbar controller */
    
    [tbc.tabBar setTintColor:[UIColor colorWithRed:255.0f/255.0f green:73.0f/255.0f blue:129.0f/255.0f alpha:1.0f]];
    [tbc setViewControllers:[NSArray arrayWithObjects:navFeed ,navSniff ,navProfile ,nil]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self.window setRootViewController:tbc];

}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController  {
    if (tabBarController.selectedIndex == 0) {
        NSLog(@"tab1");
    } else if (tabBarController.selectedIndex == 1) {
        NSLog(@"tab2");
    } else if (tabBarController.selectedIndex == 2) {
        NSLog(@"tab3");
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:   (UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *dt = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    dt = [dt stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"My token is : %@", dt);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dt forKey:@"deviceToken"];
    [defaults synchronize];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
}

- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return (UIInterfaceOrientationMaskAll);
}

/* reset */

// In order to process the response you get from interacting with the Facebook login process,
// you need to override application:openURL:sourceApplication:annotation:
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    // Call FBAppCall's handleOpenURL:sourceApplication to handle Facebook app responses
    BOOL wasHandled = [FBAppCall handleOpenURL:url sourceApplication:sourceApplication];
    
    // You can add your app-specific url handling code here if needed
    
    return wasHandled;
}

@end
