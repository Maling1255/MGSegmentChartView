//
//  ViewController.m
//  MGSegmentChartView
//
//  Created by maling on 2019/2/22.
//  Copyright © 2019 maling. All rights reserved.
//

#import "ViewController.h"
#import "MGSegmentChartView.h"
#import "MGSementChartCell.h"


#define MGTemperatureReuseIdentifier @"MGTemperatureReuseIdentifier"
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *displayCollectionView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MGSegmentChartView *segmentView;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgImageView.image = [UIImage imageNamed:@"home_bg_orange"];
    [self.view addSubview:bgImageView];
    
    
    
    
    
    
    _dataArray = @[@"30", @"20", @"25", @"30", @"30", @"27", @"10", @"31", @"30", @"27", @"21", @"15", @"19"].mutableCopy;
    
    _dataArray = @[@"30.5", @"31.9", @"30.2", @"30.7", @"20.3", @"30.8", @"30.7", @"30.5", @"30.5", @"30.7", @"30.2", @"42", @"30.0", @"29.9"].mutableCopy;
    
    _dataArray = @[@"30.5", @"31.9", @"10.2", @"30.7", @"20.3", @"30.8", [NSNull null], @"30.5", @"30.5",@"60.3", @"30.7", @"30.2", @"42", @"30.0", @"29.9"].mutableCopy;
    
//    _dataArray = @[@"30.5", @"31.9", @"30.2", @"20.7", @"30.3"].mutableCopy;
//
//    _dataArray = @[@"10.5", @"5.9", @"8.2", @"0.7", @"-10.3", @"3"].mutableCopy;
//
//    _dataArray = @[@"19.5", @"19.7", @"20.1", @"20.7", @"19.8", @"21", @"20.6"].mutableCopy;
////
//    _dataArray = @[@"1.5", @"1.7", @"0.8", @"1.0", @"1.8", @"0.5", @"0.6"].mutableCopy;
////
    _dataArray = @[[NSNull null], @"1.5", @"1.7", @"0.8", @"1.0", @"1.8", @"0.5", @"0.6"].mutableCopy;
//
//    _dataArray = @[@"70.3", @"71.5", @"67.7", @"80.8", @"71.0", @"71.8", @"80.5", @"75.6"].mutableCopy;
//
//    _dataArray = @[@"80.3", @"91.5", @"87.7", @"98.8", @"91.0", @"81.8", @"80.5", @"75.6"].mutableCopy;
//
//    _dataArray = @[@"91.3", @"91.5", @"91.7", @"92.1", @"91.0", @"91.8", @"90.5", @"90.6"].mutableCopy;
//
//    _dataArray = @[@"80.3", @"91.5", @"87.7", @"98.8", @"91.0", @"81.8", @"80.5", @"75.6"].mutableCopy;
//
    
//    _dataArray = @[@"-80.3", @"-91.5", @"-87.7", @"-98.8", @"-91.0", @"-81.8", @"-80.5", @"-75.6"].mutableCopy;
//    _dataArray = @[@"30", @"20"].mutableCopy;

//    _dataArray = @[@"40"].mutableCopy;

//    _dataArray = @[[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],@"23", @"23"].mutableCopy;
    
//    _dataArray = @[[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],[NSNull null],@"39", @"39"].mutableCopy;
    
//    NSLog(@"_dataArray: %@", _dataArray);
    
    [self.view addSubview:self.displayCollectionView];
    
    

    
    
//    MGSegmentChartView *segmentView = [[MGSegmentChartView alloc] initWithFrame:CGRectMake(150, self.displayCollectionView.bottom, 100, 200)];
//    segmentView.backgroundColor = [UIColor lightGrayColor];
//
//    segmentView.tempValueArray = @[@"30", @"20", @"25", @"30", @"28"].mutableCopy;
    
    
//    [self.view addSubview:segmentView];
//
//    [segmentView reloadData];
    
//    self.segmentView = segmentView;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"点击...");
    
//    [self.segmentView hideLayer];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MGSementChartCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MGTemperatureReuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    
    [cell setData:_dataArray indexPath:indexPath];
    
    id object = _dataArray[indexPath.row];
    
    if ( [object isKindOfClass:[NSNull class]]) {
        
        [cell hideLayer];
    }
    else
    {
         [cell showLayer];
    }
    
    return cell;
}


- (UICollectionView *)displayCollectionView
{
    if (!_displayCollectionView) {
        
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        flowLayout.itemSize = CGSizeMake(80, 200);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _displayCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 200) collectionViewLayout:flowLayout];
        
        _displayCollectionView.dataSource = self;
        _displayCollectionView.delegate = self;
        _displayCollectionView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _displayCollectionView.showsHorizontalScrollIndicator = NO;
        [_displayCollectionView registerClass:[MGSementChartCell class] forCellWithReuseIdentifier:MGTemperatureReuseIdentifier];
    }
    return _displayCollectionView;
}




@end
