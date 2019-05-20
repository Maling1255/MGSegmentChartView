//
//  MGSementChartCell.m
//  MGSegmentChartView
//
//  Created by maling on 2019/2/22.
//  Copyright © 2019 maling. All rights reserved.
//

#import "MGSementChartCell.h"
#import "MGSegmentChartView.h"


@interface MGSementChartCell ()

@property (nonatomic, copy) NSString *keepTempValue;
@property (nonatomic, strong) MGSegmentChartView *segmentView;

@end
@implementation MGSementChartCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    MGSegmentChartView *segmentView = [[MGSegmentChartView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    segmentView.backgroundColor = [UIColor clearColor];
    self.segmentView = segmentView;
    [self addSubview:segmentView];
}

- (void)setTempValueArray:(NSArray *)tempValueArray
{
    self.segmentView.tempValueArray = @[@"27", @"30", @"29"].mutableCopy;
    
    [self.segmentView reloadData];
}
//[cell setData:_dataArray indexPath:indexPath];

- (void)setData:(NSMutableArray *)dataArray indexPath:(NSIndexPath *)indexPath
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //        NSLog(@"HHHH %@", dataArray);
        
        NSString *dataString = @"";
        for (NSString *tempString in dataArray) {
            
            dataString = [dataString stringByAppendingString:[NSString stringWithFormat:@"%@,", tempString]];
        }
        
        NSLog(@"\n\n  %@ \n\n..", dataString);
        
        //        NSLog(@"%@", [NSString stringWithFormat:@"30," @"20," @"25," @"30," @"30," @"27," @"30," @"31," @"30,"@"27," @"21," @"15," @"19"]);
    });
    
    
    NSInteger index = indexPath.row;
    NSMutableArray *tempValueArray = [[NSMutableArray alloc] init];
    
    
    CGFloat maxValue = -100.0;
    CGFloat minValue = 200.0;
    
    NSMutableArray *tempDataArray0 = [[NSMutableArray alloc] initWithArray:dataArray];
    
    // 对空数据处理
    for (id obj in tempDataArray0.mutableCopy) {
        
        if ([self isNullObject:obj]) {
            
            if (_keepTempValue.length > 0) {
                
                [tempDataArray0 replaceObjectAtIndex:[tempDataArray0 indexOfObject:obj] withObject:_keepTempValue];
            }
            else
            {
                // MARK: 暂时的数据，如果前面都是空的数据，写入一个固定的数据
                [tempDataArray0 replaceObjectAtIndex:[tempDataArray0 indexOfObject:obj] withObject:@"20.3"];
            }
        }
        else if ([obj isKindOfClass:[NSString class]])
        {
            NSString * valueString = (NSString *)obj;
            
            _keepTempValue = [NSString stringWithFormat:@"%.1f", [valueString floatValue] + 1.7];
            
            if (valueString.floatValue > maxValue) {
                maxValue = valueString.floatValue;
            }
            if (valueString.floatValue < minValue) {
                minValue = valueString.floatValue;
            }
        }
    }
    
    NSLog(@"tempDataArray0:: %@", tempDataArray0);
    NSMutableArray *tempDataArray = [[NSMutableArray alloc] initWithArray:tempDataArray0];
    
    for (id obj in tempDataArray.mutableCopy) {

        if ([obj isEqualToString:@"20.3"]) {

            [tempDataArray replaceObjectAtIndex:[tempDataArray indexOfObject:obj] withObject:_keepTempValue];
        }
    }
  
    NSLog(@"tempDataArray:: %@", tempDataArray);
    
    
    
    
    id temp1, temp2, temp3, temp4, temp5;
    if (index == 0 || index == 1)
    {
        
        if (index == 0)
        {
            
            temp1 = [NSString stringWithFormat:@"%.1f",[tempDataArray[0] floatValue] + 0.5];
            temp2 = [NSString stringWithFormat:@"%.1f",[tempDataArray[0] floatValue] - 0.5];
        }
        else if (index == 1)
        {
            temp1 = [NSString stringWithFormat:@"%.1f",[tempDataArray[0] floatValue] - 0.5];
            temp2 = [NSString stringWithFormat:@"%.1f",[tempDataArray[0] floatValue]];
        }
        
        temp3 = tempDataArray[index];
        temp4 = tempDataArray[index+1];
        temp5 = tempDataArray[index+2];
    }
    else if (index == tempDataArray.count - 1 || index == tempDataArray.count - 2)
    {
        temp1 = tempDataArray[index-2];
        temp2 = tempDataArray[index-1];
        temp3 = tempDataArray[index];
        
        if (index == tempDataArray.count - 2) {
            
            temp4 = tempDataArray[tempDataArray.count - 1];
            temp5 = [NSString stringWithFormat:@"%.1f",[tempDataArray[tempDataArray.count - 1] floatValue] + 0.5];
            
        }
        else if (index == tempDataArray.count - 1)
        {
            temp4 = [NSString stringWithFormat:@"%.1f",[tempDataArray[tempDataArray.count - 1] floatValue] + 0.5];
            temp5 = [NSString stringWithFormat:@"%.1f",[tempDataArray[tempDataArray.count - 1] floatValue] - 0.5];
        }
    }
    else
    {
        temp1 = tempDataArray[index-2];
        temp2 = tempDataArray[index-1];
        temp3 = tempDataArray[index];
        temp4 = tempDataArray[index+1];
        temp5 = tempDataArray[index+2];
    }
    
    [tempValueArray addObject:temp1];
    [tempValueArray addObject:temp2];
    [tempValueArray addObject:temp3];
    [tempValueArray addObject:temp4];
    [tempValueArray addObject:temp5];
    
    
    //    NSLog(@"index.row %ld max:%f  min:%f %@   ", indexPath.row, maxValue, minValue, tempValueArray);
    
    self.segmentView.tempValueArray = tempValueArray;
    self.segmentView.maxValue = maxValue;
    self.segmentView.minValue = minValue;
    self.segmentView.marginValue = maxValue + 10;
    
    
    [self.segmentView reloadData];
}

- (BOOL)isNullObject:(id)object
{
    if (object == nil || [object isEqual:[NSNull class]])
    {
        return YES;
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
      return YES;
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        if ([object length] == 0) {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    
    return NO;
}



- (void)hideLayer
{
    self.segmentView.hidden = YES;
    
//    [self.segmentView hideLayer];
    
}
- (void)showLayer
{
    self.segmentView.hidden = NO;
    
//    [self.segmentView showLayer];
}

@end
