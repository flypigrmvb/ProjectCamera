//
//  ImgNewsViewController.m
//  Project-Movie
//
//  Created by Minr on 14-11-14.
//  Copyright (c) 2014年 Minr. All rights reserved.
//

#import "ImgNewsViewController.h"
#import "ImgShowViewController.h"

@interface ImgNewsViewController ()

@end

@implementation ImgNewsViewController
{
    NSString *_identify;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"图片列表";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor =
        [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    
//    NSString *imgName =@"1.jpg" ;
//    
//    UIImage *imgg= [UIImage imageNamed:imgName];
    // 请求数据
    //[self _requestData:imgg];
    
    [self _init];
}

- (void)_init{
    
    //为当前UICollectionView对象创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(100, 150);
    flowLayout.minimumLineSpacing = 6;
    flowLayout.minimumInteritemSpacing = 6;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(3, 23, self.view.frame.size.width - 6, self.view.frame.size.height - 25) collectionViewLayout:flowLayout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor clearColor];
    
    //注册单元格
    _identify = @"PhotoCell";
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:_identify];
    
    [self.view addSubview:collectionView];
    [collectionView release];
}

//#pragma mark -请求数据
//- (void)_requestData{
//    
//    _data = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i < 12; i++) {
//        NSString *imgName = [NSString stringWithFormat:@"%d.jpg",i];
//        UIImage *img = [UIImage imageNamed:imgName];
//        [_data addObject:img];
//        [img release];
//    }
//    
//}


#pragma mark -请求数据
- (void)_requestData:(NSMutableArray *)imgData{
    
        _data = [[NSMutableArray alloc] init];
    
    _data=imgData;
    
    
}

#pragma mark -UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _data.count;
}

// 单元格代理
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_identify forIndexPath:indexPath];

    cell.backgroundColor = [UIColor redColor];

    UIImage *img = self.data[indexPath.row];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    imgView.contentMode = UIViewContentModeScaleToFill;
    
    imgView.frame = CGRectMake(0, 0, 100, 150);
    
    [cell.contentView addSubview:imgView];
    
    return cell;
}



// 单元格选择代理
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // 深拷贝数据
    NSMutableArray *imgList = [NSMutableArray arrayWithCapacity:_data.count];
    for (int i = 0; i < _data.count; i++) {
        UIImage *imgMod = _data[i];
        [imgList addObject:imgMod];
    }
    
    // 调用展示窗口
    ImgShowViewController *imgShow = [[ImgShowViewController alloc] initWithSourceData:imgList withIndex:indexPath.row];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:imgShow];
    
    [self presentViewController:[nav autorelease] animated:YES completion:nil];
    [imgShow release];
}

#pragma mark -View生命周期
- (void)viewWillAppear:(BOOL)animated{

    // 导航栏不透明
    if (self.navigationController.navigationBar.translucent) {
        self.navigationController.navigationBar.translucent = NO;
    }

    // 隐藏导航栏
    if (self.navigationController.navigationBarHidden) {
        self.navigationController.navigationBarHidden = NO;
    }

}


@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
