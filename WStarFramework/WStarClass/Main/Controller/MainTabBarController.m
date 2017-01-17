//
//  MainTabBarController.m
//  WStarFramework
//
//  Created by jf on 16/11/15.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "MainTabBarController.h"
#import "CustomMiddleBar.h"

#import "FiveViewController.h"
#import "FourViewController.h"
#import "ThreeViewController.h"
#import "TwoViewController.h"
#import "OneViewController.h"
#import "MainNavigationController.h"
@interface MainTabBarController ()<CustomMiddleBarDelegate,UITabBarControllerDelegate> {
    UIButton * button;
}
@property (nonatomic,strong)OneViewController *vc1;
@property (nonatomic,strong)TwoViewController *vc2;
@property (nonatomic,strong)ThreeViewController *vc3;
@property (nonatomic,strong)FourViewController *vc4;
@property (nonatomic,strong)FiveViewController *vc5;

@end

@implementation MainTabBarController


- (void)viewDidLoad {
    [super viewDidLoad];

   
//     [self setUpAllChildViewController];  //初始化子控制器
    [self SetupAllControllers]  ;  //简书的 子控件
     self.view.userInteractionEnabled = YES;

    CustomMiddleBar *mainTabBar = [[CustomMiddleBar alloc] initWithFrame:self.tabBar.frame];
    mainTabBar.backgroundColor = [UIColor groupTableViewBackgroundColor];
    mainTabBar.delegate =self;
    // KVC：如果要修系统的某些属性，但被设为readOnly，就是用KVC，即setValue：forKey：。
    // 修改tabBar为自定义tabBar
    [self setValue:mainTabBar forKeyPath:@"tabBar"];
 


//    [self addButtonNotifation];
//    [self setupOutstanding];

}

/**
 *  添加所有子控制器方法
 */
- (void)setUpAllChildViewController {
    // 1.添加第一个控制器
     self.vc1 = [[OneViewController alloc] init];
  
    [self setUpOneChildViewController:self.vc1 SelectedImage:[UIImage imageNamed:@"bt-chat-red"] image:[UIImage imageNamed:@"bt-chat"] title:@"首页"];
    // 2.添加第2个控制器
     self.vc2 = [[TwoViewController alloc] init];

     [self setUpOneChildViewController:self.vc2 SelectedImage:[UIImage imageNamed:@"bt-home-red"] image:[UIImage imageNamed:@"bt-home"] title:@"技术"];
    
    // 3.添加第3个控制器
     self.vc3 = [[ThreeViewController alloc] init];

     [self setUpOneChildViewController:self.vc3 SelectedImage:[UIImage imageNamed:@"bt-ShoppingCart-red"] image:[UIImage imageNamed:@"bt-ShoppingCart"] title:@"博文"];
    
    // 4.添加第4个控制器
     self.vc4 = [[FourViewController alloc] init];

     [self setUpOneChildViewController:self.vc4 SelectedImage:[UIImage imageNamed:@"bt-my-red"] image:[UIImage imageNamed:@"bt-my"] title:@"我的江湖"];
    
    
//    self.tabBar.tintColor = [UIColor greenColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    //设置标签栏风格(默认高度49)
    self.tabBar.barStyle = UIBarStyleDefault;

}

/**
 *  添加一个子控制器的方法
 */
- (void)setUpOneChildViewController:(UIViewController *)viewController SelectedImage:(UIImage *)selectImage image:(UIImage *)image title:(NSString *)title{
    
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:viewController];
    navC.title = title;
    navC.tabBarItem.image = image;
    navC.tabBarItem.selectedImage = selectImage ;
    
    viewController.navigationItem.title = title;
    
    [self addChildViewController:navC];
}
#pragma mark- setupOutstanding   只能突出，不能改变frame， 所以不好，还是要自定义的

