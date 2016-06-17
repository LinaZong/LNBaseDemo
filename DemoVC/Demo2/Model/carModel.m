//
//  carModel.m
//  guoshang
//
//  Created by 宗丽娜 on 16/2/29.
//  Copyright © 2016年 宗丽娜. All rights reserved.
//

#import "carModel.h"

@implementation carModel
+(instancetype)ModelWithDict:(NSDictionary *)dict{
    return [[carModel alloc] initWithDict:dict];
}
-(instancetype)initWithDict:(NSDictionary *)dict{
    
    if (self = [super init]) {
       
        self.goods_id =dict[@"goods_id"];
        self.product_id =dict[@"product_id"];
        self.goods_name =dict[@"goods_name"];
        self.goods_price =dict[@"goods_price"];
        self.goods_number =dict[@"goods_number"];
        self.d_price =dict[@"d_price"];
        self.goods_thumb =dict[@"goods_thumb"];
        self.shipping_price =dict[@"shipping_price"];
        self.isSelect = [dict[@"isSelect"] boolValue];
        self.attr_names = dict[@"attr_names"];
        
        
    }
    return self;
}
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}
@end
