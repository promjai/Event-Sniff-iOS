//
//  AppDelegate.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/6/2558 BE.
//  Copyright (c) 2558 Pariwat Promjai. All rights reserved.
//

#import "AppDelegate.h"

#import "PFEventViewController.h"
#import "PFSniffViewController.h"
#import "PFProfileViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    UITabBarController *tbc = [[UITabBarController alloc] init];
    tbc.delegate = self;
    
    PFEventViewController *event = [[PFEventViewController alloc] init];
    PFSniffViewController *sniff = [[PFSniffViewController alloc] init];
    PFProfileViewController *profile = [[PFProfileViewController alloc] init];
    
    if(IS_WIDESCREEN) {
        event = [[PFEventViewController alloc] initWithNibName:@"PFEventViewController_Wide" bundle:nil];
        sniff = [[PFSniffViewController alloc] initWithNibName:@"PFSniffViewController_Wide" bundle:nil];
        profile = [[PFProfileViewController alloc] initWithNibName:@"PFProfileViewController_Wide" bundle:nil];
    } else {
        event = [[PFEventViewController alloc] initWithNibName:@"PFEventViewController" bundle:nil];
        sniff = [[PFSniffViewController alloc] initWithNibName:@"PFSniffViewController" bundle:nil];
        profile = [[PFProfileViewController alloc] initWithNibName:@"PFProfileViewController" bundle:nil];
    }
    
    /* Feed */
    
    UINavigationController *navFeed = [[UINavigationController alloc] initWithRootViewController:event];
    [[navFeed navigationBar] setBarTintColor:[UIColor colorWithRed:65.0f/255.0f green:95.0f/255.0f blue:154.0f/255.0f alpha:1.0f]];
    [[navFeed navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName, nil]];
    
    navFeed.navigationBar.tintColor = [UIColor whiteColor];
    
    [event.tabBarItem setTitle:@"Event"];
    [event.tabBarItem setImage:[UIImage imageNamed:@"ic_setting"]];
    
    /* Sniff */
    
    UINavigationController *navSniff = [[UINavigationController alloc] initWithRootViewController:sniff];
    [[navSniff navigationBar] setBarTintColor:[UIColor colorWithRed:65.0f/255.0f green:95.0f/255.0f blue:154.0f/255.0f alpha:1.0f]];
    [[navSniff navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName, nil]];
    
    navSniff.navigationBar.tintColor = [UIColor whiteColor];
    
    [sniff.tabBarItem setTitle:@"Sniff"];
    [sniff.tabBarItem setImage:[UIImage imageNamed:@"ic_notification"]];
    
    /* Profile */
    
    UINavigationController *navProfile = [[UINavigationController alloc] initWithRootViewController:profile];
    [[navProfile navigationBar] setBarTintColor:[UIColor colorWithRed:65.0f/255.0f green:95.0f/255.0f blue:154.0f/255.0f alpha:1.0f]];
    [[navProfile navigationBar] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f], NSForegroundColorAttributeName, nil]];
    
    navProfile.navigationBar.tintColor = [UIColor whiteColor];
    
    [profile.tabBarItem setTitle:@"Profile"];
    [profile.tabBarItem setImage:[UIImage imageNamed:@"ic_notification"]];
    
    /* tabbar controller */
    
    [tbc.tabBar setTintColor:[UIColor blackColor]];
    [tbc setViewControllers:[NSArray arrayWithObjects:navFeed ,navSniff ,navProfile ,nil]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self.window setRootViewController:tbc];
    
    return YES;
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

@end