-(void)setupOutstanding{
    
    //  添加突出按钮
    [self addCenterButtonWithImage:[UIImage imageNamed:@"button_write"] selectedImage:[UIImage imageNamed:@"button_write~iphone"]];
    //  UITabBarControllerDelegate 指定为自己
    self.delegate = self;
    //    //  设点button状态
    button.selected=YES;
    //  指定当前页——中间页
    self.selectedIndex=2;
}
-(void) addCenterButtonWithImage:(UIImage*)buttonImage selectedImage:(UIImage*)selectedImage
{
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(pressChange:) forControlEvents:UIControlEventTouchUpInside];
    
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    //  设定button大小为适应图片
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    //  这个比较恶心  去掉选中button时候的阴影
    button.adjustsImageWhenHighlighted=NO;
    
    /*
     *  核心代码：设置button的center 和 tabBar的 center 做对齐操作， 同时做出相对的上浮
     */
//    CGFloat heightDifference = buttonImage.size.height - self.tabBar.frame.size.height;
//                              //40                       49
//    if (heightDifference < 0)
//        button.center = self.tabBar.center;
//    else
//    {
//        CGPoint center = self.tabBar.center;
//        center.y = center.y - heightDifference/2.0;
//        button.center = center;
//    }
    
    CGPoint center = self.tabBar.center;
    center.y = center.y - buttonImage.size.height/4;
    button.center = center;
    
    [self.view addSubview:button];
}

-(void)pressChange:(id)sender
{
    UIAlertView * alr = [[UIAlertView alloc]initWithTitle:@"title" message:@"自定义按钮" delegate:self cancelButtonTitle:@"小心了" otherButtonTitles:nil, nil];
    [alr show];
}
//添加大圆按钮的通知
-(void)addButtonNotifation{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buttonHidden) name:@"buttonNotifationCenter" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(buttonNotHidden) name:@"buttonNotHidden" object:nil];
}
-(void)buttonNotHidden{
    button.hidden=NO;
}
-(void)buttonHidden{
    button.hidden=YES;
}



#pragma mark-CustomMiddleBarDelegate
- (void)middlebarDidClickPlusButton:(CustomMiddleBar *)tabBar {
    
        // 点击事件内容
    FiveViewController *vc = [[FiveViewController alloc] init];
//    vc.view.backgroundColor = [UIColor magentaColor];
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:vc];

    self.vc5 = vc ;
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark- TabBar Delegate

//  换页和button的状态关联上

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (self.selectedIndex==2) {
        button.selected=YES;
    }else
    {
        button.selected=NO;
    }
}

//简书的 自定义方式
- (void)SetupAllControllers{
    NSArray *titles = @[@"发现", @"关注", @"消息", @"我的"];
    NSArray *images = @[@"icon_tabbar_home~iphone", @"icon_tabbar_subscription~iphone", @"icon_tabbar_notification~iphone", @"icon_tabbar_me~iphone"];
    NSArray *selectedImages = @[@"icon_tabbar_home_active~iphone", @"icon_tabbar_subscription_active~iphone", @"icon_tabbar_notification_active~iphone", @"icon_tabbar_me_active~iphone"];
    
    OneViewController * homeVc = [[OneViewController alloc] init];
    self.vc1 = homeVc;
    
    TwoViewController * subscriptionVc = [[TwoViewController alloc] init];
    self.vc2 = subscriptionVc;
    
    ThreeViewController * notificationVc = [[ThreeViewController alloc] init];
    self.vc3 = notificationVc;
    
    FourViewController * meVc = [[FourViewController alloc] init];
    self.vc4 = meVc;
    
    NSArray *viewControllers = @[self.vc1, self.vc2, self.vc3, self.vc4];
    
    for (int i = 0; i < viewControllers.count; i++) {
        UIViewController *childVc = viewControllers[i];
        
        [self SetupChildVc:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}
- (void)SetupChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName{
    
//    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:childVc];
    UINavigationController *navC = [[UINavigationController alloc]initWithRootViewController:childVc];
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImageName];
    childVc.tabBarItem.title = title;
//    [self.mainTabBar addTabBarButtonWithTabBarItem:childVc.tabBarItem];
    
    childVc.navigationItem.title = title;


    [self addChildViewController:navC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
