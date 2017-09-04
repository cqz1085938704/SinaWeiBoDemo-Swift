//
// COPYRIGHT. HSBC HOLDINGS PLC 2016. ALL RIGHTS RESERVED.
//
// This software is only to be used for the purpose for which it has been
// provided. No part of it is to be reproduced, disassembled, transmitted,
// stored in a retrieval system nor translated in any human or computer
// language in any way or for any other purposes whatsoever without the
// prior written consent of HSBC Holdings plc.
//
//  UIView+FrameAdjust.h
//  utils
//
//  Created by michelle on 15/10/15.
//

#import <UIKit/UIKit.h>
#define WIN_BOUNDS [UIScreen mainScreen].bounds
#define WIN_SIZE [UIScreen mainScreen].bounds.size
#define WIN_WIDTH [UIScreen  mainScreen].bounds.size.width
#define WIN_HEIGHT [UIScreen mainScreen].bounds.size.height


//get device type by screen height
#define IS_IPHONE_4_ ([UIScreen mainScreen].bounds.size.height == 480.0f)
#define IS_IPHONE_5_ ([UIScreen mainScreen].bounds.size.height == 568.0f)
#define IS_IPHONE_6 ([UIScreen mainScreen].bounds.size.height == 667.0f)
#define IS_IPHONE_6_PLUS ([UIScreen mainScreen].bounds.size.height == 736.0f)


@interface UIView (FrameAdjust)

#pragma mark -- 设置centerX,centerY
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

#pragma mark -- 设置x
- (CGFloat)x;
- (void)setX:(CGFloat)x;


#pragma mark -- 设置y
- (CGFloat)y;
- (void)setY:(CGFloat)y;

#pragma mark -- 设置height
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

#pragma mark -- 设置width
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

#pragma mark -- 设置origin
- (CGPoint)origin;
- (void)setOrigin:(CGPoint)origin;

#pragma mark -- 对齐
- (CGFloat)top;

- (CGFloat)bottom;

- (CGFloat)right;

- (CGFloat)left;


@end
