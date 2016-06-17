//
//  Demo2.m
//  LNBaseDemo
//
//  Created by 宗丽娜 on 16/6/16.
//  Copyright © 2016年 hi. All rights reserved.
//

#import "Demo2.h"
#import "CarCell.h"
#import "carModel.h"
#import "CarEditCell.h"
#import "FootAccountView.h"
#import "LNButton.h"
#import "UIBarButtonItem+GSBarButtonItem.h"
#import "Masonry.h"
@interface Demo2 ()<UITableViewDelegate,UITableViewDataSource>
{
NSMutableArray * _dataArray;//展示数据源
UITableView * _tabelView;
UIButton * _selectAllBtn;//全选按钮
NSMutableArray * _selectGoods;//已选的商品信息
UIView * _accontView;
LNButton * _loginBtn;
}
@property(nonatomic,strong)UIButton *editBtn;//编辑按钮
@end

@implementation Demo2
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
        
        for (UIView * suView in self.view.subviews) {
            [suView removeFromSuperview];
        }
        _editBtn.selected = NO;
        _editBtn.userInteractionEnabled = YES;
        if (_dataArray.count>0) {
            [_dataArray removeAllObjects];
        }
        
        [self createData];
        _selectGoods = [NSMutableArray arrayWithArray:_dataArray];
        if (_dataArray.count>0) {
            _selectAllBtn.selected = YES;
        }else{
            _selectAllBtn.selected = NO;
        }
        [self createUI];
        [self countPrice];


}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"购物车";
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self createData];
    _editBtn.selected = NO;

    _selectAllBtn.selected = YES;
    [self createItems];
    [self createUI];
        
  
        
   

    
}
#pragma mark - 未登录的时候显示
-(void)createLogin{
    
    //默认视图背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundView.tag = 100;
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    //默认图片
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"noLogin"]];
    img.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0 - 120);
    img.bounds = CGRectMake(0, 0, 247.0/187 * 100, 100);
    [backgroundView addSubview:img];
    _loginBtn = [LNButton buttonWithFrame:CGRectMake((self.view.frame.size.width-100)/2.0, self.view.frame.size.height/2.0 + 10, 100, 40) Type:UIButtonTypeSystem Title:@"请先登录" Font:17.0 Target:self AndAction:@selector(toLogin)];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    _loginBtn.backgroundColor = [UIColor redColor];
    _loginBtn.layer.cornerRadius = 10;
    _loginBtn.clipsToBounds = YES;
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_loginBtn];
    
}

