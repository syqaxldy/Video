//
//  AppDelegate.m
//  VideoSelection
//
//  Created by syqaxldy on 2020/4/2.
//  Copyright © 2020 syqaxldy. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
       self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
          
       self.window.backgroundColor = [UIColor whiteColor];
          
       
       ViewController *chooseVC = [[ViewController alloc]init];
       self.window.rootViewController = chooseVC;
    [self.window makeKeyAndVisible];
    return YES;
}





@end
