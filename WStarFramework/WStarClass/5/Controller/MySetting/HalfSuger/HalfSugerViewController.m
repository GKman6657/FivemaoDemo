//
//  HalfSugerViewController.m
//  WStarFramework
//
//  Created by jf on 17/1/1.
//  Copyright © 2017年 jf. All rights reserved.
//

#import "HalfSugerViewController.h"
#import "SDCycleScrollView.h"
#import "GKHeadView.h"
#import "UIButton+Util.h"
#import "KGHalfViewController.h"


#define CATEGORY  @[@"推荐",@"原创",@"热门",@"美食",@"生活",@"设计感",@"家居",@"礼物",@"阅读",@"运动健身",@"旅行户外"]

#define NAVBARHEIGHT 64.0f

#define FONTMAX 15.0
#define FONTMIN 14.0
#define PADDING 15.0

@interface HalfSugerViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *currentTableView;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic,strong)  GKHeadView *gkHeadView;
///
//滑动事件相关
///
@property (nonatomic, strong) UIScrollView *segmentScrollView;
@property (nonatomic, strong) UIImageView *currentSelectedItemImageView;
@property (nonatomic, strong) UIScrollView *bottomScrollView;  //

//存放button
@property(nonatomic,strong)NSMutableArray *titleButtons;
//存放控制器
@property(nonatomic,strong)NSMutableArray *controlleres;
//存放TableView
@property(nonatomic,strong)NSMutableArray *tableViews;
//记录当前偏移量
@property (nonatomic, assign) CGFloat lastTableViewOffsetY;
@end

@implementation HalfSugerViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        self.titleButtons = [[NSMutableArray alloc] initWithCapacity:CATEGORY.count];
        self.controlleres = [NSMutableArray arrayWithCapacity:CATEGORY.count];
        self.tableViews = [[NSMutableArray alloc] initWithCapacity:CATEGORY.count];
        
        [self.view addSubview:self.bottomScrollView];
    
        [self.view addSubview:self.segmentScrollView];
        
        [self.view addSubview:self.cycleScrollView];
        //区头
        self.gkHeadView.tableViews = [NSMutableArray arrayWithArray:self.tableViews];
        [self.view addSubview:self.gkHeadView];
        
         self.automaticallyAdjustsScrollViewInsets = NO;

    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}
#pragma mark ---KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    UITableView * tableView  = (UITableView *)object;
    
    if (!(self.currentTableView == tableView)) {
        return;
    }
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    
    CGFloat tableviewOffsetY = tableView.contentOffset.y;  //y轴坐标
    NSLog(@"半塘--%@,--%f",tableView,tableviewOffsetY);
    self.lastTableViewOffsetY = tableviewOffsetY;
    if (tableviewOffsetY > 0 && tableviewOffsetY < 136) {
        //不上也不下
        self.segmentScrollView.frame = CGRectMake(0, 200-tableviewOffsetY, kScreenWidth, 40);
         self.cycleScrollView.frame = CGRectMake(0, 0-tableviewOffsetY, kScreenWidth, 200);
        
    }else if (tableviewOffsetY < 0){
        
        self.segmentScrollView.frame = CGRectMake(0, 200, kScreenWidth, 40);
        self.cycleScrollView.frame = CGRectMake(0, 0, kScreenWidth, 200);
    }else if (tableviewOffsetY > 136){
        self.segmentScrollView.frame = CGRectMake(0, 64, kScreenWidth, 40);
        self.cycleScrollView.frame = CGRectMake(0, -136, kScreenWidth, 200);
    }
    
}
#pragma mark -UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView != self.bottomScrollView) {
        return;
    }
    
    
}

#pragma mark -- lazy load
- (SDCycleScrollView *)cycleScrollView {
    
    if (!_cycleScrollView) {
      NSMutableArray *imageMutableArray = [NSMutableArray array];
        for (int i =1; i < 9; i ++) {
            NSString *iamgeName = [NSString stringWithFormat:@"cycle_%02d.jpg",i];
            [imageMutableArray addObject:iamgeName];
        }
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 200) imageNamesGroup:imageMutableArray];
    }
    return _cycleScrollView;
}
- (GKHeadView *)gkHeadView {
    if (!_gkHeadView) {
        
        _gkHeadView = [[GKHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        _gkHeadView.backgroundColor = [UIColor yellowColor];
    }
    return _gkHeadView;
}

- (UIImageView *)currentSelectedItemImageView {
    if (!_currentSelectedItemImageView) {
        
        _currentSelectedItemImageView = [[UIImageView alloc] init];
        _currentSelectedItemImageView.image = [UIImage imageNamed:@"nar_bgbg"];
    }
    return _currentSelectedItemImageView;
}

- (UIScrollView *)bottomScrollView {
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeigth)];
        
        _bottomScrollView.delegate = self;
        _bottomScrollView.pagingEnabled = YES;
        
        
        NSArray *colors = @[[UIColor redColor],[UIColor blueColor],[UIColor grayColor],[UIColor greenColor],[UIColor purpleColor],[UIColor orangeColor],[UIColor whiteColor],[UIColor redColor],[UIColor blueColor],[UIColor grayColor],[UIColor greenColor]];
        
        for (int i = 0; i<CATEGORY.count; i++){
            
            KGHalfViewController *gkTableView = [[KGHalfViewController alloc]init];
            gkTableView.view.frame = CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeigth);
            gkTableView.view.backgroundColor = colors[i];
            
            [self.bottomScrollView addSubview:gkTableView.view];
            
            [self.tableViews addObject:gkTableView.tableView];
            [self.controlleres addObject:gkTableView];
            //  KVO
            NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
            [gkTableView.tableView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
            
             //下拉刷新动画
            

        }
        self.currentTableView = self.tableViews[0];
        self.bottomScrollView.contentSize = CGSizeMake(self.controlleres.count * kScreenWidth, 0);
    }
    return _bottomScrollView;
}