-(void)toLogin{
//    LoginViewController * myLogin =[[LoginViewController alloc] init];
//    myLogin.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:myLogin animated:YES];
    
}
-(void)createItems{
    
    _editBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_editBtn setTitle:@"编辑"  forState:UIControlStateNormal];
    [_editBtn setTitle:@"完成" forState:UIControlStateSelected];
    _editBtn.frame = CGRectMake(0, 0, 20, 20);
    _editBtn.tag = 200;
    _editBtn.showsTouchWhenHighlighted = NO;
    
    [_editBtn addTarget:self action:@selector(toEdit:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *idit = [[UIBarButtonItem alloc] initWithCustomView:_editBtn];
    //    UIBarButtonItem * popItem = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage imageNamed:@"分类"] highlightedImage:nil target:self action:@selector(toPop:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = idit;
}


-(void)createAccountBar{
    
    __weak typeof (self) weakSelf = self;
    _accontView = [[UIView alloc] init];
    _accontView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_accontView];
    [_accontView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(weakSelf.view.mas_width);
        make.bottom.mas_equalTo(weakSelf.view.mas_bottom);
        make.height.mas_equalTo(@40);
    }];
    
    _selectAllBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
    [_selectAllBtn setBackgroundImage:[UIImage imageNamed:@"gouxuankuang"] forState:UIControlStateNormal];
    [_selectAllBtn setBackgroundImage:[UIImage imageNamed:@"xuanzhong"] forState:UIControlStateSelected];
    [_selectAllBtn addTarget:self action:@selector(toSelectAll:) forControlEvents:UIControlEventTouchUpInside];
    
    if (_selectGoods.count == _dataArray.count) {
        _selectAllBtn.selected = YES;
    }else{
        _selectAllBtn.selected = NO;
    }
    [_accontView addSubview:_selectAllBtn];
    [_selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_accontView.mas_top).offset(10);
        make.left.equalTo(_accontView.mas_left).offset(10);
        make.width.equalTo(@16);
        make.height.equalTo(@16);
    }];
    
    UILabel * allLable = [[UILabel alloc] init];
    allLable.text = @"全选";
    allLable.textColor = [UIColor colorWithRed:187/255.0 green:187/255.0 blue:187/255.0 alpha:1.0];
    allLable.font = [UIFont systemFontOfSize:15];
    [_accontView addSubview:allLable];
    [allLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_accontView.mas_top).offset(10);
        make.left.equalTo(_selectAllBtn.mas_right).offset(5);
        make.width.equalTo(@40);
        make.height.equalTo(@15);
    }];
    
    
    UIButton * buyButton = [[UIButton alloc] init];
    buyButton.backgroundColor = [UIColor colorWithRed:231/255.0 green:55/255.0 blue:54/255.0 alpha:1.0];
    
    if (_editBtn.selected==NO) {
        
        [buyButton setTitle:@"去结算" forState:UIControlStateNormal];
        
    }else{
        
        [buyButton setTitle:@"批量删除" forState:UIControlStateNormal];
        
    }
    
    [buyButton addTarget:self action:@selector(toSettingAccont:) forControlEvents:UIControlEventTouchUpInside];
    [_accontView addSubview:buyButton];
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_accontView.mas_top);
        make.right.equalTo(_accontView.mas_right);
        make.bottom.equalTo(_accontView.mas_bottom);
        make.width.equalTo(@93);
        
    }];
    
    UILabel * pricelabel = [[UILabel alloc] init];
    pricelabel.tag = 3;
    pricelabel.textAlignment = NSTextAlignmentRight;
    pricelabel.textColor = [UIColor colorWithRed:231/255.0 green:55/255.0 blue:54/255.0 alpha:1.0];
    pricelabel.font = [UIFont systemFontOfSize:15];
    [_accontView addSubview:pricelabel];
    [pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(buyButton.mas_left).offset(-5);
        make.top.equalTo(_accontView.mas_top).offset(10);
        make.height.equalTo(@10);
        make.left.equalTo(allLable.mas_right).offset(10);
    }];
    
    UILabel *freightLabel = [[UILabel alloc] init];
    freightLabel.tag = 4;
    freightLabel.textAlignment = NSTextAlignmentRight;
    freightLabel.textColor = [UIColor colorWithRed:159/255.0 green:159/255.0 blue:159/255.0 alpha:1.0];
    freightLabel.font = [UIFont systemFontOfSize:15];
    [_accontView addSubview:freightLabel];
    [freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(buyButton.mas_left).offset(-5);
        make.top.equalTo(pricelabel.mas_bottom).offset(5);
        make.left.equalTo(allLable.mas_right).offset(10);
        make.height.equalTo(pricelabel);
    }];
    
    
    [self countPrice];
    
}



-(void)toSelectAll:(UIButton *)button{
    button.selected = !button.selected;
    [_selectGoods removeAllObjects];
    if (button.selected) {
        for (carModel * model in _dataArray) {
            
            model.isSelect = YES;
            [_selectGoods addObject:model];
        }
    }else{
        
        for (carModel * model in _dataArray) {
            
            model.isSelect = NO;
            
        }
        
        [_selectGoods removeAllObjects];
    }
    
    if (_editBtn.selected ==YES) {
        
        [_tabelView reloadData];
        
    }else{
        
        [_tabelView reloadData];
        
    }
    
    
    [self countPrice];
}
-(void)createData{
 
    for (NSInteger i = 0; i < 10; i++) {
        carModel * model = [[carModel alloc] init];
        model.goods_thumb = @"background_007";
        model.goods_id = @"111";
        model.goods_name = @"一件美哒哒的衣服";
        model.goods_price = @"100.00";
        model.goods_number = @"2";
        model.shipping_price = @"10";
        
        [_dataArray addObject:model];
        
    }
    
    
    
}

