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
    
    _dataArray = @[@"30", @"20", @"25", @"30", @"30", @"27", @"30", @"31", @"30", @"27", @"21", @"15", @"19"].mutableCopy;
    
//    _dataArray = @[@"30", @"20"].mutableCopy;

//    _dataArray = @[@"40"].mutableCopy;

    
//    NSLog(@"_dataArray: %@", _dataArray);
    
    [self.view addSubview:self.displayCollectionView];
    
    

    
    
    MGSegmentChartView *segmentView = [[MGSegmentChartView alloc] initWithFrame:CGRectMake(150, self.displayCollectionView.bottom, 100, 200)];
    segmentView.backgroundColor = [UIColor lightGrayColor];
    
    segmentView.tempValueArray = @[@"30", @"20", @"25", @"30", @"28"].mutableCopy;
    
    
//    [self.view addSubview:segmentView];
//
//    [segmentView reloadData];
    
    self.segmentView = segmentView;
    
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
    
    cell.backgroundColor = [UIColor lightGrayColor];
    
    [cell setData:_dataArray indexPath:indexPath];
    
//    if (indexPath.row == 3)
//    {
//        [cell hideLayer];
//    }
//    else
//    {
//        [cell showLayer];
//    }
    
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
        
        _displayCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200) collectionViewLayout:flowLayout];
        
        _displayCollectionView.dataSource = self;
        _displayCollectionView.delegate = self;
        _displayCollectionView.backgroundColor = [UIColor whiteColor];
        _displayCollectionView.showsHorizontalScrollIndicator = NO;
        [_displayCollectionView registerClass:[MGSementChartCell class] forCellWithReuseIdentifier:MGTemperatureReuseIdentifier];
    }
    return _displayCollectionView;
}




@end
