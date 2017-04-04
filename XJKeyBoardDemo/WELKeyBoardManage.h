//
//  WELKeyBoardManage.h
//  ECON
//
//  Created by WELCommand on 15/5/25.
//  Copyright (c) 2015年 WELCommand. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WELKeyBoardManage : NSObject

@property (nonatomic, strong) IBOutletCollection(UIView) NSMutableArray *keyBoardIteams;

-(WELKeyBoardManage *)addView:(UIView *)view;

@end