#pragma mark -结算button的实现
-(void)toSettingAccont:(UIButton *)button{
    NSString * str = button.currentTitle;
    
    //判断是否用商品，有商品才能结算，没有商品提示
    if(_selectGoods.count> 0){
        if ([str isEqualToString:@"去结算"] ) {
            NSLog(@"调到结算页面");

        }else if([str isEqualToString:@"批量删除"]){

                    }
                    
                    [_selectGoods removeAllObjects];
                    [_dataArray removeAllObjects];
                    [_tabelView reloadData];
                    _selectAllBtn.selected = NO;
                    if (_dataArray.count > 0) {
                        [self countPrice];
                    }else{
                        _editBtn.selected = NO;
                        _editBtn.userInteractionEnabled = NO;
                        _accontView.hidden = YES;
                        [self cartEmptyShow];
                    }
                    
                }else if (_selectGoods.count > 0){
                    for (carModel * model  in _selectGoods) {
                        
    
                        
                        [_dataArray removeObject:model];
                        
                        [_tabelView reloadData];
                        
                    }
                    //删除选中商品中的数据
                    for (carModel * model in _dataArray) {
                        if (![_selectGoods containsObject:model]) {
                            
                            [_selectGoods removeObject:model];
                        }
                    }
                    [self countPrice];
                    
                }
    
            
            
}



-(void)createUI{
    
    _tabelView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height ) style:UITableViewStylePlain];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
    _tabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tabelView.estimatedRowHeight = 68.0;  _tabelView.rowHeight = UITableViewAutomaticDimension;
    [_tabelView registerNib:[UINib nibWithNibName:@"CarEditCell" bundle:nil] forCellReuseIdentifier:@"edit"];
    
    [_tabelView registerNib:[UINib nibWithNibName:@"CarCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    [self.view addSubview:_tabelView];
    
    
}


//购物车为空时的默认视图
-(void)cartEmptyShow
{
    if (_accontView!=nil) {
        _accontView.hidden = YES;
    }
    //默认视图背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    backgroundView.tag = 100;
    backgroundView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backgroundView];
    
    //默认图片
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"noLogin"]];
    img.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0 - 120);
    img.bounds = CGRectMake(0, 0, 247.0/187 * 100, 100);
    [backgroundView addSubview:img];
    
    UILabel *warnLabel = [[UILabel alloc]init];
    warnLabel.center = CGPointMake(self.view.frame.size.width/2.0,self.view.frame.size.height/2.0 - 10);
    warnLabel.bounds = CGRectMake(0, 0, self.view.frame.size.width, 30);
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.text = @"购物车好空,买点什么呗!";
    warnLabel.font = [UIFont systemFontOfSize:17];
    warnLabel.textColor = [UIColor redColor];
    [backgroundView addSubview:warnLabel];
    
    //默认视图按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0 + 40);
    btn.bounds = CGRectMake(0, 0,  110, 40);
    btn.layer.cornerRadius = 10;
    btn.clipsToBounds = YES;
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setTintColor:[UIColor whiteColor]];
    [btn setTitle:@"去购买" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [btn addTarget:self action:@selector(goToMainmenuView) forControlEvents:UIControlEventTouchUpInside];
    [backgroundView addSubview:btn];
    
}
-(void)goToMainmenuView
{
    self.tabBarController.selectedIndex = 0;
}

