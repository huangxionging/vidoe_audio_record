//
//  UIView+CoordinateRelationship.m
//  HXPieChart
//
//  Created by huangxiong on 15/8/29.
//  Copyright (c) 2015年 huangxiong. All rights reserved.
//

#import "UIView+CoordinateRelationship.h"


#pragma mark---坐标平移系统
@implementation UIView (CoordinateRelationship)

#pragma mark---设置左边x值
- (void)setLeft:(CGFloat)left {
    CGRect newFrame = self.frame;
    newFrame.origin.x = left;
    self.frame = newFrame;
}

#pragma mark---左边值
- (CGFloat)left {
    return self.frame.origin.x;
}

#pragma mark---设置右边的值
- (void)setRight:(CGFloat)right {
    CGRect newFrame = self.frame;
    newFrame.origin.x = right - newFrame.size.width;
    self.frame = newFrame;
}

#pragma mark---获取右边的值
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

#pragma mark---设置顶部
- (void)setTop:(CGFloat)top {
    CGRect newFrame = self.frame;
    newFrame.origin.y = top;
    self.frame = newFrame;
}

#pragma mark---获取顶部值
- (CGFloat)top {
    return self.frame.origin.y;
}

#pragma mark---设置底部坐标
- (void)setBottom:(CGFloat)bottom {
    CGRect newFrame = self.frame;
    newFrame.origin.y = bottom - newFrame.size.height;
    self.frame = newFrame;
}

#pragma mark---获取底部坐标
- (CGFloat)bottom {
    return self.frame.origin.y + self.height;
}

#pragma mark---设置宽度值
- (void)setWidth:(CGFloat)width {
    CGRect newFrame = self.frame;
    newFrame.size.width = width;
    self.frame = newFrame;
}

#pragma mark---获取宽度值
- (CGFloat)width {
    return self.frame.size.width;
}

#pragma mark---设置高度值
- (void)setHeight:(CGFloat)height {
    CGRect newFrame = self.frame;
    newFrame.size.height = height;
    self.frame = newFrame;
}

#pragma mark---获取高度值
- (CGFloat)height {
    return self.frame.size.height;
}

#pragma mark---设置中点横坐标
- (void)setCenterX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

#pragma mark---获取中点横坐标
- (CGFloat)centerX {
    return self.center.x;
}

#pragma mark---设置中点 y 坐标
- (void)setCenterY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

#pragma mark---获取中点纵坐标
- (CGFloat)centerY {
    return self.center.y;
}

#pragma mark---设置左上角坐标
- (void)setLeftTop:(CGPoint)leftTop {
    CGRect newFrame = self.frame;
    newFrame.origin = leftTop;
    self.frame = newFrame;
}

#pragma mark---获取左上角坐标
- (CGPoint)leftTop {
    return self.frame.origin;
}

#pragma mark---设置右上角坐标
- (void)setRightTop:(CGPoint)rightTop {
    CGRect newFrame = self.frame;
    newFrame.origin.y = rightTop.y;
    newFrame.origin.x = rightTop.x - newFrame.size.width;
    self.frame = newFrame;
}

#pragma mark---获取右上角坐标
- (CGPoint)rightTop {
    return CGPointMake(self.frame.origin.x + self.frame.size.width, self.frame.origin.y);
}

#pragma mark---设置左下角坐标
- (void)setLeftBottom:(CGPoint)leftBottom {
    CGRect newFrame = self.frame;
    newFrame.origin.y = leftBottom.y - newFrame.size.height;
    newFrame.origin.x = leftBottom.x;
    self.frame = newFrame;
}

#pragma mark---获取左下角坐标
- (CGPoint)leftBottom {
    return CGPointMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height);
}

#pragma mark---设置右下角坐标
- (void)setRightBottom:(CGPoint)rightBottom {
    CGRect newFrame = self.frame;
    newFrame.origin.y = rightBottom.y - newFrame.size.height;
    newFrame.origin.x = rightBottom.x - newFrame.size.width;
    self.frame = newFrame;
}

#pragma mark---设置款第和高度
- (void)setSize:(CGSize)size {
    
    CGRect newFrame = self.frame;
    newFrame.size = size;
    self.frame = newFrame;
}

#pragma mark---获取 size
- (CGSize)size {

    return self.frame.size;
}

#pragma mark---坐标缩放
#pragma mark---调整左边的值
- (void) scaleLeft:(CGFloat)left {
 
    // 如果左边比原右边还右, 则以平移为结果, 否则就是右边不变值调整左边
    if (left > self.right) {
        self.left = left;
    }
    else {
        self.width = self.right - left;
        self.left = left;
    }
}

#pragma mark---调整右边的值
- (void) scaleRight:(CGFloat)right {
    // 如果左边比原右边还右, 则以平移为结果, 否则就是右边不变值调整左边
    if (right < self.left) {
        self.right = right;
    }
    else {
        self.width = right - self.left;
    }
}

#pragma mark---调整上边的值
- (void)scaleTop:(CGFloat)top {
    if (top > self.bottom) {
        self.top = top;
    }
    else {
        self.height = self.bottom - top;
        self.top = top;
    }
}

#pragma mark---调整底部的值
- (void)scaleBottom:(CGFloat)bottom {
    if (bottom < self.top) {
        self.bottom = bottom;
    }
    else {
        self.height = bottom - self.top;
    }
}

#pragma mark--通用的调整方法
- (void) scaleValue:(id)value forKey:(NSString *)key {

    // 调整为方法
    NSString *string = [NSString stringWithFormat:@"scale%@:", [key capitalizedString]];
    
    // 获取方法
    SEL selector = NSSelectorFromString(string);
    
    // 调用方法
    if ([self respondsToSelector: selector]) {
        
        // 判断一下, 避免崩溃
        if ([value isKindOfClass: [NSNumber class]]) {
            objc_msgSend(self, selector, ((NSNumber *)value).floatValue);
        }
        else if ([value isKindOfClass: [NSValue class]]){
            
        }
    }
  
}

#pragma mark---调整边的值, 即上下左右
- (void)scaleEdgeValue:(CGFloat)value forKey:(NSString *)key {
    // 调整为方法
    NSString *string = [NSString stringWithFormat:@"scale%@:", [key capitalizedString]];
    
    // 获取方法
    SEL selector = NSSelectorFromString(string);
    
    // 调用方法
    if ([self respondsToSelector: selector]) {
        
        // 判断一下, 避免崩溃
        objc_msgSend(self, selector, value);
       
    }
}
@end
