//
//  FiveViewController.m
//  WStarFramework
//
//  Created by jf on 16/11/15.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "FiveViewController.h"

#import "CYLTableViewPlaceHolder.h"
#import "MJRefresh.h"
#import "XTNetReloader.h"
#import "WeChatStylePlaceHolder.h"
#import "Masonry.h"
#import "JX_GCDTimerManager.h"
#import "SettingViewController.h"
#import "UIView+YGPulseView.h"
static const CGFloat CYLDuration = 1.0;
#define CYLRandomData [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]

@interface FiveViewController ()<CYLTableViewPlaceHolderDelegate, WeChatStylePlaceHolderDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_timeBtn1;
    UIButton *_timeBtn2;
     NSInteger _count;
    UIView * _plusView;
}
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign, getter=isNoResult) BOOL noResult;

@property (nonatomic,strong) UITableView *tableView;
/** 定时器(这里不用带*，因为dispatch_source_t就是个类，内部已经包含了*) */
@property (nonatomic, strong) dispatch_source_t timer;

@property (nonatomic, strong) JX_GCDTimerManager *timerManager;
@property (nonatomic, strong) NSTimer *JXtimer;
@end

static NSString *myTimer = @"MyTimer";

@implementation FiveViewController


- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (BOOL)isNoResult {
    _noResult = (self.dataSource.count == 0);
    return _noResult;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
  self.navigationController.navigationBar.translucent = NO;
    
    [self custonLable];
    [self setImgeView];
//    [self setTableview];
    
    _plusView= [[UIView alloc]initWithFrame:CGRectMake(100, 80, 120, 120)];
    
    _plusView.layer.cornerRadius = 120/2;
    [self.view addSubview:_plusView];
   
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_plusView startPulseWithColor:[UIColor greenColor] animation:YGPulseViewAnimationTypeRegularPulsing];  //有规律的
}
- (void)setTableview {
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"CYLTableViewPlaceHolder";
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    self.dataSource = nil;
    self.tableView.dataSource =self;
    [self setUpMJRefresh];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}
- (void)setImgeView {
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    button1.backgroundColor = [UIColor redColor];
    button2.backgroundColor = [UIColor greenColor];
    button3.backgroundColor = [UIColor magentaColor];
     _timeBtn1 = button1;
    _timeBtn2 = button2;
    [_timeBtn1 setTitle:@"NSTimer获取验证码" forState:UIControlStateNormal];
     [_timeBtn2 setTitle:@"GCD获取验证码" forState:UIControlStateNormal];
    [button3 setTitle:@"我想干什么" forState:UIControlStateNormal];
    
    [button1 addTarget:self action:@selector(dosome) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(dosome2) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(dosome3) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button1];
    [self.view addSubview:button2];
    [self.view addSubview:button3];
    
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(200);
//    居中
    }];
  
 

    
    CGFloat margin = 20;
    CGFloat height = 40;
    [_timeBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).offset(margin);
        make.right.mas_equalTo(_timeBtn2.mas_left).offset(-margin);
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-margin);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(_timeBtn2.mas_width);
        make.top.mas_equalTo(_timeBtn2.mas_top);
   
    }];
    [_timeBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-margin);
        
    }];

}
- (void)dosome {
     [_timeBtn1 setTitle:@"60秒" forState:UIControlStateDisabled];
    _timeBtn1.enabled =NO; //禁止点击
    _count = 60;
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];

}
- (void)dosome2  {
    
    
    __block int count = 10;
    
    // 获得队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 创建一个定时器
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 设置定时器的各种属性（几时开始任务，每隔多长时间执行一次）
    // GCD的时间参数，一般是纳秒（1秒 == 10的9次方纳秒）
    // 何时开始执行第一个任务
    // dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC) 比当前时间晚3秒
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(self.timer, start, interval, 0);
    
    // 设置回调
    dispatch_source_set_event_handler(self.timer, ^{
        
        count  = count - 1;
        
        [_timeBtn2 setTitle:[NSString stringWithFormat:@"%d秒",count] forState:UIControlStateNormal];
        
        _timeBtn2.enabled = NO;
        
        [_timeBtn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        if (count == 0) {
            // 取消定时器
            dispatch_cancel(self.timer);
            self.timer = nil;
            
            _timeBtn2.enabled = YES;
            [_timeBtn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [_timeBtn2 setTitle:@"获取验证码" forState:UIControlStateNormal];
            
            //跳转界面
             [self gotoNextView];
            
        }
    });
    
    // 启动定时器
    dispatch_resume(self.timer);
    
}
-(void)timerFired:(NSTimer *)timer
{
    
    if (_count !=1) {
        _count -=1;
        [_timeBtn1 setTitle:[NSString stringWithFormat:@"%ld秒",_count] forState:UIControlStateDisabled];
        
    }
    else
    {
        [timer invalidate];  //定时器停止
        _timeBtn1.enabled = YES;
        [_timeBtn1 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_timeBtn1 setTitle:@"NSTimer获取验证码" forState:UIControlStateNormal];
       
    }
}
- (void)custonLable {
    
    UILabel *lb = [UILabel new];
    lb.text = @"gyjq";
    lb.font = [UIFont systemFontOfSize:30];
    lb.backgroundColor = [UIColor clearColor];
    [self.view addSubview:lb];
    lb.frame = CGRectMake(10, 10, 200, 30);
    [self.view addSubview:lb];
    /**
     
     如果内容是其他英文字母则展示正常，g，y，j，q这四个字母则会被截掉，但是如果文本是中英文混排结果又是正常的
     */
    //填坑方法
    [lb sizeToFit];//避免被字母底部都被“截”掉了一小部分
    
    
    
}
- (void)dosome3 {
    
}
- (void)setUpMJRefresh {
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];
    }];
    
    // 马上进入刷新状态
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", @"Random Data", self.dataSource[indexPath.row]];
    return cell;
}

