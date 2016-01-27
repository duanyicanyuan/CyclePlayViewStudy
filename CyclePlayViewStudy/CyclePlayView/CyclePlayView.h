//
//  CyclePlayView.h
//  CyclePlayViewStudy
//
//  Created by caiqiujun on 16/1/27.
//  Copyright © 2016年 caiqiujun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CyclePlayView : UIView
/**高亮颜色*/
@property(nonatomic, retain)UIColor *currentTintColor;
/**默认颜色*/
@property(nonatomic, retain)UIColor *tintColor;
/**轮滑的时间间隔(>0)*/
@property(nonatomic, assign)NSTimeInterval timeInterval;

- (void)setImages:(NSArray *)images placeholderImages:(NSArray *)placeholderImages;
@end