- (UIScrollView *)segmentScrollView {
    if (!_segmentScrollView) {
        
        _segmentScrollView =  [[UIScrollView alloc]initWithFrame:CGRectMake(0, 200, kScreenWidth, 40)];
        [_segmentScrollView addSubview:self.currentSelectedItemImageView];
        _segmentScrollView.showsHorizontalScrollIndicator = NO;
        _segmentScrollView.showsVerticalScrollIndicator = NO;
        _segmentScrollView.backgroundColor = [UIColor whiteColor];
        
        NSInteger btnoffset = 0;
        
        for (int i = 0; i<CATEGORY.count; i++){
            //按钮时间
            UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:CATEGORY[i] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            
            btn.titleLabel.font = [UIFont systemFontOfSize:FONTMIN];
            
            //设置根据文字 调整宽度
            CGSize size = [UIButton sizeOfLabelWithCustomMaxWidth:kScreenHeigth systemFontSize:FONTMIN andFilledTextString:CATEGORY[i]];
            
            float originX =  i? PADDING*2+btnoffset:PADDING;  //不等于0 成立的话，就是PADDING*2+btnoffset
            
            btn.frame = CGRectMake(originX, 14, size.width, size.height);
            btnoffset = CGRectGetMaxX(btn.frame);
            btn.titleLabel.textAlignment = NSTextAlignmentLeft;
            [btn addTarget:self action:@selector(changeSelectedItem:) forControlEvents:UIControlEventTouchUpInside];
            [_segmentScrollView addSubview:btn];
            
            [self.titleButtons addObject:btn];
            //默认选中第一个按钮
            if (i == 0) {
                btn.selected = YES;
                _currentSelectedItemImageView.frame = CGRectMake(PADDING, self.segmentScrollView.frame.size.height - 2, btn.frame.size.width, 2);
            }
            
        }
        
        _segmentScrollView.contentSize = CGSizeMake(btnoffset+PADDING, 25);
        
    }
    return _segmentScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma  mark - 选项卡点击事件
-(void)changeSelectedItem:(UIButton *)currentButton {
    
    for (UIButton *button in self.titleButtons) {
        button.selected = NO;
    }
    currentButton.selected = YES;
    
    NSInteger index = [self.titleButtons indexOfObject:currentButton];
    
    self.currentTableView = self.tableViews[index];
    
    for (UITableView *tableView in self.tableViews) {
        
        if ( self.lastTableViewOffsetY>=0 &&  self.lastTableViewOffsetY<=136) {
            tableView.contentOffset = CGPointMake(0,  self.lastTableViewOffsetY);
            
        }else if(self.lastTableViewOffsetY < 0){
            tableView.contentOffset = CGPointMake(0, 0);
            
        }else if ( self.lastTableViewOffsetY > 136){
            tableView.contentOffset = CGPointMake(0, 136);
        }
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        
        if (index == 0) {
           
            //
        self.currentSelectedItemImageView.frame = CGRectMake(PADDING, self.segmentScrollView.frame.size.height - 2,currentButton.frame.size.width, 2);
            
        }else {
            
            UIButton *preBtn = self.titleButtons[index - 1];
            float offsetX = CGRectGetMinX(preBtn.frame)-PADDING*2;
            
            [self.segmentScrollView scrollRectToVisible:CGRectMake(offsetX, 0, self.segmentScrollView.frame.size.width, self.segmentScrollView.frame.size.height) animated:YES];
            
            self.currentSelectedItemImageView.frame = CGRectMake(CGRectGetMinX(currentButton.frame), self.segmentScrollView.frame.size.height-2, currentButton.frame.size.width, 2);
        }
        self.bottomScrollView.contentOffset = CGPointMake(kScreenWidth *index, 0);
    }];
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
