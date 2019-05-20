//
//  MGSementChartCell.h
//  MGSegmentChartView
//
//  Created by maling on 2019/2/22.
//  Copyright © 2019 maling. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGSementChartCell : UICollectionViewCell

@property (nonatomic, strong) NSArray *tempValueArray;
- (void)setData:(NSMutableArray *)dataArray indexPath:(NSIndexPath *)indexPath;

- (void)hideLayer;
- (void)showLayer;

@end

NS_ASSUME_NONNULL_END
