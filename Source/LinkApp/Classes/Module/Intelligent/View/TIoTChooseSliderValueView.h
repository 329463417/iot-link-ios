//
//  TIoTChooseSliderValueView.h
//  LinkApp
//
//  Created by ccharlesren on 2020/11/4.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TIoTCustomSlider : UISlider

@end

/**
 物模型 int 和 float 是slider滑动选择样式
 */
@interface TIoTChooseSliderValueView : UIView
@property (nonatomic, copy) NSString *showValue;
@property (nonatomic, strong) TIoTPropertiesModel *model;
@end

NS_ASSUME_NONNULL_END