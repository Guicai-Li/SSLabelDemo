//
//  SSLabel.h
//  SSLabelDemo
//
//  Created by LiGuicai on 15/6/18.
//  Copyright (c) 2015年 guicai.li.china@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSLabel : UILabel

@property (nonatomic, assign, setter = setCharacterSpacing:) CGFloat characterSpacing;      //字间距
@property (nonatomic, assign, setter = setParagraphSpacing:) CGFloat paragraphSpacing;      //行间距
@property (nonatomic, assign, setter = setLineSpacing:) CGFloat lineSpacing;                //段间距

- (int)getAttributedStringHeightWidthValue:(int)width;

@end
