//
//  CQNoNetworkView.h
//  WStarFramework
//
//  Created by jf on 16/12/15.
//  Copyright © 2016年 jf. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CheckNetworkDelegate <NSObject>
@optional

/** 重新加载数据 */
- (void)reloadData;

@end

/** 无网络时展示的view */
@interface CQNoNetworkView : UIView

@property (nonatomic,weak) id<CheckNetworkDelegate> delegate;

@end
