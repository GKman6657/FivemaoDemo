//
//  DIDAViewController.m
//  WStarFramework
//
//  Created by jf on 16/12/28.
//  Copyright © 2016年 jf. All rights reserved.
//

#import "DIDAViewController.h"
#import "MMComBoBoxView.h"
#import "MMItem.h"
#import "MMAlternativeItem.h"
#import "MMSelectedPath.h"
@interface DIDAViewController ()<MMComBoBoxViewDataSource, MMComBoBoxViewDelegate>
@property (nonatomic, strong) NSMutableArray *mutableArray;


@end

@implementation DIDAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configHeadroot];
    [self initBoxView];
}
- (void)initBoxView {
    
    MMComBoBoxView *view = [[MMComBoBoxView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    view.dataSource = self;
    view.delegate = self;
    [self.view addSubview:view];
    
    [view reload];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, view.bottom, self.view.width, self.view.height - 64)];
    imageView.image = [UIImage imageNamed:@"1.jpg"];
    [self.view addSubview:imageView];
}
- (void)configHeadroot{
    
    //first root
    MMItem *rootItem1 = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"全部"]; //不可以选中
    //first floor
    rootItem1.selectedType = MMPopupViewMultilSeMultiSelection;   //多选
    for (int i = 0; i < 20; i ++) {
        [rootItem1 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"精品系列%d",i] subTileName: [NSString stringWithFormat:@"%ld",random()%10000]]];  //可以选中
    }
    
    //second root
    MMItem *rootItem2 = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"排序"];//不可以选中
    //first floor
    [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"智能排序"]]];
    [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"离我最近"]]];
    [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"好评优先"]]];
    [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"人气最高"]]];
    
    //third root
    MMItem *rootItem3 = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"附近"];//不可以选中
    for (int i = 0; i < 30; i++) {
        MMItem *item3_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:[NSString stringWithFormat:@"市区%d",i]];
                                                                      //不可以选中
         [rootItem3 addNode:item3_A];
        
        for (int j = 0; j < random()%30; j ++) {
            if (i == 0 &&j == 0) {
                [item3_A addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"市区%d县%d",i,j]subTileName:[NSString stringWithFormat:@"%ld",random()%10000]]];//可以选中
            }else{
                [item3_A addNodeWithoutMark:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"市区%d县%d",i,j]subTileName:[NSString stringWithFormat:@"%ld",random()%10000]]];//可以选中
            }
        }
    }
    
    //fourth root
    MMItem *rootItem4 = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"筛选"]; //不可以选中
    MMAlternativeItem *alternativeItem1 = [MMAlternativeItem itemWithTitle:@"只看免预约" isSelected:NO];
    MMAlternativeItem *alternativeItem2 = [MMAlternativeItem itemWithTitle:@"节假日可用" isSelected:YES];
    [rootItem4.alternativeArray addObject:alternativeItem1];
    [rootItem4.alternativeArray addObject:alternativeItem2];
    
    
    NSArray *arr = @[@{@"用餐时段":@[@"不限",@"早餐",@"午餐",@"下午茶",@"晚餐",@"夜宵"]},
                     @{@"用餐人数":@[@"不限",@"单人餐",@"双人餐",@"3~4人餐",@"5~10人餐",@"10人以上",@"代金券",@"其他"]},
                     @{@"餐厅服务":@[@"不限",@"优惠买单",@"在线点餐",@"外卖送餐",@"预定",@"食客推荐",@"在线排队"]} ];
    

    for (NSDictionary *itemDic in arr) {
        MMItem * item4_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:[itemDic.allKeys lastObject]];

        [rootItem4 addNode:item4_A];
        for (NSString *title in [itemDic.allValues lastObject]) {
            [item4_A addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:title]];  //不可以选中
        }
    }
    
    self.mutableArray = [NSMutableArray arrayWithCapacity:0];
    [self.mutableArray addObject:rootItem1];
    [self.mutableArray addObject:rootItem2];
    [self.mutableArray addObject:rootItem3];
    [self.mutableArray addObject:rootItem4];
}

#pragma mark - MMComBoBoxViewDataSource
- (NSUInteger)numberOfColumnsIncomBoBoxView :(MMComBoBoxView *)comBoBoxView {
    return self.mutableArray.count;
}
- (MMItem *)comBoBoxView:(MMComBoBoxView *)comBoBoxView infomationForColumn:(NSUInteger)column {
    return self.mutableArray[column];
}
#pragma mark - MMComBoBoxViewDelegate
- (void)comBoBoxView:(MMComBoBoxView *)comBoBoxViewd didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index {
    
    MMItem *rootItem = self.mutableArray[index];
    switch (rootItem.displayType) {
        case MMPopupViewDisplayTypeNormal:
            break;
        case MMPopupViewDisplayTypeMultilayer: {
            //拼接选择项
            NSMutableString *title = [NSMutableString string];
            __block NSInteger firstPath;
            
            [array enumerateObjectsUsingBlock:^(MMSelectedPath *path, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [title appendString:idx ? [NSString stringWithFormat:@";%@",[rootItem findTitleBySelectedPath:path]] : [rootItem findTitleBySelectedPath:path] ];
                
                if (idx == 0) {
                    firstPath = path.firstPath;
                }
            }];
            NSLog(@"当title为%@时，所选字段为 %@",rootItem.title ,title);
        }
            break;
        case MMPopupViewDisplayTypeFilters: {
            
            [array enumerateObjectsUsingBlock:^(MMSelectedPath * path, NSUInteger idx, BOOL * _Nonnull stop) {
                
                 //当displayType为MMPopupViewDisplayTypeFilters时有MMAlternativeItem类型和MMItem类型两种
                if (path.isKindOfAlternative == YES) {//MMAlternativeItem类型
                    MMAlternativeItem * alretItem = rootItem.alternativeArray[path.firstPath];
                    
                    NSLog(@"当title 为%@时，选中状态为 %d",alretItem.title,alretItem.isSelected);
                    
                }else {//MMItem
                    MMItem *firstItem = rootItem.childrenNodes[path.firstPath];
                    MMItem *SecondItem = rootItem.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
                    NSLog(@"当title为%@时，所选字段为 %@",firstItem.title,SecondItem.title);
                }
            }];
            
        }
            break;
        default:
            break;
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
