//
//  UIViewController+Frame.m
//  UICollectionViewFlowLayoutTest
//
//  Created by caiqiujun on 15/12/24.
//  Copyright © 2015年 caiqiujun. All rights reserved.
//

#import "UIViewController+Frame.h"

@implementation UIViewController (Frame)


-(CGFloat)screenWidth {
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    return size.width;
}

-(CGFloat)screenHeight {
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    return size.height;
}


@end
