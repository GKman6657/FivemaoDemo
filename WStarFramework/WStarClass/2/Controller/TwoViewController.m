//
//  TwoViewController.m
//  WStarFramework
//
//  Created by jf on 16/11/15.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "TwoViewController.h"
#import "JFLoopView.h"
#import "ServiceSlider.h"
@interface TwoViewController () {
    UIButton *_smsCodeBtn;
}
@property (nonatomic, strong) JFLoopView *loopView;
@property (nonatomic, strong) ServiceSlider *slider;
@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //关闭自动调整滚动视图
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self showalertView];
    [self useTryAndcatchmethod];
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
#pragma mark - 倒计时获取验证码
-(void)changeTimeOut:(int)timeOut btnTag:(int)btnTag{
    __block int timeout=timeOut;
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer=dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        if (timeout<=0) {
            dispatch_source_cancel(_timer);
            //dispatch_release(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //倒计时结束
                _smsCodeBtn=(UIButton*)[self.view viewWithTag:[[NSString stringWithFormat:@"%d",btnTag] intValue]];
                [_smsCodeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
                [_smsCodeBtn setUserInteractionEnabled:YES];
                [_smsCodeBtn setTitleColor:[UIColor colorWithRed:53.0f/255.0f   green:53.0f/255.0f blue:68.0f/255.0f alpha:1] forState:UIControlStateNormal];
                [_smsCodeBtn.layer setBorderColor:[UIColor colorWithRed:53.0f/255.0f green:53.0f/255.0f blue:68.0f/255.0f alpha:1].CGColor];
            });
        }else{
            NSString* strTime=[NSString stringWithFormat:@"%d秒后重新获取",(int)(timeout)];
            dispatch_async(dispatch_get_main_queue(), ^{
                //倒计时
                _smsCodeBtn=(UIButton*)[self.view viewWithTag:[[NSString stringWithFormat:@"%d",(int)btnTag] intValue]];
                [_smsCodeBtn setTitle:strTime forState:UIControlStateNormal];
                [_smsCodeBtn setTitleColor:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1] forState:UIControlStateNormal];
                [_smsCodeBtn.layer setBorderColor:[UIColor colorWithRed:153.0f/255.0f green:153.0f/255.0f blue:153.0f/255.0f alpha:1].CGColor];
                [_smsCodeBtn setUserInteractionEnabled:NO];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


- (void)loadView {
    [super loadView];
    
    NSArray *imageArray = @[@"srcoll_01",@"srcoll_02",@"srcoll_03",@"srcoll_04",@"srcoll_05"];
    
    
    _loopView = [[JFLoopView alloc] initWithImageArray:imageArray];
    _loopView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250);
    
    [self.view addSubview:self.loopView];
}

- (void)showalertView {
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"TITLE" message:@"XINXI" preferredStyle:UIAlertControllerStyleAlert];
    
    
    // 2.实例化按钮:actionWithTitle
    // 为防止block与控制器间循环引用，我们这里需用__weak来预防
    __weak typeof(alert) wAlert = alert;
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        NSLog(@"%@",[wAlert.textFields.firstObject text]);
         [self createSlider];  //滑动解锁
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    // 添加文本框(只能添加到UIAlertControllerStyleAlert的样式，如果是preferredStyle:UIAlertControllerStyleActionSheet则会崩溃)
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.text = @"world";
        
        //监听文字改变的方法
//        [textField addTarget:self action:@selector(textFieldsValueDidChange:) forControlEvents:UIControlEventEditingChanged];
    }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.secureTextEntry = YES;  // 密文形式显示
        textField.text = @"hello";
    }];
   
    
    // 3.显示alertController:presentViewController
    [self presentViewController:alert animated:YES completion:nil];

}
- (void)useTryAndcatchmethod {
    
    @try {
        [self tryTwo];
    } @catch (NSException *exception) {
         NSLog(@"%s\n%@", __FUNCTION__, exception);
    } @finally {
         NSLog(@"我一定会执行");
    }
    // 这里一定会执行
    NSLog(@"try");
}
- (void)tryTwo
{
    @try {
        // 5
        NSString *str = @"abc";
        [str substringFromIndex:111]; // 程序到这里会崩
    }
    @catch (NSException *exception) {
        // 6
        //        @throw exception; // 抛出异常，即由上一级处理
        // 7
        NSLog(@"%s\n%@", __FUNCTION__, exception);
    }
    @finally {
        // 8
        NSLog(@"tryTwo - 我一定会执行");
    }
    
    // 9
    // 如果抛出异常，那么这段代码则不会执行
    NSLog(@"如果这里抛出异常，那么这段代码则不会执行");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)createSlider {
    _slider = [[ServiceSlider alloc]initWithFrame:CGRectMake(15, 266, self.view.bounds.size.width - 30, 50)];
    [self.view addSubview:_slider];
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
