//
//  MGSegmentChartView.m
//  MGSegmentChartView
//
//  Created by maling on 2019/2/22.
//  Copyright © 2019 maling. All rights reserved.
//

#import "MGSegmentChartView.h"

@interface MGSegmentChartView (){
    
    CGFloat MGChartView_width;
    CGFloat MGChartView_height;
}

@property (nonatomic, strong) CAShapeLayer *bottomLayer;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CAShapeLayer *lineLayer;

//@property (nonatomic, assign) NSInteger maxValue;
//@property (nonatomic, assign) NSInteger minValue;
@property (nonatomic, assign) CGFloat marginValue; // 误差值

@property (nonatomic, strong) NSMutableArray *yTempPointsArray;
@property (nonatomic, strong) NSMutableArray *yTempValueArray;
@property (nonatomic, strong) NSMutableArray *yControlPointsArray;  // 贝塞尔曲线控制点
@property (nonatomic, strong) NSMutableArray *yMiddlePointsArray;
@property (nonatomic, strong) NSMutableArray *yMMiddlePointsArray;

@property (nonatomic, strong) UILabel *templbl;
@property (nonatomic, strong) UIView *circleView;

@end
@implementation MGSegmentChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    
        [self initBottomLayer];
        [self drawBottomLineLayer];
        
        [self initDataSource];
        
    }
    return self;
}

- (void)initDataSource
{
    self.yTempValueArray = [[NSMutableArray alloc] init];
    _yTempPointsArray = [[NSMutableArray alloc] init];
    _yMiddlePointsArray = [[NSMutableArray alloc] init];
    _yMMiddlePointsArray = [[NSMutableArray alloc] init];
    _yControlPointsArray = [[NSMutableArray alloc] init];
    
    _maxValue = 35;
    _minValue = 10;
    _marginValue = 30;
}

- (void)initBottomLayer
{
    _bottomLayer = [CAShapeLayer layer];
    _bottomLayer.backgroundColor = [UIColor clearColor].CGColor;
    _bottomLayer.frame = CGRectMake(0, 0, self.width, self.height);
    [self.layer addSublayer:_bottomLayer];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.fillColor = [UIColor clearColor].CGColor;
    lineLayer.lineWidth =  2.0f;
    lineLayer.lineCap = kCALineCapRound;
    lineLayer.lineJoin = kCALineJoinRound;
    self.lineLayer = lineLayer;
    lineLayer.strokeColor = [UIColor redColor].CGColor;
    [_bottomLayer addSublayer:lineLayer];
}

- (void)drawBottomLineLayer
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.backgroundColor = [UIColor colorFromHexCode:@"BD855D"].CGColor;
    layer.frame = CGRectMake(0, self.height - 19 - 1, self.width, 1);
    [_bottomLayer addSublayer:layer];
    
    MGChartView_width = self.width;
    MGChartView_height = layer.frame.origin.y;
}

- (void)setTempValueArray:(NSArray *)tempValueArray
{
    if (tempValueArray.count == 5) {
    
        [self.yTempValueArray removeAllObjects];
        
        [self.yTempValueArray addObjectsFromArray:tempValueArray];
    }
    
//    NSLog(@"dataArray: %@", self.yTempValueArray);
}


- (void)drawRect:(CGRect)rect
{
    if (_maxValue == _minValue) {
        
        _marginValue = 10;
    }
    
    [self initData];
    [self drawCurveLine];
    [self setupCircleViews];
}

- (void)initData
{
    [self initTempPointArray];
}

- (void)initTempPointArray
{
    [_yTempPointsArray removeAllObjects];
    
    CGFloat tempValue = _maxValue - _minValue + _marginValue;
    
    
    for (int i = 0; i < _yTempValueArray.count; i++) {
        
        CGFloat marginX = MGChartView_width ;
        
        CGFloat XX = 0;
        if (i == 0) {XX = -marginX/2.0 - marginX;}
        else if (i == 1){XX = -marginX/2.0;}
        else if (i == 2){XX = marginX/2.0;}
        else if (i == 3){XX = marginX + marginX/2.0;}
        else if (i == 4){XX = marginX + marginX/2.0 + marginX;}
        
        CGFloat rate = [_yTempValueArray[i] floatValue] / tempValue;
        
        CGFloat YY = MGChartView_height * (1-rate) + _marginValue;
        
        CGPoint point = CGPointMake(XX, YY);
        
        NSLog(@">>>>>>>>point: %@", NSStringFromCGPoint(point));
        
        [_yTempPointsArray addObject:[NSValue valueWithCGPoint:point]];
    }
}

