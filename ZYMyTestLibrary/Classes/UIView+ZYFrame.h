//
//  UIView+ZYFrame.h
//  ZYTest
//
//  Created by 刘梓逸 on 16/7/14.
//  Copyright © 2016年 刘梓逸. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZYFrame)
@property (assign, nonatomic) CGFloat zy_x;
@property (assign, nonatomic) CGFloat zy_y;
@property (assign, nonatomic) CGFloat zy_w;
@property (assign, nonatomic) CGFloat zy_h;
@property (assign, nonatomic) CGSize zy_size;
@property (assign, nonatomic) CGPoint zy_origin;
@end
