//
//  FourViewController.m
//  WStarFramework
//
//  Created by jf on 16/11/15.
//  Copyright © 2016年 jf. All rights reserved.
//
#pragma mark - 宏定义 宽高
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN [UIScreen mainScreen].bounds.size
#import "FourViewController.h"
#import "MBProgressHUD.h"
#import "UIButton+Util.h"
#import "UIColor+Category.h"
#import "UIView+frameAdjust.h"
#import "CustomButton.h"
#import "WLmodel.h"
#import "PYSearch.h"
#import "PYTempViewController.h"
@interface FourViewController ()<UITableViewDelegate,UITableViewDataSource,PYSearchViewControllerDelegate>
{
    UIButton *_button;
    
}
@property (nonatomic, strong) UITableView *mTableView;
/** 缓存cell高度的数组 */
@property (nonatomic,strong) NSMutableArray *heightArray;
@property (strong, nonatomic) NSMutableArray *dataArray;

@property (nonatomic,strong) UIButton *bottomButton;
@property (nonatomic, assign) CGFloat offsetY;
@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self update];
    [self configUI];
}

- (NSMutableArray *)heightArray{
    if (_heightArray == nil) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}
- (void)configUI {
    self.mTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.mTableView];
    
    self.bottomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height - 100, 50, 50);
    [self.bottomButton setBackgroundImage:[UIImage imageNamed:@"btn_bg_p"] forState:UIControlStateNormal];

    [self.view addSubview:self.bottomButton];
    
   
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? 5 : 6;//section 非0 （成立）就是5 否者就是6
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if (indexPath.section == 0) { // 选择热门搜索风格
        cell.textLabel.text = @[@"PYHotSearchStyleDefault", @"PYHotSearchStyleColorfulTag", @"PYHotSearchStyleBorderTag", @"PYHotSearchStyleARCBorderTag", @"PYHotSearchStyleRankTag", @"PYHotSearchStyleRectangleTag"][indexPath.row];
    } else { // 选择搜索历史风格
        cell.textLabel.text = @[@"PYSearchHistoryStyleDefault", @"PYSearchHistoryStyleNormalTag", @"PYSearchHistoryStyleColorfulTag", @"PYSearchHistoryStyleBorderTag", @"PYSearchHistoryStyleARCBorderTag"][indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"Java", @"Python", @"Objective-C", @"Swift", @"C", @"C++", @"PHP", @"C#", @"Perl", @"Go", @"JavaScript", @"R", @"Ruby", @"MATLAB"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索编程语言" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        [searchViewController.navigationController pushViewController:[[PYTempViewController alloc] init] animated:YES];
    }];
    // 3. 设置风格
    if (indexPath.section == 0) { // 选择热门搜索
        searchViewController.hotSearchStyle = (NSInteger)indexPath.row; // 热门搜索风格根据选择
        searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    } else { // 选择搜索历史
        searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格为默认
        searchViewController.searchHistoryStyle = (NSInteger)indexPath.row; // 搜索历史风格根据选择
    }
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
    [self presentViewController:nav  animated:NO completion:nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return section ? @"选择搜索历史风格（热门搜索为默认风格）" : @"选择热门搜索风格（搜索历史为默认风格）";
}
#pragma mark - PYSearchViewControllerDelegate
- (void)searchViewController:(PYSearchViewController *)searchViewController searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    if (searchText.length) { // 与搜索条件再搜索
        // 根据条件发送查询（这里模拟搜索）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 搜素完毕
            // 显示建议搜索结果
            NSMutableArray *searchSuggestionsM = [NSMutableArray array];
            for (int i = 0; i < arc4random_uniform(5) + 10; i++) {
                NSString *searchSuggestion = [NSString stringWithFormat:@"搜索建议 %d", i];
                [searchSuggestionsM addObject:searchSuggestion];
            }
            // 返回
            searchViewController.searchSuggestions = searchSuggestionsM;
        });
    }
}
#pragma mark - 计算高度 为了缓存
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height;
    
    if (self.heightArray.count > indexPath.row) {
        // 如果有缓存的高度，取出缓存高度
        height = [self.heightArray[indexPath.row] floatValue];;
    }else{
        // 无缓存高度，计算高度，并加入数组
        
        // 高度根据评论内容多少自适应
        WLmodel *model = self.dataArray[indexPath.row];
        // 列寬
        CGFloat contentWidth = SCREEN_WIDTH-20;
        // 用何種字體進行顯示
        UIFont *font = [UIFont systemFontOfSize:13];
        // 计算size
        CGSize size = [model.comment_content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 1000) lineBreakMode:UILineBreakModeWordWrap];
        
        // 這裏返回需要的高度
        height = size.height+60;
        // 加入数组
        [self.heightArray addObject:[NSNumber numberWithDouble:height]];
    }
    return height;
}
//-- ----       刷新tableView时记得清空高度缓存数组   --- - - - - - - - - - -
// 设置表头
//self.contentTableView.header = [CQHeader headerWithRefreshingBlock:^{
//    _page = 1;
//    [self.heightArray removeAllObjects];
//    [self getDataIsRefresh:YES];
//}];


- (void)update {
    
    CustomButton *button = [[CustomButton alloc]initWithFrame:CGRectMake(100, 200, 69, 21) borderColor:[UIColor colorWithHexString:@"ff0000" alpha:1] borderWidth:2];
    _button = button;
    [button setTitle:@"立即购买" forState:UIControlStateNormal];
    [self.view addSubview:button];
//    button.btnName = @"青岛大妈";
    [_button addTarget:self action:@selector(changeColor) forControlEvents:UIControlEventTouchDown];
    

}
- (void)changeColor{
    // 获取button所在的viewController
    UIViewController *currentVC = [_button getCurrentViewController];
    // 改变viewController的背景颜色
    currentVC.view.backgroundColor = [UIColor brownColor];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //判断滑动到底部
    if (scrollView.contentOffset.y == scrollView.contentSize.height - self.mTableView.frame.size.height) {
        //按钮出现
        [UIView transitionWithView:self.bottomButton duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height - 100, 50, 50);
        } completion:NULL];
    }
    
    if (scrollView.contentOffset.y > self.offsetY && scrollView.contentOffset.y > 0) {//如果当前位移大于缓存位移，说明scrollView向上滑动
        //按钮消失
        [UIView transitionWithView:self.bottomButton duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height, 50, 50);
        } completion:NULL];
    }else if (scrollView.contentOffset.y < self.offsetY){
        //按钮出现
        [UIView transitionWithView:self.bottomButton duration:0.1 options:UIViewAnimationOptionTransitionNone animations:^{
            self.bottomButton.frame = CGRectMake(SCREEN.width / 2 - 25, SCREEN.height - 100, 50, 50);
        } completion:NULL];
    }
    self.offsetY = scrollView.contentOffset.y;//将当前位移变成缓存位移
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