#pragma mark - 下拉刷新数据
- (void)loadNewData {
    if (!self.isNoResult) {
        self.dataSource = nil;
    } else {
        // 1.添加假数据
        for (int i = 0; i<5; i++) {
            [self.dataSource insertObject:CYLRandomData atIndex:0];
        }
    }
    // 2.模拟1秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CYLDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView cyl_reloadData];
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.mj_header endRefreshing];
    });
}


#pragma mark - CYLTableViewPlaceHolderDelegate Method

- (UIView *)makePlaceHolderView {
    UIView *taobaoStyle = [self taoBaoStylePlaceHolder];
    UIView *weChatStyle = [self weChatStylePlaceHolder];
    return (arc4random_uniform(2)==0)?taobaoStyle:weChatStyle;
}

- (UIView *)taoBaoStylePlaceHolder {
    __block XTNetReloader *netReloader = [[XTNetReloader alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                                                  reloadBlock:^{
                                                                      [self.tableView.mj_header beginRefreshing];
                                                                  }] ;
    
    return netReloader;
}

- (UIView *)weChatStylePlaceHolder {
    WeChatStylePlaceHolder *weChatStylePlaceHolder = [[WeChatStylePlaceHolder alloc] initWithFrame:self.tableView.frame];
    weChatStylePlaceHolder.delegate = self;
    return weChatStylePlaceHolder;
}

#pragma mark - WeChatStylePlaceHolderDelegate Method

- (void)emptyOverlayClicked:(id)sender {
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark - 跳转
- (void)gotoNextView{
    
    SettingViewController * set = [[SettingViewController alloc]init];
    [set.navigationController pushViewController:set animated:YES];
}


-(void)dosomeX {
    
    [[JX_GCDTimerManager sharedInstance]cancelTimerWithName:@"mytimers"];
    
    __weak typeof(self) weakSelf = self;
    
    [[JX_GCDTimerManager sharedInstance]scheduledDispatchTimerWithName:@"mytimers" timeInterval:0.5 queue:nil
                                                               repeats:NO actionOption:AbandonPreviousAction action:^{
                                                                   
                                                                   [weakSelf dosomthing];
                                                               }];
}
-(void)dosomthing{
    
//    __weak typeof(self) weakSelf = self;
    
    _count  = _count - 1;
    
    NSLog(@"_count%ld",_count);
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        _timeBtn2.enabled = NO;
        
        [_timeBtn2 setTitle:[NSString stringWithFormat:@"%ld秒",_count] forState:UIControlStateNormal];
        
        
        [_timeBtn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    });
    
    if (_count< 1) {
        [[JX_GCDTimerManager sharedInstance] cancelTimerWithName:@"mytimers"];
        
        _timeBtn2.enabled = YES;
        [_timeBtn2 setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_timeBtn2 setTitle:@"获取验证码" forState:UIControlStateNormal];
        _count = 10;
    }
}
/* 持有timerManager的对象销毁时，将其中的timer全部撤销 */

- (void)dealloc
{
    [_JXtimer invalidate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:nil];
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
