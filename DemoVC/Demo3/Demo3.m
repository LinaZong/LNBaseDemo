//
//  Demo3.m
//  LNBaseDemo
//
//  Created by 宗丽娜 on 16/6/17.
//  Copyright © 2016年 hi. All rights reserved.
//

#import "Demo3.h"
#import "coreTextView.h"
@interface Demo3 ()

@end

@implementation Demo3

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    coreTextView *view = [[coreTextView alloc] initWithFrame:CGRectMake(200, 350, 300, 300)];
    view.center = self.view.center;
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    
    /**
     改变某个字符串中部分字符的显示样式
     // NSFontAttributeName                设置字体属性，默认值：字体：Helvetica(Neue) 字号：12
     // NSForegroundColorAttributeNam      设置字体颜色，取值为 UIColor对象，默认值为黑色
     // NSBackgroundColorAttributeName     设置字体所在区域背景颜色，取值为 UIColor对象，默认值为nil, 透明色
     // NSLigatureAttributeName            设置连体属性，取值为NSNumber 对象(整数)，0 表示没有连体字符，1 表示使用默认的连体字符
     // NSKernAttributeName                设定字符间距，取值为 NSNumber 对象（整数），正值间距加宽，负值间距变窄
     // NSStrikethroughStyleAttributeName  设置删除线，取值为 NSNumber 对象（整数）
     // NSStrikethroughColorAttributeName  设置删除线颜色，取值为 UIColor 对象，默认值为黑色
     // NSUnderlineStyleAttributeName      设置下划线，取值为 NSNumber 对象（整数），枚举常量 NSUnderlineStyle中的值，与删除线类似
     // NSUnderlineColorAttributeName      设置下划线颜色，取值为 UIColor 对象，默认值为黑色
     // NSStrokeWidthAttributeName         设置笔画宽度，取值为 NSNumber 对象（整数），负值填充效果，正值中空效果
     // NSStrokeColorAttributeName         填充部分颜色，不是字体颜色，取值为 UIColor 对象
     // NSShadowAttributeName              设置阴影属性，取值为 NSShadow 对象
     // NSTextEffectAttributeName          设置文本特殊效果，取值为 NSString 对象，目前只有图版印刷效果可用：
     // NSBaselineOffsetAttributeName      设置基线偏移值，取值为 NSNumber （float）,正值上偏，负值下偏
     // NSObliquenessAttributeName         设置字形倾斜度，取值为 NSNumber （float）,正值右倾，负值左倾
     // NSExpansionAttributeName           设置文本横向拉伸属性，取值为 NSNumber （float）,正值横向拉伸文本，负值横向压缩文本
     // NSWritingDirectionAttributeName    设置文字书写方向，从左向右书写或者从右向左书写
     // NSVerticalGlyphFormAttributeName   设置文字排版方向，取值为 NSNumber 对象(整数)，0 表示横排文本，1 表示竖排文本
     // NSLinkAttributeName                设置链接属性，点击后调用浏览器打开指定URL地址
     // NSAttachmentAttributeName          设置文本附件,取值为NSTextAttachment对象,常用于文字图片混排
     // NSParagraphStyleAttributeName      设置文本段落排版格式，取值为 NSParagraphStyle 对象
     */
    NSMutableAttributedString * text =[[NSMutableAttributedString alloc] initWithString:@"我是一只小小鸟"];
    UILabel * lable =[[UILabel alloc] initWithFrame:CGRectMake(100, 50, 300, 50)];
    //改变字体的大小
    //NSfontAttributeName : 是一个UIFont对象 使用这个属性更改字体的大小NSMakeRage(小标，长度)
    [text addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30] range:NSMakeRange(0, 1)];
    //字体的格式
    [text addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Optima" size:35] range:NSMakeRange(1, 2)];
    
    //字体的颜色
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 1)];
    //字体背景颜色
    [text addAttribute:NSBackgroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(2, 1)];
    //字体添加下划线(下划线风格)
    /**NSUnderlineStyleDouble  双线
     NSUnderlineStyleNone 没有
     NSUnderlineStyleSingle 细线
     NSUnderlineStyleThick 粗线
     **/
    [text addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleThick) range:NSMakeRange(4, 1)];
    
    //下划线颜色
    [text addAttribute:NSUnderlineColorAttributeName value:[UIColor yellowColor] range:NSMakeRange(4, 1)];
    
    //删除线(中间线) 默认none
    [text addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlineStyleDouble) range:NSMakeRange(5, 1)];
    [text addAttribute:NSStrikethroughColorAttributeName value:[UIColor blueColor] range:NSMakeRange(5, 1)];
    
    //文字描边颜色，需要和NSStrokeWidthAttributeName设置描边宽度，这样就能使文字空心. 默认0
    [text addAttribute:NSStrokeWidthAttributeName value:@(-1) range:NSMakeRange(1, 5)];
    
    [text addAttribute:NSStrokeColorAttributeName value:[UIColor greenColor] range:NSMakeRange(1, 5)];
    //空心字
    
    [text addAttribute:NSStrokeWidthAttributeName value:@(1) range:NSMakeRange(6, 1)];
    //改变填充字/空心字颜色(依附于填充字/空心字)
    [text addAttribute:NSStrokeColorAttributeName value:[UIColor purpleColor] range:NSMakeRange(6, 1)];
    //添加图片
    NSTextAttachment * attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"tank"];
    attch.bounds = CGRectMake(0, 0, 50, 50);
    //创建带图片的富文本
    NSAttributedString * string =[NSAttributedString attributedStringWithAttachment:attch];
    [text appendAttributedString:string];
    
    lable.attributedText= text;
    [self.view addSubview:lable];

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
