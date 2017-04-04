//
//  WELKeyBoardManage.m
//  ECON
//
//  Created by WELCommand on 15/5/25.
//  Copyright (c) 2015年 WELCommand. All rights reserved.
//

#import "WELKeyBoardManage.h"
//#import "WELFrameHelp.h"
#define WELFrameHeight ([[UIScreen mainScreen] bounds].size.height)
#define WELFrameWidth ([[UIScreen mainScreen] bounds].size.width)
@implementation WELKeyBoardManage

-(id)init {
    if(self = [super init]) {
        [self addKeyboardNotification];
    }
    return self;
}

#pragma mark- arr load

-(WELKeyBoardManage *)addView:(UIView *)view {
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
    UIView *frView = [self firstResponderView];
    if(!frView) return;
    //键盘frame
    CGRect keyboardBounds;
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    //时间
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    //动画类型
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    UIScrollView *src = [self scrollerFind:frView];
    
    if(src) {
        
        CGFloat f = (frView.frame.size.height + frView.frame.origin.y) -(WELFrameHeight - keyboardBounds.size.height);
        if(f > 0) {
            CGFloat top = src.contentInset.top;
            src.contentInset = (UIEdgeInsets){top + f,src.contentInset.left,src.contentInset.right,src.contentInset.bottom};
            return;
        }
    }
    
    
    CGRect containerFrame = frView.frame;
    containerFrame.origin.y = WELFrameHeight - (keyboardBounds.size.height + containerFrame.size.height);
    
    //frView.frame = containerFrame;

    [UIView animateWithDuration:[duration doubleValue] animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:[duration doubleValue]];
        [UIView setAnimationCurve:[curve intValue]];
        frView.frame = containerFrame;
    }];
}

-(void)keyboardWillHide:(NSNotification *) note
{
    UIView *frView = [self firstResponderView];
    if(!frView) return;
    
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [note.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    
    
    UIScrollView *src = [self scrollerFind:frView];
    
    if(src) {
        src.contentInset = (UIEdgeInsets){64,src.contentInset.left,src.contentInset.right,src.contentInset.bottom};
        return;
    }
    
    CGRect containerFrame = frView.frame;
    containerFrame.origin.y = WELFrameHeight - containerFrame.size.height;
    
    [UIView animateWithDuration:[duration doubleValue] animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:[duration doubleValue]];
        [UIView setAnimationCurve:[curve intValue]];
        frView.frame = containerFrame;
    }];
}

@end
