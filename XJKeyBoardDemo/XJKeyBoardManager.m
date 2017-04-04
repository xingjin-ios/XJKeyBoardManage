//
//  XJKeyBoardManager.m
//  XJKeyBoardDemo
//
//  Created by 邢进 on 2017/4/1.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import "XJKeyBoardManager.h"

#define XJFrameHeight ([[UIScreen mainScreen] bounds].size.height)
#define XJFrameWidth ([[UIScreen mainScreen] bounds].size.width)
@interface XJKeyBoardManager()
@property (strong, nonatomic) UIView *view;
@end

@implementation XJKeyBoardManager
+ (instancetype)sharedInstace
{
    static XJKeyBoardManager *_keyboard;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keyboard = [[XJKeyBoardManager alloc]init];
        _keyboard.marginToKeyboard = 5;
    });
    return _keyboard;
}
//添加监听
- (void)setupForKeyBoardWithView:(UIView *)view
{
    self.view = view;
    // 监听键盘
    NSNotificationCenter *notification = [NSNotificationCenter defaultCenter];
    
    [notification addObserver:self selector:@selector(keyboardWillShow:) name:@"UIKeyboardWillShowNotification" object:nil];
    [notification addObserver:self selector:@selector(KeyboardWillHide:) name:@"UIKeyboardWillHideNotification" object:nil];
}
//键盘起
- (void)keyboardWillShow:(NSNotification *)note
{
    //键盘高度
    CGFloat keyboardHeight = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    //时间
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //动画类型
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];

    CGRect frame = self.respondView.frame;
    CGFloat offset = (frame.size.height + frame.origin.y) -(XJFrameHeight - keyboardHeight);
    if (offset > 0) {
        [UIView animateWithDuration:[duration doubleValue]animations:^{
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationCurve:[curve intValue]];
            CGRect rect = CGRectMake(0.0f, -offset - _marginToKeyboard,XJFrameWidth,XJFrameHeight);
            self.view.frame = rect;
         }];
    }
}
//键盘收
- (void)KeyboardWillHide:(NSNotification *)note
{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:[duration doubleValue]animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        CGRect rect = CGRectMake(0.0f, 0.0f,XJFrameWidth,XJFrameHeight);
        self.view.frame = rect;
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
