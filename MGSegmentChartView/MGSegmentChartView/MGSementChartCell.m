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
    segmentView.backgroundColor = MGRandomColor;//[UIColor colorFromHexCode:@"999999"];
    self.segmentView = segmentView;
    [self addSubview:segmentView];
}

- (void)setTempValueArray:(NSArray *)tempValueArray
{
    self.segmentView.tempValueArray = @[@"27", @"30", @"29"].mutableCopy;
    
    [self.segmentView reloadData];
}
//[cell setData:_dataArray indexPath:indexPath];

- (void)setData:(NSArray *)dataArray indexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *tempArray = dataArray.mutableCopy;
    
    
    
    dataArray = tempArray.copy;
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
//        NSLog(@"HHHH %@", dataArray);
        
        
        NSLog(@"%@", [NSString stringWithFormat:@"30.0," @"30.1," @"30," @"20," @"25," @"30," @"30," @"27," @"30," @"31," @"30," @"27," @"28," @"26"]);
    });
    
    
    NSInteger index = indexPath.row;
    NSMutableArray *tempValueArray = [[NSMutableArray alloc] init];
    
    CGFloat maxValue = -100.0;
    CGFloat minValue = 200.0;

    
    for (NSString *valueString in dataArray) {
        
        if (valueString.floatValue > maxValue) {
            maxValue = valueString.floatValue;
        }
        if (valueString.floatValue < minValue) {
            minValue = valueString.floatValue;
        }
    }

        id temp1, temp2, temp3, temp4, temp5;
        if (index == 0 || index == 1)
        {
            
//            temp1 = [NSString stringWithFormat:@"%.1f",[dataArray[index] floatValue] + 0];;
//            temp2 = [NSString stringWithFormat:@"%.1f",[dataArray[index] floatValue] - 0];
            
            
            if (index == 0)
            {
//                temp1 = [NSString stringWithFormat:@"%.1f",[dataArray[index] floatValue] + 0];;
//                temp2 = [NSString stringWithFormat:@"%.1f",[dataArray[index] floatValue] - 0];
                
//                temp1 = @"30.0";
//                temp2 = @"30.1";
                
                temp1 = [NSString stringWithFormat:@"%.1f",[dataArray[0] floatValue] + 0.5];
                temp2 = [NSString stringWithFormat:@"%.1f",[dataArray[0] floatValue] - 0.5];
            }
            else if (index == 1)
            {
//                temp1 = [NSString stringWithFormat:@"%.1f",[dataArray[index] floatValue] + 0];;
//                temp2 = [NSString stringWithFormat:@"%.1f",[dataArray[index] floatValue] - 0];
                
//                temp1 = @"30.1";
//                temp2 = @"30";
                
                temp1 = [NSString stringWithFormat:@"%.1f",[dataArray[0] floatValue] - 0.5];
                temp2 = [NSString stringWithFormat:@"%.1f",[dataArray[0] floatValue]];
            }
            
            temp3 = dataArray[index];
            temp4 = dataArray[index+1];
            temp5 = dataArray[index+2];
        }
        else if (index == dataArray.count - 1 || index == dataArray.count - 2)
        {
            temp1 = dataArray[index-2];
            temp2 = dataArray[index-1];
            temp3 = dataArray[index];
            
            if (index == dataArray.count - 2) {
//                temp4 = @"27";
//                temp5 = @"28";
                
                temp4 = dataArray[dataArray.count - 1];
                temp5 = [NSString stringWithFormat:@"%.1f",[dataArray[dataArray.count - 1] floatValue] + 0.5];
                
                NSLog(@"倒数第二个 %@", dataArray[dataArray.count - 1]);
                NSLog(@"倒数第一个 %@", @"28");
                
            }
            else if (index == dataArray.count - 1)
            {
                temp4 = [NSString stringWithFormat:@"%.1f",[dataArray[dataArray.count - 1] floatValue] + 0.5];
                temp5 = [NSString stringWithFormat:@"%.1f",[dataArray[dataArray.count - 1] floatValue] - 0.5];
//                temp4 = @"28";
//                temp5 = @"26";
            }
            
//            temp4 = [NSString stringWithFormat:@"%.1f",[dataArray[index] floatValue] + 0];
//            temp5 = [NSString stringWithFormat:@"%.1f",[dataArray[index] floatValue] - 0];
        }
        else
        {
            temp1 = dataArray[index-2];
            temp2 = dataArray[index-1];
            temp3 = dataArray[index];
            temp4 = dataArray[index+1];
            temp5 = dataArray[index+2];
    
        }
    
    
        [tempValueArray addObject:temp1];
        [tempValueArray addObject:temp2];
        [tempValueArray addObject:temp3];
        [tempValueArray addObject:temp4];
        [tempValueArray addObject:temp5];

    
    NSLog(@"index.row %ld max:%f  min:%f %@   ", indexPath.row, maxValue, minValue, tempValueArray);
    
    self.segmentView.tempValueArray = tempValueArray;
    self.segmentView.maxValue = maxValue;
    self.segmentView.minValue = minValue;
    
    
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
        if ([object isEqualToString:@""])
        {
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
}
- (void)showLayer
{
    self.segmentView.hidden = NO;
}

@end



//    id temp1, temp2, temp3, temp4;
//    if (index == 0)
//    {
//        temp1 = dataArray[index];
//        temp2 = dataArray[index];
//
//        if (dataArray.count == 1) { temp3 = dataArray[index];}
//        else {temp3 = dataArray[index+1];}
//
//        temp4 = dataArray[index+2];
//    }
//    else if (index == dataArray.count - 1)
//    {
//        temp1 = dataArray[index-1];
//        temp2 = dataArray[index];
//        temp3 = dataArray[index];
//        temp4 = dataArray[index];
//    }
//    else
//    {
//        temp1 = dataArray[index-1];
//        temp2 = dataArray[index];
//        temp3 = dataArray[index+1];
//
//        if (index+2 > dataArray.count - 1) {
//            temp4 = dataArray[dataArray.count - 1];
//        }
//        else
//        {
//            temp4 = dataArray[index+2];
//        }
//
//    }
//
//
//    [tempValueArray addObject:temp1];
//    [tempValueArray addObject:temp2];
//    [tempValueArray addObject:temp3];
//
//    [tempValueArray addObject:temp4];
