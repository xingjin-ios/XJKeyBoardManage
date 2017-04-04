//
//  XJKeyBoardManager.h
//  XJKeyBoardDemo
//
//  Created by 邢进 on 2017/4/1.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
      ******  简单能处理,不处理table  ******
 */
@interface XJKeyBoardManager : NSObject

@property (nonatomic, strong)UIView *respondView;//响应视图
@property (nonatomic, assign)CGFloat marginToKeyboard;//输入框距键盘高度,默认5
+(instancetype)sharedInstace;
//self.view
- (void)setupForKeyBoardWithView:(UIView *)view;

@end
