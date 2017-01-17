//
//  OneViewController.m
//  WStarFramework
//
//  Created by jf on 16/11/15.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "OneViewController.h"
#import "Person.h"
#import "PopAnimationTableViewCell.h"
#import "FacebookButtonAnimationViewController.h"
#import "WrongPasswordViewController.h"
#import "CustomVCTransitionViewController.h"
#import "MJRefresh.h"

#import "GKCleanCaches.h"
#import "AMSmoothAlertView.h"
#import "UIColor+Category.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIImageView+WebCache.h>
#import "SettingViewController.h"
#import "TAPViewController.h"
#import "DIDAViewController.h"
#import "DropViewController.h"
#import "HalfSugerViewController.h"
@interface OneViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * mTableView;
@property (nonatomic,strong)NSArray *titles;
@end

@implementation OneViewController
static NSString * indef = @"PopAnimationTableViewCellindef";

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.titleTextAttributes = nil;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"f8f8f8" alpha:1];;
    self.navigationController.navigationBar.translucent = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"第一";
    
    NSUserDefaults *userdefult = [NSUserDefaults standardUserDefaults];
    NSString * string = @"www.baidu.com";
    [userdefult setObject:string forKey:@"webset"];
    [userdefult synchronize];
    
    NSString * resultString = [userdefult objectForKey:@"webset"];
    NSLog(@"result ---%@",resultString);
   
    
    [userdefult removeObjectForKey:@"webset"];
    NSDictionary * dic = userdefult.dictionaryRepresentation;
    NSLog(@"discrip---%@",dic);
    
    
    
//    [self dosome];
    [self deeplyCopy];
    
    [self jsonToData];
    [self KVC];
 
    
    [self titles];
    [self FaceBookAnimation];
  
}
- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"FaceBook Like & Send",@" Wrong Password",@"Custom VC Transition",@"CustomAlertView",@"Setting",@"TAPromotee",@"DIDADI",@"YUXI",@"Half_Suger"];
    }
    return _titles;
}
- (void)dosome {
    
    Person * person = [[Person alloc]init];
    person.name = @"name";
    person.sex = @"sex";
    person.age = 26;
    
    NSData * perData = [NSKeyedArchiver archivedDataWithRootObject:person];
    NSLog(@"perData ---%@",perData);
}
- (void)deeplyCopy {
    NSString * string1 = @"string1";
    NSLog(@"string1 -----%p",string1);
    
    
    NSString * string2 = [string1 copy];
    NSLog(@"string2 -----%p",string2);
    
    
    NSMutableString * mutableString = [NSMutableString stringWithString:string1];
    NSLog(@"mutableString ---%p",mutableString);
    
    NSString * string3 = [mutableString copy];
    NSLog(@"string3 ---%p",string3);
    
    
    NSMutableString *mutableStringCopy = [string1 mutableCopy];
    NSLog(@"mutableStringCopy ---%p",mutableStringCopy);
    
    mutableStringCopy = [mutableString mutableCopy];
    NSLog(@"mutableStringCopy+mutableString ---%p",mutableStringCopy);
}

- (void)jsonToData {
    NSDictionary * jsonDict = @{@"name":@"WMX",@"age":@26};
    NSData * data = [NSJSONSerialization dataWithJSONObject:jsonDict options:0 error:nil];
    
    NSLog(@"data -- --- %@",data);
    
    NSString * jsonString = @"{\"name\":\"Stans\"}";
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary * resultDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    NSLog(@"result ---%@",resultDic);
}
- (void)KVC {
    User * sue = [[User alloc]init];
    
    [sue setValue:@"default" forKey:@"name"];
    [sue setValue:@"man" forKey:@"sex"];
    [sue setValue:@18 forKey:@"age"];
    NSLog(@"user --%@",sue);
    
}

