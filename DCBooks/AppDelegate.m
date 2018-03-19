//
//  AppDelegate.m
//  DCBooks
//
//  Created by cheyr on 2018/3/13.
//  Copyright © 2018年 cheyr. All rights reserved.
//

#import "AppDelegate.h"
#import "Header.h"
#import "DCFileTool.h"
#import "DCHomeVC.h"
#import "DCPageVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    //创建根目录
    [DCFileTool creatRootDirectory];
    NSLog(@"%@",DCBooksPath);
    
    //设置默认信息
    if(![[NSUserDefaults standardUserDefaults] objectForKey:DCReadMode])
    {
        [[NSUserDefaults standardUserDefaults] setObject:DCReadDefaultMode forKey:DCReadMode];
    }
    
    DCHomeVC *vc = [[DCHomeVC alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    self.window.rootViewController = nav;
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if (url)
    {

        NSString *fileNameStr = [url lastPathComponent];
        fileNameStr = [fileNameStr stringByRemovingPercentEncoding];
        
        NSString *toPath = [DCBooksPath stringByAppendingPathComponent:fileNameStr];
       
        NSData *data = [NSData dataWithContentsOfURL:url];
        [data writeToFile:toPath atomically:YES];
        
        
        //用阅读器打开这个文件
        DCPageVC *vc = [[DCPageVC alloc]init];
        vc.filePath = toPath;
        UINavigationController *nav = (UINavigationController *)self.window.rootViewController;
        [nav.topViewController.navigationController pushViewController:vc animated:YES];
        
    }
    
    
    
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
}


@end
