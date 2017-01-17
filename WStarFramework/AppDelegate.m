//
//  AppDelegate.m
//  WStarFramework
//
//  Created by jf on 16/11/15.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "SureGuideView.h"
#import "MLTransition.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    //                            _ooOoo_
    //                           o8888888o
    //                           88" . "88
    //                           (| -_- |)
    //                           O\  =  /O
    //                        ____/`---'\____
    //                      .'  \\|     |//  `.
    //                     /  \\|||  :  |||//  \
    //                    /  _||||| -:- |||||-  \
    //                    |   | \\\  -  /// |   |
    //                    | \_|  ''\---/''  |   |
    //                    \  .-\__  `-`  ___/-. /
    //                   ___`. .'  /--.--\  `. . __
    //                ."" '<  `.___\_<|>_/___.'  >'"".
    //              | | :  `- \`.;`\ _ /`;.`/ - ` : | |
    //              \  \ `-.   \_ __\ /__ _/   .-` /  /
    //         ======`-.____`-.___\_____/___.-`____.-'======
    //                            `=---='
    //         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    //                  佛祖镇楼                  BUG辟易
    //          佛曰:
    //                  写字楼里写字间，写字间里程序员；
    //                  程序人员写程序，又拿程序换酒钱。
    //                  酒醒只在网上坐，酒醉还来网下眠；
    //                  酒醉酒醒日复日，网上网下年复年。
    //                  但愿老死电脑间，不愿鞠躬老板前；
    //                  奔驰宝马贵者趣，公交自行程序员。
    //                  别人笑我忒疯癫，我笑自己命太贱；
    //                  不见满街漂亮妹，哪个归得程序员？
    
    
    
    /**********************
     ┏┓　　　┏┓
     ┏┛┻━━━━━┛┻┓
     ┃         ┃
     ┃    ━    ┃
     ┃　┳┛　┗┳　┃
     ┃         ┃
     ┃    ┻    ┃
     ┃         ┃
     ┗━┓　　　┏━┛
     ┃　　　┃ 神兽保佑
     ┃　　　┃ 代码无BUG！
     ┃　　　┗━━━┓
     ┃         ┣┓
     ┃         ┏┛
     ┗┓┓┏━━━┳┓┏┛
     ┃┫┫   ┃┫┫
     ┗┻┛   ┗┻┛
     **********************/
    
    //
    //   █████▒█    ██  ▄████▄   ██ ▄█▀       ██████╗ ██╗   ██╗ ██████╗
    // ▓██   ▒ ██  ▓██▒▒██▀ ▀█   ██▄█▒        ██╔══██╗██║   ██║██╔════╝
    // ▒████ ░▓██  ▒██░▒▓█    ▄ ▓███▄░        ██████╔╝██║   ██║██║  ███╗
    // ░▓█▒  ░▓▓█  ░██░▒▓▓▄ ▄██▒▓██ █▄        ██╔══██╗██║   ██║██║   ██║
    // ░▒█░   ▒▒█████▓ ▒ ▓███▀ ░▒██▒ █▄       ██████╔╝╚██████╔╝╚██████╔╝
    //  ▒ ░   ░▒▓▒ ▒ ▒ ░ ░▒ ▒  ░▒ ▒▒ ▓▒       ╚═════╝  ╚═════╝  ╚═════╝
    //  ░     ░░▒░ ░ ░   ░  ▒   ░ ░▒ ▒░
    //  ░ ░    ░░░ ░ ░ ░        ░ ░░ ░
    //           ░     ░ ░      ░  ░
    //                 ░
    
//    
//    ___                     ___
//    /  /\      ___          /  /\
//    /  /:/_    /  /\        /  /:/_
//    /  /:/ /\  /  /:/       /  /:/ /\
//    /  /:/ /:/ /__/::\      /  /:/ /::\
//    /__/:/ /:/  \__\/\:\__  /__/:/ /:/\:\
//    \  \:\/:/      \  \:\/\ \  \:\/:/~/:/
//    \  \::/        \__\::/  \  \::/ /:/
//    \  \:\        /__/:/    \__\/ /:/
//    \  \:\       \__\/       /__/:/
//    \__\/                   \__\/     代表队前来围观
    
    

// zP"""""$e.           $"    $o
//4$       '$          $"      $
//'$        '$        J$       $F
// 'b        $k       $>       $
//  $k        $r     J$       d$
//  '$         $     $"       $~
//   '$        "$   '$E       $
//    $         $L   $"      $F ...
//     $.       4B   $      $$$*"""*b
//     '$        $.  $$     $$      $F
//      "$       R$  $F     $"      $
//       $k      ?$ u*     dF      .$
//       ^$.      $$"     z$      u$$$$e
//       #$b             $E.dW@e$"    ?$
//        #$           .o$$# d$$$$c    ?F
//         $      .d$$#" . zo$>   #$r .uF
//         $L .u$*"      $&$$$k   .$$d$$F
//           $$"            ""^"$$$P"$P9$
//         JP              .o$$$$u:$P $$
//         $          ..ue$"      ""  $"
//        d$          $F              $
//        $$     ....udE             4B
//         #$    """"` $r            @$
//           ^$L        '$            $F
//            RN        4N           $
//             *$b                  d$
//             $$k                 $F
//               $$b                $F
//                $""               $F
//                 '$                $
//                $L               $
//                 '$               $
//                  $               $
//
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor magentaColor]];//tintColor属性  箭头颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor cyanColor]}];
  
    // 1.创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    // 2.设置窗口的根控制器
    MainTabBarController *tabBarVC = [[MainTabBarController alloc]init];
    self.window.rootViewController = tabBarVC;
    
    // 3.显示窗口
    [self.window makeKeyAndVisible];
    
    
    if ([SureGuideView shouldShowGuider]) {
        [SureGuideView sureGuideViewWithImageName:@"guide" imageCount:2];
    }
    
//一句话处理导航自定义返回键
    //nav 手势处理
    [MLTransition validatePanBackWithMLTransitionGestureRecognizerType:MLTransitionGestureRecognizerTypePan];//or MLTransitionGestureRecognizerTypeScreenEdgePan
    //...
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
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"WStarFramework"];
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

@end
