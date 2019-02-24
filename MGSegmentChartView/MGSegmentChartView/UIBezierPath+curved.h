//
//  UIBezierPath+curved.h
//  MGSegmentChartView
//
//  Created by maling on 2019/2/22.
//  Copyright © 2019 maling. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (curved)

- (UIBezierPath*)smoothedPathWithGranularity:(NSInteger)granularity;

@end

NS_ASSUME_NONNULL_END
