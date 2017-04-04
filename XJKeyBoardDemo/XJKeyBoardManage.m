//
//  XJKeyBoardManage.m
//  XJKeyBoardDemo
//
//  Created by 邢进 on 2017/4/1.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import "XJKeyBoardManage.h"

#define XJFrameHeight ([[UIScreen mainScreen] bounds].size.height)

@interface XJKeyBoardManage () {
    CGFloat adjustY;
}

/*
 ********   待完善    ********
 */

@end

@implementation XJKeyBoardManage

-(id)init {
    if(self = [super init]) {
        [self addKeyboardNotification];
    }
    return self;
}

- (void)removeMyObserve {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)showBlock:(KeyBoardBlock)showBlock hideBlock:(KeyBoardBlock)hideBlock {
    _keyBoardShowBlock = showBlock;
    _keyBoardHideBlock = hideBlock;
}

-(XJKeyBoardManage *)addView:(UIView *)view {
    if(!self.keyBoardIteams) {
        self.keyBoardIteams = [[NSMutableArray alloc] init];
    }
    [self.keyBoardIteams addObject:view];
    
    return self;
}

-(UIView *)firstResponderView {
    for(UIView *v in self.keyBoardIteams) {
        if([self findFirstResponder:v]) {
            return v;
        }
    }
    return nil;
}

-(BOOL)findFirstResponder:(UIView *)v {
    if(v.isFirstResponder) return YES;
    if(v.subviews.count != 0) {
        for(UIView *view in v.subviews) {
            if([self findFirstResponder:view]) {
                return YES;
            }
        }
    }
    return NO;
}

-(UIScrollView *)scrollerFind:(UIView *)v {
    if([[v class] isSubclassOfClass:[UIScrollView class]]) {
        return (UIScrollView *)v;
    }
    if(v.superview != nil) {
        id sv = [self scrollerFind:v.superview];
        if(sv) {
            return sv;
        }
    }
    return nil;
}

#pragma mark- key board manage

-(void)addKeyboardNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}


-(void)keyboardWillShow:(NSNotification *) note
{
    if (adjustY > 0) {
        [UIView animateWithDuration:0 animations:^{
            if (_keyBoardHideBlock) {
                _keyBoardHideBlock(YES, adjustY);
            }
            adjustY = 0;
        }];
    }
    
    UIView *frView = [self firstResponderView];
    if(!frView) return;
    //键盘frame
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    //时间
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //动画类型
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    //是否需要处理键盘,以及 偏移量
    CGFloat f = (frView.frame.size.height + frView.frame.origin.y) -(XJFrameHeight - keyboardBounds.size.height);
    
    UIScrollView *src = [self scrollerFind:frView];
    if(src) {
        if(f > 0) {
            CGFloat top = src.contentInset.top;
            src.contentInset = (UIEdgeInsets){top + f,src.contentInset.left,src.contentInset.right,src.contentInset.bottom};
            return;
        }
    } else {
        adjustY = f;
        BOOL needAdjust = f > 0;
        [UIView animateWithDuration:[duration doubleValue]-0.1 animations:^{
//            [UIView setAnimationBeginsFromCurrentState:YES];
//            [UIView setAnimationDuration:[duration doubleValue]];
//            [UIView setAnimationCurve:[curve intValue]];
            if (_keyBoardShowBlock) {
                _keyBoardShowBlock(needAdjust, adjustY);
            }
        }];
    }
    
    
//    CGRect containerFrame = frView.frame;
//    containerFrame.origin.y = XJFrameHeight - (keyboardBounds.size.height + containerFrame.size.height);
//    
//    frView.frame = containerFrame;
//    
//    [UIView animateWithDuration:[duration doubleValue] animations:^{
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationDuration:[duration doubleValue]];
//        [UIView setAnimationCurve:[curve intValue]];
//        //frView.frame = containerFrame;
//    }];
}

-(void)keyboardWillHide:(NSNotification *) note
{
    UIView *frView = [self firstResponderView];
    if(!frView) return;
    
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    
//    UIScrollView *src = [self scrollerFind:frView];
//    
//    if(src) {
//        src.contentInset = (UIEdgeInsets){64,src.contentInset.left,src.contentInset.right,src.contentInset.bottom};
//        return;
//    } else {
        BOOL needAdjust = adjustY > 0;
        [UIView animateWithDuration:[duration doubleValue] animations:^{
//            [UIView setAnimationBeginsFromCurrentState:YES];
//            [UIView setAnimationDuration:[duration doubleValue]];
//            [UIView setAnimationCurve:[curve intValue]];
            if (_keyBoardHideBlock) {
                _keyBoardHideBlock(needAdjust, adjustY);
            }
            adjustY = 0;
        }];
//    }
    
//    CGRect containerFrame = frView.frame;
//    containerFrame.origin.y = XJFrameHeight - containerFrame.size.height;
//    
//    [UIView animateWithDuration:[duration doubleValue] animations:^{
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationDuration:[duration doubleValue]];
//        [UIView setAnimationCurve:[curve intValue]];
//        frView.frame = containerFrame;
//    }];
}



@end