- (void)drawCurveLine
{
//    [_yTempPointsArray removeAllObjects];
//    [_yControlPointsArray removeAllObjects];
    
    [_bottomLayer removeFromSuperlayer];
    
    [self initBottomLayer];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.lineWidth =  2.0f;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
//    layer.strokeColor = [UIColor colorFromHexCode:@"00c1ed"].CGColor;
    
    layer.strokeColor = [UIColor redColor].CGColor;
    [_bottomLayer addSublayer:layer];
    
    self.lineLayer = layer;
    
    UIBezierPath *path = [UIBezierPath bezierPath];

    CGFloat tempValue = _maxValue - _minValue + _marginValue;
    
    
    for (int i = 0; i < _yTempPointsArray.count; i++) {
        
        CGPoint point = [_yTempPointsArray[i] CGPointValue];
        if (i == 0) {
            [path moveToPoint:point];
        }
        [path addLineToPoint:point];
    }
    
    
    self.layer.masksToBounds = YES;
    
    path = [path smoothedPathWithGranularity:20];
    
    layer.path = path.CGPath;
    
    [self drawGradient];
}

- (void)drawGradient
{
    [_gradientLayer removeAllAnimations];
    [_gradientLayer removeFromSuperlayer];

    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame = CGRectMake(0,0, self.width, MGChartView_height);

    _gradientLayer.colors =@[(__bridge id)[[UIColor colorFromHexCode:@"CBD7ED"] colorWithAlphaComponent:0.5].CGColor,
                             (__bridge id)[[UIColor colorFromHexCode:@"774A39"] colorWithAlphaComponent:0.5].CGColor,
                             (__bridge id)[[UIColor clearColor] colorWithAlphaComponent:1].CGColor];

//    _gradientLayer.colors =@[(__bridge id)[UIColor colorWithRed:46/255.0 green:200/255.0 blue:237/255.0 alpha:0.5].CGColor,
//                             (__bridge id)[UIColor colorWithRed:240/255.0 green:252/255.0 blue:254/255.0 alpha:0.4].CGColor];

    _gradientLayer.locations = @[@0.1, @0.3, @0.9];
    [_gradientLayer setStartPoint:CGPointMake(0, 0)];
    [_gradientLayer setEndPoint:CGPointMake(0, 1)];

    UIBezierPath *gradientPath = [[UIBezierPath alloc] init];

    CGPoint firstPoint = CGPointMake([[_yTempPointsArray firstObject] CGPointValue].x,MGChartView_height+25) ;

    CGPoint lastPoint =  [[_yTempPointsArray lastObject] CGPointValue];

    [gradientPath moveToPoint:firstPoint];

    for (int i = 0; i < _yTempPointsArray.count; i ++) {

        [gradientPath addLineToPoint:[_yTempPointsArray[i] CGPointValue]];
    }
    // 圆滑曲线
    gradientPath = [gradientPath smoothedPathWithGranularity:20];

    CGPoint endPoint = lastPoint;
    endPoint = CGPointMake(endPoint.x , self.width + 100);
    [gradientPath addLineToPoint:endPoint];

    CAShapeLayer *arc = [CAShapeLayer layer];
    arc.path = gradientPath.CGPath;
    _gradientLayer.mask = arc;

    [self.lineLayer addSublayer:_gradientLayer];

//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    animation.fromValue = @(0.3);
//    animation.toValue = @(1);
//    animation.autoreverses = NO;
//    animation.duration = 1.0;
//    [_gradientLayer addAnimation:animation forKey:nil];
}

- (void)setupCircleViews
{
    for (int i = 0; i < _yTempPointsArray.count; i ++)
    {
        CGPoint center = [_yTempPointsArray[i] CGPointValue];
        CGFloat radius = 2.0f;
        
        if (i == 2) {
        
            [self addSubview:self.circleView];
            self.circleView.frame = CGRectMake(center.x - radius,
                                               center.y - radius,
                                               radius * 2.0,
                                               radius * 2.0);
            
            [self addSubview:self.templbl];
            _templbl.centerX = _circleView.centerX;
            _templbl.centerY = _circleView.centerY - 20;
            _templbl.text = [NSString stringWithFormat:@"%ld", [_yTempValueArray[i] integerValue]];
        }
    }
}

- (UIView *)circleView
{
    if (!_circleView) {
        _circleView = [[UIView alloc] init];
        _circleView.backgroundColor = [UIColor blueColor];
        _circleView.layer.cornerRadius = 2;
        _circleView.layer.masksToBounds = YES;
    }
    return _circleView;
}

- (UILabel *)templbl
{
    if (!_templbl) {
        _templbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        _templbl.backgroundColor = [UIColor cyanColor];
    }
    return _templbl;
}

- (void)reloadData
{
    [self setNeedsDisplay];
    
//    if (_maxValue == _minValue) {
//
//        _marginValue = 10;
//    }
//
//    [self drawCurveLine];
//    [self setupCircleViews];
}

- (void)hideLayer
{
//    [_bottomLayer removeFromSuperlayer];
    _bottomLayer.hidden = YES;
}
- (void)showLayer
{
    _bottomLayer.hidden = NO;
}



@end
