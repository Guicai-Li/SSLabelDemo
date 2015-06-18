//
//  SSLabel.m
//  SSLabelDemo
//
//  Created by LiGuicai on 15/6/18.
//  Copyright (c) 2015年 guicai.li.china@gmail.com. All rights reserved.
//

#import "SSLabel.h"
#import <CoreText/CoreText.h>

@interface SSLabel ()

@property (nonatomic, strong) NSMutableAttributedString *attributedString;

@end

@implementation SSLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _characterSpacing = 1.5f;
        _paragraphSpacing = 4.0f;
        _lineSpacing = 10.0f;
    }
    return self;
}

- (NSAttributedString *)attributedString {
    if (_attributedString == nil) {
        if (self.text == nil) {
            return nil;
        }
        // 字体
        _attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
        CTFontRef font = CTFontCreateWithName((CFStringRef)self.font.fontName,self.font.pointSize,NULL);
        [_attributedString addAttribute:(id)kCTFontAttributeName value:(__bridge id)(font) range:NSMakeRange(0, [_attributedString length])];
        
        //设置字间距
        long number = self.characterSpacing;
        CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberFloat64Type,&number);
        [_attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[_attributedString length])];
        CFRelease(num);
        
        //设置字体颜色
        [_attributedString addAttribute:(id)kCTForegroundColorAttributeName value:(id)(self.textColor.CGColor) range:NSMakeRange(0,[_attributedString length])];
        
        //创建文本对齐方式
        CTTextAlignment alignment = kCTTextAlignmentLeft;
        switch (self.textAlignment) {
            case NSTextAlignmentCenter:{
                alignment = kCTTextAlignmentCenter;
                break;
            }
            case NSTextAlignmentRight:{
                alignment = kCTTextAlignmentRight;
                break;
            }
            case NSTextAlignmentJustified:{
                alignment = kCTTextAlignmentJustified;
                break;
            }
            case NSTextAlignmentNatural:{
                alignment = kCTTextAlignmentNatural;
                break;
            }
            default:
                break;
        }
        CTParagraphStyleSetting alignmentStyle;
        alignmentStyle.spec = kCTParagraphStyleSpecifierAlignment;
        alignmentStyle.valueSize = sizeof(alignment);
        alignmentStyle.value = &alignment;
        
        //设置文本行间距
        CGFloat lineSpace = self.lineSpacing;
        CTParagraphStyleSetting lineSpaceStyle;
        lineSpaceStyle.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
        lineSpaceStyle.valueSize = sizeof(lineSpace);
        lineSpaceStyle.value =&lineSpace;
        
        //设置文本段间距
        CGFloat paragraphSpacings = self.paragraphSpacing;
        CTParagraphStyleSetting paragraphSpaceStyle;
        paragraphSpaceStyle.spec = kCTParagraphStyleSpecifierParagraphSpacing;
        paragraphSpaceStyle.valueSize = sizeof(CGFloat);
        paragraphSpaceStyle.value = &paragraphSpacings;
        
        //创建设置数组
        CTParagraphStyleSetting settings[ ] ={alignmentStyle,lineSpaceStyle,paragraphSpaceStyle};
        CTParagraphStyleRef style = CTParagraphStyleCreate(settings ,3);
        
        //给文本添加设置
        [_attributedString addAttribute:(id)kCTParagraphStyleAttributeName value:(__bridge id)style range:NSMakeRange(0 , [_attributedString length])];
        CFRelease(style);
    }
    return _attributedString;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    if (self.attributedString == nil) {
        return;
    }
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attributedString);
    
    CGMutablePathRef leftColumnPath = CGPathCreateMutable();
    
    CGPathAddRect(leftColumnPath, NULL ,CGRectMake(0 , 0 ,self.bounds.size.width , self.bounds.size.height));
    
    CTFrameRef leftFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0, 0), leftColumnPath , NULL);
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetTextMatrix(context , CGAffineTransformIdentity);
    
    CGContextTranslateCTM(context , 0 ,self.bounds.size.height);
    
    CGContextScaleCTM(context, 1.0 ,-1.0);
    
    
    CTFrameDraw(leftFrame,context);
    
    
    CGPathRelease(leftColumnPath);
    
    CFRelease(framesetter);
    
    UIGraphicsPushContext(context);
}

- (int)getAttributedStringHeightWidthValue:(int)width
{
    if (self.attributedString == nil) {
        return 0;
    }
    
    int total_height = 0;
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_attributedString);
    CGRect drawingRect = CGRectMake(0, 0, width, 100000);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    int line_y = (int) origins[[linesArray count] -1].y;
    
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    
    total_height = 100000 - line_y + (int) descent +1;//+1为了纠正descent转换成int小数点后舍去的值
    
    CFRelease(textFrame);
    
    return total_height;
}

#pragma mark - Set方法
- (void)setCharacterSpacing:(CGFloat)characterSpacing {
    _characterSpacing = characterSpacing;
    [self setNeedsDisplay];
}

- (void)setParagraphSpacing:(CGFloat)paragraphSpacing {
    _paragraphSpacing = paragraphSpacing;
    [self setNeedsDisplay];
}

- (void)setLineSpacing:(CGFloat)lineSpacing {
    _lineSpacing = lineSpacing;
    [self setNeedsDisplay];
}

@end
