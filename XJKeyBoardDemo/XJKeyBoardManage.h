//
//  XJKeyBoardManage.h
//  XJKeyBoardDemo
//
//  Created by 邢进 on 2017/4/1.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
    ********   待完善    ********
 */

typedef void(^KeyBoardBlock)(BOOL needAdjust,CGFloat height);

@interface XJKeyBoardManage : NSObject
//keyBoardBlock
@property (nonatomic, copy)KeyBoardBlock keyBoardShowBlock;
@property (nonatomic, copy)KeyBoardBlock keyBoardHideBlock;
//存放view
@property (nonatomic, strong)NSMutableArray *keyBoardIteams;
//持有该键盘
-(XJKeyBoardManage *)addView:(UIView *)view;
//移除监听
- (void)removeMyObserve;
//处理视图
- (void)showBlock:(KeyBoardBlock)showBlock hideBlock:(KeyBoardBlock)hideBlock;


@end
