//
//  Demo1.m
//  LNBaseDemo
//
//  Created by 宗丽娜 on 16/6/16.
//  Copyright © 2016年 hi. All rights reserved.
//

#import "Demo1.h"
#import "ImagesScrollView.h"
@interface Demo1 ()<ImagesScrollViewDelegate>
{
    NSMutableArray * _images;
    NSMutableArray * _imageUrls;
}
@property (strong, nonatomic)  ImagesScrollView *imagesScrollView;
@property (strong, nonatomic) ImagesScrollView *imagesScrollViewfromUrl;
@end

@implementation Demo1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _images = [NSMutableArray array];
    _imageUrls = [NSMutableArray array];
    for (NSInteger i = 0; i < 12; i++) {
        // 准备本地数据源
        NSString * imgName = [NSString stringWithFormat:@"background_0%02ld", i];
        NSString * imgPath = [[NSBundle mainBundle] pathForResource:imgName ofType:@"jpg"];
        UIImage * img = [UIImage imageWithContentsOfFile:imgPath];
        [_images addObject:img];
        
        // 准备远程数据源
        NSString * imgUrl = [NSString stringWithFormat:@"http://swkits.com/Images/background_0%02ld.jpg", i];
        [_imageUrls addObject:imgUrl];
    }
    
    [self.imagesScrollView reloadData];
    self.imagesScrollView = [[ImagesScrollView alloc] initWithFrame:CGRectMake(10, 100, 320, 200)];
    self.imagesScrollView.isLoop = YES;
    self.imagesScrollView.delegate = self;
    [self.imagesScrollView setImageViewContentMode:UIViewContentModeScaleAspectFill];
    self.imagesScrollView.autoScrollInterval = 2;
    [self.view addSubview:self.imagesScrollView];
    
    self.imagesScrollViewfromUrl = [[ImagesScrollView alloc] initWithFrame:CGRectMake(0, 300, 320, 200)];
    [self.view addSubview:self.imagesScrollViewfromUrl];
    self.imagesScrollViewfromUrl.delegate = self;
    self.imagesScrollViewfromUrl.autoScrollInterval = 2;

}
- (NSInteger)numberOfImagesInImagesScrollView:(ImagesScrollView *)imagesScrollView
{
    if (self.imagesScrollView == imagesScrollView) {
        return _images.count;
    } else {
        return _imageUrls.count;
    }
}

- (UIImage *)imagesScrollView:(ImagesScrollView *)imagesScrollView imageWithIndex:(NSInteger)index
{
    if (self.imagesScrollView == imagesScrollView) {
        return _images[index];
    } else {
        return nil;
    }
}

- (NSString *)imagesScrollView:(ImagesScrollView *)imagesScrollView imageUrlStringWithIndex:(NSInteger)index
{
    if (self.imagesScrollViewfromUrl == imagesScrollView) {
        return _imageUrls[index];
    } else {
        return nil;
    }
}

- (void)imagesScrollView:(ImagesScrollView *)imagesScrollView didSelectIndex:(NSInteger)index
{
    NSLog(@"tap:%@ at:%ld", imagesScrollView, index);
}

- (void)imagesScrollView:(ImagesScrollView *)imagesScrollView didScrollToIndex:(NSInteger)index
{
    NSLog(@"%@ scrollToIndex:%ld",imagesScrollView , index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