- (void)FaceBookAnimation {
    
    
    /**
     使用POP可以创建4类动效：: spring, decay, basic and custom.
     Spring （弹性）动效可以赋予物体愉悦的弹性效果
     Decay （衰减) 动效可以用来逐渐减慢物体的速度至停止
     Basic（基本）动效可以在给定时间的运动中插入数值调整运动节奏
     Custom（自定义）动效可以让设计值创建自定义动效，只需简单处理CADisplayLink，并联系时间-运动关系
     */
    self.mTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.mTableView];
    
    self.mTableView.dataSource = self;
    self.mTableView.delegate = self;
    self.mTableView.scrollIndicatorInsets = self.mTableView.contentInset;  //滚动条的内边距
    // 告诉tableView的真实高度是自动计算的，根据你的约束来计算
    self.mTableView.rowHeight = UITableViewAutomaticDimension;
    // 告诉tableView所有cell的估计行高
    self.mTableView.estimatedRowHeight = 44;
    
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.mTableView registerClass:[PopAnimationTableViewCell class] forCellReuseIdentifier:indef];
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6+1+1+1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PopAnimationTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indef];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;//右侧的小灰色箭头
    cell.textLabel.text = _titles[indexPath.row];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
      UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      UIViewController * vc = nil;
    if (indexPath.row == 0) {
      
        FacebookButtonAnimationViewController * fvc  = [story instantiateViewControllerWithIdentifier:@"FacebookButtonAnimationViewController"];
        vc = fvc;
       
    }else if (indexPath.row == 1) {
        WrongPasswordViewController * wvc = [story instantiateViewControllerWithIdentifier:@"WrongPasswordViewController"];
        vc = wvc;
    }
    else if (indexPath.row == 2) {
      CustomVCTransitionViewController *cvc  = [story instantiateViewControllerWithIdentifier:@"CustomVCTransitionViewController"];
        vc = cvc;
    }
    else if (indexPath.row == 4) {
        SettingViewController *set  = [[SettingViewController alloc]init];
        [self.navigationController pushViewController:set animated:YES];
        
    }
    else if (indexPath.row == 5) {
        TAPViewController *set  = [[TAPViewController alloc]init];
        [self.navigationController pushViewController:set animated:YES];
    }
    else if (indexPath.row == 6) {
        DIDAViewController *DI  = [[DIDAViewController alloc]init];
        [self.navigationController pushViewController:DI animated:YES];
    }
    else if (indexPath.row == 7) {
        DropViewController *DI  = [[DropViewController alloc]init];
        [self.navigationController pushViewController:DI animated:YES];
    } 
    else if (indexPath.row == 8) {
        HalfSugerViewController * halfSuger = [[HalfSugerViewController alloc]init];
        [self.navigationController pushViewController:halfSuger animated:YES];
    }
    else if (indexPath.row == 3){
        
        float tmpSize = [GKCleanCaches folderSizeAtPath:[GKCleanCaches getCachesPath:@"Caches"]];  //文件夹大小
        
       NSUInteger  ing = [[SDImageCache sharedImageCache] getSize];
        NSLog(@"缓存大小 --%f\n--%lu",tmpSize,(unsigned long)ing);
        
        NSString *message = tmpSize >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",tmpSize] : [NSString stringWithFormat:@"清理缓存(%.2fK)",tmpSize * 1024];
        
        //这是自定义alertView
        AMSmoothAlertView *alert = [[AMSmoothAlertView alloc] initDropAlertWithTitle:@"" andText:message andCancelButton:YES forAlertType:AlertSuccess withCompletionHandler:^(AMSmoothAlertView *alertObj, UIButton * button) {
            
            if(button == alertObj.defaultButton) {
                [GKCleanCaches clearCache:[GKCleanCaches getCachesPath:@"Caches"]];
            } else {
                NSLog(@"Others");
                
                [SDWebImageManager.sharedManager.imageCache clearMemory];
                [SDWebImageManager.sharedManager.imageCache clearDiskOnCompletion:nil];
            }
        }];
      
        [alert show];
    }
     [self.navigationController pushViewController:vc animated:YES];
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
