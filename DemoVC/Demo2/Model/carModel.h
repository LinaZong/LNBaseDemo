//
//  carModel.h
//  guoshang
//
//  Created by 宗丽娜 on 16/2/29.
//  Copyright © 2016年 宗丽娜. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface carModel : NSObject

@property(nonatomic,copy)NSString * goods_id;//商品的ID
@property(nonatomic,copy)NSString * product_id;//产品ID
@property(nonatomic,copy)NSString * goods_name;//产品名字
@property(nonatomic,copy)NSString * goods_price;//商品实际价格
@property(nonatomic,copy)NSString * goods_number;//商品的数量
@property(nonatomic,copy)NSString * d_price; //赠送金币
@property(nonatomic,copy)NSString * goods_thumb;//商品图片
@property(nonatomic,copy)NSString * shipping_price;//运费
@property(nonatomic,copy)NSString * attr_names;//规格
@property(nonatomic,assign)BOOL isSelect;

+(instancetype)ModelWithDict:(NSDictionary *)dict;
-(instancetype)initWithDict:(NSDictionary *)dict;
@end
