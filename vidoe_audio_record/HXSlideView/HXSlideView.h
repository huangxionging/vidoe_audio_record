//
//  HXSlideView.h
//  XMNiao_Shop
//
//  Created by huangxiong on 8/26/15.
//  Copyright (c) 2015 HuangXiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+CoordinateRelationship.h"

/**
 *  @brief  颜色设置
 *  @param  rgbValue 是16进制数据
 *  @return 返回对应颜色
 */
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@protocol HXSlideViewDelegate;

typedef NS_ENUM(NSUInteger, HXSlideViewType) {
    
    // 表示用作可滑动条, 默认, 有指示器, 可拖动
    kHXSlideViewTypeDefault = 0,
    
    // 表示用作可滑动条, 默认, 有指示器, 不可拖动
    kHXSlideViewTypeUnableDrag,
    
    // 表示用作进度条, 无指示器, 不可拖动
    kHXSlideViewTypeProgress
};

@interface HXSlideView : UIView

/**
 *  代理协议
 */
@property (nonatomic, strong) id<HXSlideViewDelegate> delegate;

/**
 *  @brief  通过 frame 实例化
 *  @param  frame 是位置参数
 *  @return HXSlideView 实例
 */
- (instancetype)initWithFrame:(CGRect)frame andSlideType: (HXSlideViewType) slideType;

/**
 *  @brief  设置选中部分颜色
 *  @param  color 是选中部分颜色
 *  @return void
 */
- (void) setSelectColor: (UIColor *)color;

/**
 *  @brief  设置未选中部分颜色
 *  @param  color 是未选中部分颜色
 *  @return void
 */
- (void) setUnSelectColor: (UIColor *)color;

/**
 *  @brief  设置指示器部分颜色
 *  @param  color 是指示器部分颜色
 *  @return void
 */
- (void) setIndicatorColor: (UIColor *)color;

/**
 *  @brief  设置 SlideView 的进度
 *  @param  value 是进度值(0~100) 表示百分比
 *  @return void
 */
- (void) setProgressValue: (NSInteger) value;

@end

@protocol HXSlideViewDelegate <NSObject>

@optional

/**
 *  @brief  回传对应 SlideView 的百分比
 *  @param  value 是进度值
 *  @return void
 */
- (void) slideView: (HXSlideView *) slideView withProgressValue: (NSInteger) value;

@end