-(NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    carModel * model = _dataArray[indexPath.row];
    
    //判断是否在编辑状态
    if (_editBtn.selected == YES) {
        
        CarEditCell * cell = [tableView dequeueReusableCellWithIdentifier:@"edit" forIndexPath:indexPath];
        cell.model = model;
        
        //判断cell中的商品是否是选择商品
        if ([_selectGoods containsObject:[_dataArray objectAtIndex:indexPath.row]]) {
            
            model.isSelect = YES;
            cell.delectBtn.userInteractionEnabled = YES;
            
        }else{
            model.isSelect = NO;
            cell.delectBtn.userInteractionEnabled = NO;
        }
        
        //加减方法
        __block CarEditCell * weakCell = cell;
        
        weakCell.carBlock = ^(BOOL isSelec){
            if (isSelec) {
                cell.delectBtn.userInteractionEnabled = YES;
                
                model.isSelect = YES;
                [_selectGoods addObject:[_dataArray objectAtIndex:indexPath.row]];
            }else{
                
                cell.delectBtn.userInteractionEnabled = NO;
                model.isSelect = NO;
                [_selectGoods removeObject:[_dataArray objectAtIndex:indexPath.row]];
            }
            
            if (_selectGoods.count == _dataArray.count) {
                
                _selectAllBtn.selected = YES;
            }else{
                _selectAllBtn.selected = NO;
            }
            
            [self countPrice];
            
        };
        
        //删除按钮
        if (cell.delectBtn.userInteractionEnabled == YES) {
            weakCell.deleteBlock = ^(){
            //删除数据源数组中的数组
                    if ([_dataArray containsObject:model]) {
                        [_dataArray removeObject:model];
                    }
                    //删除选中商品数组中的数组
                    if ([_selectGoods containsObject:model]) {
                        
                        [_selectGoods removeObject:model];
                    }
    
                    //核算价格
                    if (_dataArray.count > 0) {
                        [self countPrice];
                    }else{
                        _editBtn.selected = NO;
                        _editBtn.userInteractionEnabled = NO;
                        _accontView.hidden = YES;
                        [self cartEmptyShow];
                    };
                
            
                    [_tabelView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                    [self performSelector:@selector(reloadTabel) withObject:nil afterDelay:0.5];
            
            };
        }
        if (_dataArray.count > 0) {
            [self countPrice];
        }else{
            _editBtn.selected = NO;
            _accontView.hidden = YES;
            _editBtn.userInteractionEnabled = NO;
            [self cartEmptyShow];
        }
        [cell reloadDeleteDataWith:_dataArray[indexPath.row]];
        return cell;
        
    }else{
        CarCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.model = model;
        //判断是否为选择商品
        if ([_selectGoods containsObject:[_dataArray objectAtIndex:indexPath.row]]) {
            model.isSelect = YES;
            
        }
        
        cell.carBlock = ^(BOOL isSelec){
            if (isSelec) {
                model.isSelect = YES;
                [_selectGoods addObject:[_dataArray objectAtIndex:indexPath.row]];
            }else{
                model.isSelect = NO;
                [_selectGoods removeObject:[_dataArray objectAtIndex:indexPath.row]];
            }
            if (_selectGoods.count == _dataArray.count) {
                _selectAllBtn.selected = YES;
            }else{
                _selectAllBtn.selected = NO;
            }
            
            [self countPrice];
        };
        
        __block CarCell * weakCell = cell;
        
        //加方法
        cell.numAddBlock = ^(){
            //数量
            NSInteger  count = [weakCell.numLable.text integerValue] ;
            count++;
            carModel * model = [_dataArray objectAtIndex:indexPath.row];
            weakCell.numLable.text = [NSString stringWithFormat:@"%ld",count];
            weakCell.numberLable.text = [NSString stringWithFormat:@"%ld",count];
            NSString * preStr = weakCell.priceLabel.text;
            CGFloat  price = [preStr floatValue];
            CGFloat  coin = price * count;
            weakCell.coinLabel.text = [NSString stringWithFormat:@"%.0f个",coin];
            model.d_price = [NSString stringWithFormat:@"%.0f",coin];
            model.goods_number = [NSString stringWithFormat:@"%ld",(long)count];
            //覆盖原数据
            [_dataArray replaceObjectAtIndex:indexPath.row withObject:model];
            
            
            if ([_selectGoods containsObject:model]) {
                [_selectGoods removeObject:model];
                [_selectGoods addObject:model];
                [self countPrice];
        }
            
        };
        
        
        
        //减方法
        cell.numCutBlock =^(){
            
            NSString * str = weakCell.numberLable.text;
            NSInteger count = [str integerValue];
            count--;
            if(count <= 0){
                return ;
            }
            NSString *numStr = [NSString stringWithFormat:@"%ld",(long)count];
            
            carModel *model = [_dataArray objectAtIndex:indexPath.row];
            
            weakCell.numLable.text = [NSString stringWithFormat:@"* %@",numStr];
            weakCell.numberLable.text = numStr;
            model.goods_number = [NSString stringWithFormat:@"%ld",count];
            
            NSString * preStr = weakCell.priceLabel.text;
            CGFloat  price = [preStr floatValue];
            CGFloat  coin = price * count;
            weakCell.coinLabel.text = [NSString stringWithFormat:@"%.0f个",coin];
            model.d_price = [NSString stringWithFormat:@"%.0f",coin];
            model.goods_number = [NSString stringWithFormat:@"%ld",count];
            [_dataArray replaceObjectAtIndex:indexPath.row withObject:model];
            
            //判断已选择数组里有无该对象,有就删除  重新添加
            if ([_selectGoods containsObject:model]) {
                [_selectGoods removeObject:model];
                [_selectGoods addObject:model];
                [self countPrice];
            }
         
        };
        
        [self countPrice];
        
        [cell reloadDataWith:[_dataArray objectAtIndex:indexPath.row]];
        
        return cell;
    }
        
    }



-(void)reloadTabel{
    
    [_tabelView reloadData];
    
}



        
-(void)countPrice{
    double totlePrice = 0.0,totleFeight = 0.0;
    UILabel * priceLable = [self.view viewWithTag:3];
    UILabel * fieghtLable = (UILabel *)[self.view viewWithTag:4];
    for (carModel *model in _selectGoods) {
        NSString * str = model.goods_price;
        double price = [str doubleValue];
        double fieght = [model.shipping_price doubleValue];
        totlePrice += price * [model.goods_number floatValue];
        totleFeight += fieght;
    }
    priceLable.text = [NSString stringWithFormat:@"合计：%.2f",totlePrice];
    fieghtLable.text = [NSString stringWithFormat:@"（含运费：%.2f)",totleFeight];
    
}

-(void)toHome:(UIButton *)button{
    
    self.tabBarController.selectedIndex = 0;
}

//编辑按钮的实现
-(void)toEdit:(UIButton *)button{
    
    [_tabelView reloadData];
    
    if (_accontView!=nil) {
        [_accontView removeFromSuperview];
    }
    button.selected = !button.selected;
    [self createAccountBar];
    
    
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //点击cell  让颜色变回来
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

#pragma mark - 侧滑删除
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_editBtn.selected == YES) {
        
        return UITableViewCellEditingStyleDelete;
        
    }else{
        
        
        return UITableViewCellEditingStyleNone;
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //服务器发送请求告诉服务请数据删除
        carModel * model = _dataArray[indexPath.row];
        [_dataArray removeObjectAtIndex:indexPath.row];
        if ([_selectGoods containsObject:model]) {
            
            [_selectGoods removeObject:model];
        }
        
        if (_dataArray.count > 0) {
            
            _accontView.hidden = YES;
            
        }else{
            
            [self countPrice];
            
        }
        [_tabelView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self performSelector:@selector(reloadTabel) withObject:nil afterDelay:0.5];
        //进行网络请求
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"从购物车移除";
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
