//
//  ZYCarouselView.h
//  ZYTest
//
//  Created by 刘梓逸 on 16/7/14.
//  Copyright © 2016年 刘梓逸. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ZYCallBackHandler)(NSInteger index);

@interface ZYCarouselView : UIView

@property (nonatomic,strong) NSArray<UIImage *> *images;

+(instancetype)zy_CarouselViewWithFrame:(CGRect)frame
                                 images:(NSArray<UIImage *> *)images
                            isFireTimer:(BOOL)isFire
                       imageClickAction:(ZYCallBackHandler)action;

-(void)zy_configFromNibWithImages:(NSArray<UIImage *> *)images
                      isFireTimer:(BOOL)isFire
                 imageClickAction:(ZYCallBackHandler)action;
@end
