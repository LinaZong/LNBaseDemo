//
//  totalModel.h
//  LNBaseDemo
//
//  Created by 宗丽娜 on 16/6/17.
//  Copyright © 2016年 hi. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface totalModel : JSONModel
@property(nonatomic,copy)NSString * goods_price;//总价格
@property(nonatomic,assign)NSNumber * goods_amount;//商品价格
@property(nonatomic,assign)NSNumber * real_goods_count;//商品个数
@end
