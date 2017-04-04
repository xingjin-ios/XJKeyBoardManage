//
//  KeyBoardAnimation.h
//  ScrollViewDemo
//
//  Created by Alex on 15/8/4.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KeyBoardAnimation : NSObject
/**
 *  键盘高度
 */
@property (assign, nonatomic) CGFloat keyboardHeight;
/**
 *  UITextField
 */
@property (strong, nonatomic) UITextField *textField;
/**
 *  super View
 */
@property (strong, nonatomic) UIView *view;

+(instancetype)sharedInstace;

/**
 *  按钮键盘
 *
 *  @param view super view
 */
- (void)setupForKeyBoardWithView:(UIView *)view;

@end
