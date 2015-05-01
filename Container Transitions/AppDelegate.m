//
//  AppDelegate.m
//  Container Transitions
//
//  Created by Joachim Bondo on 30/04/2014.
//  Copyright (c) 2014 Joachim Bondo. All rights reserved.
//

#import "AppDelegate.h"
#import "ContainerViewController.h"
#import "ChildViewController.h"
#import "Animator.h"

@interface AppDelegate () <ContainerViewControllerDelegate>
@property (nonatomic, strong) UIWindow *privateWindow;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.privateWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.privateWindow.rootViewController = [self _configuredRootViewController];
    [self.privateWindow makeKeyAndVisible];
    
    return YES;
}

#pragma mark - ContainerViewControllerDelegate Protocol

- (id<UIViewControllerAnimatedTransitioning>)containerViewController:(ContainerViewController *)containerViewController animationControllerForTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController {
    return [[Animator alloc] init];
}

#pragma mark - Private Methods

- (UIViewController *)_configuredRootViewController {
    
    NSArray *childViewControllers = [self _configuredChildViewControllers];
    ContainerViewController *rootViewController = [[ContainerViewController alloc] initWithViewControllers:childViewControllers];
    //    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:rootViewController];
    //    nav.navigationBar.translucent = NO;
    //    UITabBarController * tab = [[UITabBarController alloc]init];
    //    tab.tabBar.translucent = NO;
    //    tab.viewControllers=@[nav];
    //	rootViewController.delegate = self;
    
    return rootViewController;
}

- (NSArray *)_configuredChildViewControllers {
    
    // Set colors, titles and tab bar button icons which are used by the ContainerViewController class for display in its button pane.
    
    NSMutableArray *childViewControllers = [[NSMutableArray alloc] initWithCapacity:3];
    NSArray *configurations = @[
                                @{@"title": @"First", @"color": [UIColor colorWithRed:0.4f green:0.8f blue:1 alpha:1]},
                                @{@"title": @"Second", @"color": [UIColor colorWithRed:1 green:0.4f blue:0.8f alpha:1]},
                                @{@"title": @"Third", @"color": [UIColor colorWithRed:1 green:0.8f blue:0.4f alpha:1]},
                                ];
    
    for (NSDictionary *configuration in configurations) {
        ChildViewController *childViewController = [[ChildViewController alloc] init];
        
        childViewController.title = configuration[@"title"];
        childViewController.themeColor = configuration[@"color"];
        childViewController.tabBarItem.image = [UIImage imageNamed:configuration[@"title"]];
        childViewController.tabBarItem.selectedImage = [UIImage imageNamed:[configuration[@"title"] stringByAppendingString:@" Selected"]];
        [childViewControllers addObject:childViewController];
    }
    
    return childViewControllers;
}

@end
