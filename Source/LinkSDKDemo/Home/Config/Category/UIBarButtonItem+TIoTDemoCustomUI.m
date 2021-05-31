//
//  UIBarButtonItem+TIoTDemoCustomUI.m
//  LinkSDKDemo
//
//  Created by ccharlesren on 2021/5/31.
//  Copyright © 2021 Tencent. All rights reserved.
//

#import "UIBarButtonItem+TIoTDemoCustomUI.h"

@implementation UIBarButtonItem (TIoTDemoCustomUI)
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image selectImage:(NSString *)selectImage{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置图片
    if (image) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    
    if (selectImage) {
        [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateHighlighted];
    }
    
    // 设置尺寸
    CGRect bframe = btn.frame;
    bframe.size = CGSizeMake(30, 30);
    btn.frame = bframe;
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [btn addTarget:target  action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end