//
//  KeyBoardAnimation.m
//  ScrollViewDemo
//
//  Created by Alex on 15/8/4.
//  Copyright (c) 2015年 Alex. All rights reserved.
//

#import "KeyBoardAnimation.h"
#define animationDuration 0.3f
#define XJFrameHeight ([[UIScreen mainScreen] bounds].size.height)
@implementation KeyBoardAnimation

+ (instancetype)sharedInstace
{
    static KeyBoardAnimation *_keyboard;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keyboard = [[KeyBoardAnimation alloc]init];
    });
    return _keyboard;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)setupForKeyBoardWithView:(UIView *)view
{
    self.view = view;
    
    // 监听键盘
     NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    
    [notification addObserver:self selector:@selector(keyboardWillShow:) name:@"UIKeyboardWillShowNotification" object:nil];
    [notification addObserver:self selector:@selector(KeyboardWillHide:) name:@"UIKeyboardWillHideNotification" object:nil];
    
    // 增加手势
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGusture)];
    [view addGestureRecognizer:tapGesture];
}

/**
 *  键盘即将出现
 *
 *  @param note NSNotification
 */
- (void)keyboardWillShow:(NSNotification *)note
{
    //键盘高度
    CGFloat keyboardH = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    self.keyboardHeight = keyboardH;
    NSLog(@"键盘高度%.1f",keyboardH);
    [self keyBoardBeginAnimation];
    
}

/**
 *  键盘即将消失
 *
 *  @param note NSNotification
 */
- (void)KeyboardWillHide:(NSNotification *)note
{
    [self keyBoardEndAnimation];
    
}

/**
 *  手势
 */
- (void)tapGusture
{
    [self.view endEditing:YES];
}

/**
 *  键盘弹出动画
 */
- (void)keyBoardBeginAnimation
{
    CGRect frame = self.textField.frame;
    //NSInteger offset = frame.origin.y - frame.size.height - (self.view.frame.size.height - self.keyboardHeight);
    CGFloat offset = (frame.size.height + frame.origin.y) -(XJFrameHeight - self.keyboardHeight);
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    
    [UIView commitAnimations];
}

/**
 *  键盘消失动画
 */
- (void)keyBoardEndAnimation
{
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
}

@end
