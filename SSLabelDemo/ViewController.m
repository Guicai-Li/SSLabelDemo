//
//  ViewController.m
//  SSLabelDemo
//
//  Created by LiGuicai on 15/6/18.
//  Copyright (c) 2015年 guicai.li.china@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import "SSLabel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    // Do any additional setup after loading the view, typically from a nib.
    // [test1]
    SSLabel *label = [[SSLabel alloc] init];
    NSString * content = @"这是  一个自定义间距的  Label，这是一个自定 义间距的La bel ， 这是 一个自定义间距的Label。\n\n\n 这是一个自定义间距的Label，这是一个自定 义间距的La bel   ， 这是 一个自定义间距的Label。";
    label.text = content;
    //使用自定义字体
    label.font = [UIFont systemFontOfSize:16.0f];
    //设置字体颜色
    label.textColor = [UIColor blackColor];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor redColor];
    //根据字符串长度和Label显示的宽度计算出contentLab的高
    NSLog(@"%d == %@", [label getAttributedStringHeightWidthValue:300], label);
    label.frame = CGRectMake(0, 0, 300, [label getAttributedStringHeightWidthValue:300]);
    [self.view addSubview:label];
    
    // [test2]
    SSLabel *label2 = [[SSLabel alloc] init];
    label2.font = [UIFont systemFontOfSize:16.0f];
    //设置字体颜色
    label2.textColor = [UIColor blackColor];
    label2.lineBreakMode = NSLineBreakByWordWrapping;
    label2.numberOfLines = 0;
    label2.backgroundColor = [UIColor greenColor];
    label2.frame = CGRectMake(30, 300, 300, [label2 getAttributedStringHeightWidthValue:300]);
    [self.view addSubview:label2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
