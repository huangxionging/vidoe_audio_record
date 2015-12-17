//
//  UIView+CoordinateRelationship.h
//  HXPieChart
//
//  Created by huangxiong on 15/8/29.
//  Copyright (c) 2015年 huangxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import <objc/message.h>

@interface UIView (CoordinateRelationship)

/**
 *  左边坐标X的值
 */
@property (nonatomic, assign) CGFloat left;

/**
 *  右边坐标X的值
 */
@property (nonatomic, assign) CGFloat right;

/**
 *  上边边坐标Y的值
 */
@property (nonatomic, assign) CGFloat top;

/**
 *  下边边边坐标Y的值
 */
@property (nonatomic, assign) CGFloat bottom;

/**
 *  宽度值
 */
@property (nonatomic, assign) CGFloat width;

/**
 *  高度值
 */
@property (nonatomic, assign) CGFloat height;

/**
 *  中点坐标的X值
 */
@property (nonatomic, assign) CGFloat centerX;

/**
 *  中点坐标的Y值
 */
@property (nonatomic, assign) CGFloat centerY;


/**
 *  左上角坐标
 */
@property (nonatomic, assign) CGPoint leftTop;

/**
 *  右上角坐标
 */
@property (nonatomic, assign) CGPoint rightTop;

/**
 *  左下角坐标
 */
@property (nonatomic, assign) CGPoint leftBottom;

/**
 *  右下角坐标
 */
@property (nonatomic, assign) CGPoint rightBottom;

/**
 *  高度和宽度构成的尺寸结构体
 */
@property (nonatomic, assign)  CGSize size;

/**
 *  @brief:  设置左边的值
 *  @param:  left 为设置值
 *  @return: 空
 */
- (void) setLeft:(CGFloat)left;

/**
 *  @brief:  获取左边坐标的X值
 *  @param:  空
 *  @return: CGFloat 类型的值
 */
- (CGFloat)left;

/**
 *  @brief:  设置右边的值
 *  @param:  right 为设置值
 *  @return: 空
 */
- (void)setRight:(CGFloat)right;

/**
 *  @brief:  获取右边的值
 *  @param:  空
 *  @return: CGFloat 类型的值
 */
- (CGFloat)right;

/**
 *  @brief:  设置上边的值
 *  @param:  top 为设置值
 *  @return: 空
 */
- (void)setTop:(CGFloat)top;

/**
 *  @brief:  获取上边的值
 *  @param:  空
 *  @return: CGFloat 类型的值
 */
- (CGFloat)top;

/**
 *  @brief:  设置下边的值
 *  @param:  bottom 为设置值
 *  @return: 空
 */
- (void)setBottom:(CGFloat)bottom;
/**
 *  @brief:  获取下边的值
 *  @param:  空
 *  @return: CGFloat 类型的值
 */
- (CGFloat)bottom;

/**
 *  @brief:  设置宽度
 *  @param:  width 为宽度
 *  @return: 空
 */
- (void)setWidth:(CGFloat)width;

/**
 *  @brief: 获取宽度
 *  @param: 无
 *  @return:宽度值, 浮点数
 */
- (CGFloat) width;

/**
 *  @brief:  设置高度
 *  @param:  height 为新的高度值
 *  @return: 空
 */
- (void)setHeight:(CGFloat)height;

/**
 *  @brief: 获取高度
 *  @param: 无
 *  @return:宽度值, 浮点数
 */
- (CGFloat) height;

/**
 *  @brief:  设置中点的x值
 *  @param:  centerX 为新的中点坐标的x值
 *  @return: 空
 */
- (void)setCenterX:(CGFloat)centerX;

/**
 *  @brief:  获取中点的x值
 *  @param:  空
 *  @return: CGFloat 类型的值
 */
- (CGFloat)centerX;

/**
 *  @brief:  设置中点的y值
 *  @param:  centerY 为新的中点坐标的x值
 *  @return: 空
 */
- (void)setCenterY:(CGFloat)centerY;

/**
 *  @brief:  获取中点的y值
 *  @param:  空
 *  @return: CGFloat 类型的值
 */
- (CGFloat)centerY;

/**
 *  @brief:  设置左上角坐标
 *  @param:  leftTop 为新的左上角坐标
 *  @return: 空
 */
- (void)setLeftTop:(CGPoint)leftTop;

/**
 *  @brief:  获取左上角坐标
 *  @param:  空
 *  @return: CGPoint 类型的值
 */
- (CGPoint)leftTop;

/**
 *  @brief:  设置右上角坐标
 *  @param:  rightTop 为新的右上角坐标
 *  @return: 空
 */
- (void)setRightTop:(CGPoint)rightTop;

/**
 *  @brief:  获取右上角坐标
 *  @param:  空
 *  @return: CGPoint 类型的值
 */
- (CGPoint)rightTop;

/**
 *  @brief:  设置左下角角坐标
 *  @param:  leftBottom 为新的左下角坐标
 *  @return: 空
 */
- (void)setLeftBottom:(CGPoint)leftBottom;

/**
 *  @brief:  获取左下角坐标
 *  @param:  空
 *  @return: CGPoint 类型的值
 */
- (CGPoint)leftBottom;

/**
 *  @brief:  设置右下角角坐标
 *  @param:  rightBottom 为新的右下角坐标
 *  @return: 空
 */
- (void)setRightBottom:(CGPoint)rightBottom;

/**
 *  @brief:  获取右下角坐标
 *  @param:  空
 *  @return: CGPoint 类型的值
 */
- (CGPoint)rightBottom;

/**
 *  @brief:  设置尺寸信息
 *  @param:  size 为新的尺寸信息
 *  @return: 空
 */
- (void)setSize:(CGSize)size;

/**
 *  @brief:  获取尺寸信息
 *  @param:  空
 *  @return: CGSize 类型的值
 */
- (CGSize)size;

#pragma mark---坐标调整, 即只调整改属性, 其它不相干属性不变

/**
 *  @brief:  调整左边
 *  @param:  left 是新的左边, 如果left比原右边还右, 则以平移为结果, 否则就是右边不变只调整左边
 *  @return: 空
 */
- (void) scaleLeft: (CGFloat) left;

/**
 *  @brief:  调整右边
 *  @param:  right 是新的右边, 如果right比原左边还左, 则以平移为结果, 否则就是右边变左边不变
 *  @return: 空
 */
- (void) scaleRight: (CGFloat) right;

/**
 *  @brief:  调整上边
 *  @param:  top 是新的上边, 如果top比原底边还低, 则以平移为结果, 否则就是新的上边变, 底部不变
 *  @return: 空
 */
- (void) scaleTop: (CGFloat) top;

/**
 *  @brief:  调整底部
 *  @param:  bottom 是新的底部, 如果bottom比原上边还上, 则以平移为结果, 否则就是新的底部, 上边不变
 *  @return: 空
 */
- (void) scaleBottom: (CGFloat) bottom;

/**
 *  @brief:  调整值
 *  @param:   value 是新的值, key 是属性
 *  @return: 空
 */
- (void) scaleValue: (id)value forKey: (NSString *)key;

/**
 *  @brief:  调整边值,即上下左右
 *  @param:  value 是新的值, key 是属性
 *  @return: 空
 */
- (void) scaleEdgeValue: (CGFloat)value forKey: (NSString *)key;

@end
