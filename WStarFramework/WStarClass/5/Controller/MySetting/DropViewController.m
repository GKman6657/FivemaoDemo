//
//  DropViewController.m
//  WStarFramework
//
//  Created by jf on 16/12/29.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "DropViewController.h"
#import "WTKDropView.h"

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
@interface DropViewController ()
@property (nonatomic,strong)WTKDropView         *menuView;
@property(nonatomic,strong)NSArray              *dataArray;
@end

@implementation DropViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    button.frame = CGRectMake(kScreenWidth- 50, 0, 84, 22);
    [button addTarget:self action:@selector(dropCk:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"drop动画" forState:UIControlStateNormal];
    [button setTintColor:[UIColor magentaColor]];
    
    self.dataArray = @[@"百度钱包",@"支付宝",@"微信钱包",@"QQ钱包",@"我的",@"百度钱包",@"支付宝",@"微信钱包",@"QQ钱包",@"我的"];
    self.menuView = [[WTKDropView alloc]initWithFrame:CGRectMake(210, 55, 150, 300) withTitleArray:self.dataArray];
    self.menuView.tag = 1;
    WS(weakSelf);
    self.menuView.clickBlock = ^(NSInteger tag){
        UIAlertAction *action =[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:weakSelf.dataArray[tag] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:action];
        [weakSelf presentViewController:alert animated:YES completion:nil];
    };
}
- (void)dropCk:(UIButton *)btn {
    
    if ([self.view viewWithTag:1])
    {
        [self.menuView dismiss];
    }
    else
    {
        [self.view addSubview:self.menuView];
        [self.menuView beginAnimation];
    }
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
