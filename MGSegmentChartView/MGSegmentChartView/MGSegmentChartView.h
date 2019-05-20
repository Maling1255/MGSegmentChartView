//
//  MGSegmentChartView.h
//  MGSegmentChartView
//
//  Created by maling on 2019/2/22.
//  Copyright © 2019 maling. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGSegmentChartView : UIView

@property (nonatomic, strong) NSArray *tempValueArray;
@property (nonatomic, assign) CGFloat maxValue;
@property (nonatomic, assign) CGFloat minValue;
@property (nonatomic, assign) CGFloat marginValue; // 误差值

- (void)reloadData;
- (void)hideLayer;
- (void)showLayer;

@end

NS_ASSUME_NONNULL_END
