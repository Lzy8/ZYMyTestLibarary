//
//  UIView+ZYFrame.m
//  ZYTest
//
//  Created by 刘梓逸 on 16/7/14.
//  Copyright © 2016年 刘梓逸. All rights reserved.
//

#import "UIView+ZYFrame.h"

@implementation UIView (ZYFrame)
- (void)setZy_x:(CGFloat)zy_x
{
    CGRect frame = self.frame;
    frame.origin.x = zy_x;
    self.frame = frame;
}

- (CGFloat)zy_x
{
    return self.frame.origin.x;
}

- (void)setZy_y:(CGFloat)zy_y
{
    CGRect frame = self.frame;
    frame.origin.y = zy_y;
    self.frame = frame;
}

- (CGFloat)zy_y
{
    return self.frame.origin.y;
}

- (void)setZy_w:(CGFloat)zy_w
{
    CGRect frame = self.frame;
    frame.size.width = zy_w;
    self.frame = frame;
}

- (CGFloat)zy_w
{
    return self.frame.size.width;
}

- (void)setZy_h:(CGFloat)zy_h
{
    CGRect frame = self.frame;
    frame.size.height = zy_h;
    self.frame = frame;
}

- (CGFloat)zy_h
{
    return self.frame.size.height;
}

- (void)setZy_size:(CGSize)zy_size
{
    CGRect frame = self.frame;
    frame.size = zy_size;
    self.frame = frame;
}

- (CGSize)zy_size
{
    return self.frame.size;
}

- (void)setZy_origin:(CGPoint)zy_origin
{
    CGRect frame = self.frame;
    frame.origin = zy_origin;
    self.frame = frame;
}

- (CGPoint)zy_origin
{
    return self.frame.origin;
}

@end
