//
//  ViewController.m
//  XJKeyBoardDemo
//
//  Created by 邢进 on 2017/3/31.
//  Copyright © 2017年 邢进. All rights reserved.
//

#import "ViewController.h"
#import "XJKeyBoardManager.h"

@interface ViewController () <UITableViewDataSource, UITextFieldDelegate, UITextViewDelegate> {

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[XJKeyBoardManager sharedInstace] setupForKeyBoardWithView:self.view];
    //设置j
    //[[XJKeyBoardManager sharedInstace] setMarginToKeyboard:10];
}
//textField
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [XJKeyBoardManager sharedInstace].respondView = textField;
}
//textView
- (void)textViewDidBeginEditing:(UITextView *)textView {
    [XJKeyBoardManager sharedInstace].respondView = textView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    for (UIView *view in cell.contentView.subviews) {
//        if ([view isKindOfClass:[UITextField class]]) {
//            [manager addView:view];
//        }
//    }
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
