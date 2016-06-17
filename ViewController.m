//
//  ViewController.m
//  LNBaseDemo
//
//  Created by 宗丽娜 on 16/6/15.
//  Copyright © 2016年 hi. All rights reserved.
//

#import "ViewController.h"
#import "Demo1.h"
#import "Demo2.h"
#import "Demo3.h"
#import "Demo4.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tabelView;
    NSArray * _titleArray;
    NSArray * _dataArray;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"LNDEMO";
    [self createUI];
    [self createData];
    
}

-(void)createData{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (!_titleArray) {
            _titleArray = @[@"Demo1***仿tableView方法轮播",@"Demo2***购物车逻辑功能实现",@"Demo3***富文本",@"Demo4***CABaseAnimation的简单使用"];
        }
        
        
        if(!_dataArray){
            _dataArray = @[@"Demo1",@"Demo2",@"Demo3",@"Demo4"];
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_tabelView reloadData];
            
        });
    });
    
}
-(void)createUI{
     _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
 
    [self.view addSubview:_tabelView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = _titleArray[indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //点击离开消失cell的选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
    [self.navigationController pushViewController:[[NSClassFromString(_dataArray[indexPath.row])alloc] init] animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
