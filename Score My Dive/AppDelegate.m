//
//  AppDelegate.m
//  Score My Dive
//
//  Created by Jeremey Rodriguez on 10/30/14.
//  Copyright (c) 2014 SingleCog Software. All rights reserved.
//

#import "AppDelegate.h"
#import "MeetHistory.h"
#import "DiverHistory.h"
#import "DiverMeetScores.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

-(BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // we need this to make each view gets fully instantiated before encoding
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    return YES;
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

-(UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if(self.restrictRotation) {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            return UIInterfaceOrientationMaskPortrait;
        } else {
            return UIInterfaceOrientationMaskAll;
        }
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

//-(MeetHistory *)meetHistoryViewController {
//    MeetHistory *vcontroller = (MeetHistory *)self.window.rootViewController;
//    return vcontroller;
//}
//
//-(DiverHistory *)diverHistoryViewController {
//    DiverHistory *vcontroller = (DiverHistory *)self.window.rootViewController;
//    return vcontroller;
//}

//-(UIViewController *)application:(UIApplication *)application viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder {
//    
//    NSLog(@"viewControllerWithRestorationIdentifierPath %@",
//          identifierComponents);
//    
//    UIViewController *viewController = nil;
//    NSString *identifier = [identifierComponents lastObject];
//    
//    // MeetHistory
//    if ([identifier isEqualToString:@"MeetHistory"]) {
//        UIStoryboard *storyboard = [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
//        
//        if (storyboard != nil) {
//            viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
//        }
//    }
//    
//    // DiverHistory
//    if ([identifier isEqualToString:@"DiverHistory"]) {
//        UIStoryboard *storyboard = [coder decodeObjectForKey:UIStateRestorationViewControllerStoryboardKey];
//        
//        if (storyboard != nil) {
//            viewController = [storyboard instantiateViewControllerWithIdentifier:identifier];
//        }
//    }
//    
//    return viewController;
//}


// save state
-(BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder {
    
    return YES;
}

-(BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder {
    
    return YES;
}

+ (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    return image;
}

@end
