//
// COPYRIGHT. HSBC HOLDINGS PLC 2016. ALL RIGHTS RESERVED.
//
// This software is only to be used for the purpose for which it has been
// provided. No part of it is to be reproduced, disassembled, transmitted,
// stored in a retrieval system nor translated in any human or computer
// language in any way or for any other purposes whatsoever without the
// prior written consent of HSBC Holdings plc.
//
//  UIView+FrameAdjust.m
//  Scan
//
//  Created by michelle on 15/10/15.
//

#import "UIView+FrameAdjust.h"

@implementation UIView (FrameAdjust)
#pragma mark -- 设置x,y,height,width
- (CGFloat)x {
    return CGRectGetMinX(self.frame);
}

- (CGFloat)y {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

#pragma mark -- 设置origin
- (CGPoint)origin {
    return CGPointMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame));
}

+ (CGRect)setOriginX:(CGRect)frame sendX:(CGFloat)x{
    CGRect myFrame = frame;
    myFrame.origin.x = x;
    return myFrame;
}
/**
 *  
 *
 *  @param x <#x description#>
 */
-  (void)setX:(CGFloat)x{
    self.frame = CGRectMake(x, self.y, self.width, self.height);
}


- (void)setY:(CGFloat)y{
    self.frame = CGRectMake(self.x, y, self.width, self.height);
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}


- (void)setOrigin:(CGPoint)origin {
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
}

#pragma mark -- 对齐
- (CGFloat)top {
    return CGRectGetMinY(self.frame);
}

- (CGFloat)bottom {
    return CGRectGetMinY(self.frame)+CGRectGetHeight(self.frame);
}

- (CGFloat)right {
    return CGRectGetMinX(self.frame)+CGRectGetWidth(self.frame);
}

- (CGFloat)left {
    return CGRectGetMinX(self.frame);
}



- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

@end
