//
//  MBProgressHUD+LJCHUD.m
//  HUDDemo
//
//  Created by Aliang Ren on 2020/6/24.
//  Copyright © 2020 Aliang Ren. All rights reserved.
//

#import "MBProgressHUD+LJCHUD.h"
#import "FLAnimatedImageView.h"
#import "FLAnimatedImage.h"

#define HudFont (([UIScreen mainScreen].bounds.size.width > 375) ? 17 : ([UIScreen mainScreen].bounds.size.width > 320) ? 16 : 15) // 字体大小
#define SpinDiameter 35 // 直径
#define SpinWidth 2 // 圆环宽
#define StartColor [UIColor colorWithRed:254/255.0 green:92/255.0 blue:46/255.0 alpha:1] // 渐变开始颜色
#define EndColor [UIColor colorWithRed:254/255.0 green:92/255.0 blue:46/255.0 alpha:0.3] // 渐变结束颜色

@implementation MBProgressHUD (LJCHUD)

+ (MBProgressHUD *)showTextHud:(NSString *)text toView:(UIView *)view {
    return [self showTextHud:nil withDes:text withImage:nil toView:view];
}
+ (MBProgressHUD *)showSuccTextHud:(NSString *)text toView:(UIView *)view {
    return [self showTextHud:nil withDes:text withImage:@"ljc_success.png" toView:view];
}
+ (MBProgressHUD *)showErrorTextHud:(NSString *)text toView:(UIView *)view {
    return [self showTextHud:nil withDes:text withImage:@"ljc_error.png" toView:view];
}
+ (MBProgressHUD *)showTextHud:(NSString *)text withDes:(NSString *)des toView:(UIView *)view {
    return [self showTextHud:text withDes:des withImage:nil toView:view];
}
+ (MBProgressHUD *)showTextHud:(NSString *)text withImage:(NSString *)name toView:(UIView *)view {
    
    return [self showTextHud:nil withDes:text withImage:name toView:view];
}

+ (MBProgressHUD *)showTextHud:(NSString *)text withDes:(NSString *)des withImage:(NSString *)name toView:(UIView *)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    if (name) {
        hud.mode = MBProgressHUDModeCustomView;
        FLAnimatedImageView *imV = [[FLAnimatedImageView alloc] init];
        imV.image = [UIImage imageNamed:name];
//        imV.imageSize = CGSizeMake(35, 35);
        hud.customView = imV;
    } else {
        hud.mode = MBProgressHUDModeText;
    }
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:.7];
//        hud.offset = CGPointMake(0.f, MBProgressMaxOffset); // 显示在屏幕底部
//        hud.contentColor = [UIColor whiteColor]; // 改变content上的菊花和文字颜色
    if (text) {
        hud.label.text = text;
        hud.label.textColor = [UIColor whiteColor];
        hud.label.font = [UIFont systemFontOfSize:HudFont];
    }
    hud.detailsLabel.text = des;
    hud.detailsLabel.textColor = [UIColor whiteColor];
    hud.detailsLabel.font = [UIFont systemFontOfSize:text?HudFont-2:HudFont];
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:0.8f];

    return hud;
    
}
// 改变图片的颜色
+ (UIImage *)aimsImage:(UIImage *)image changeColor:(UIColor *)color {
    //获取画布
//    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    UIGraphicsBeginImageContextWithOptions(image.size, NO,[UIScreen mainScreen].scale);
    //画笔沾取颜色
    [color setFill];
    //
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    UIRectFill(bounds);
    //绘制一次
    [image drawInRect:bounds blendMode:kCGBlendModeOverlay alpha:1.0f];
    //再绘制一次
    [image drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    //获取图片
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
+ (MBProgressHUD *)showIndicatorHud:(NSString * _Nullable)text toView:(UIView * _Nullable)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    // 设置提示框背景色
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:.7];
    hud.contentColor = [UIColor whiteColor]; // 改变content上的菊花和文字颜色
    if (text) {
        hud.detailsLabel.font = [UIFont systemFontOfSize:HudFont];
        hud.detailsLabel.textColor = [UIColor whiteColor];
        hud.detailsLabel.text = text;
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud showHud];
    
    return hud;
}

+ (MBProgressHUD *)showSpinIndicator:(NSString * _Nullable)text toView:(UIView * _Nullable)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:.7];
    hud.contentColor = [UIColor whiteColor]; // 改变content上的菊花和文字颜色
    UIImageView *imV = [[UIImageView alloc] initWithImage:[self createImageWithColor:[UIColor clearColor] imgSize:CGSizeMake(SpinDiameter, SpinDiameter)]];
    CALayer *layer = [self createMaskLayer];
    [imV.layer addSublayer:layer];
    hud.customView = imV;
    hud.square = NO;
    if (text) {
        hud.detailsLabel.font = [UIFont systemFontOfSize:HudFont];
        hud.detailsLabel.textColor = [UIColor whiteColor];
        hud.detailsLabel.text = text;
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud showHud];
    
    return hud;
}
// 创建旋转的环形渐变layer
+ (CALayer*)createMaskLayer {
    // 背景layer
    CALayer *bgLayer = [CALayer layer];
    bgLayer.frame = CGRectMake(0, 0, SpinDiameter, SpinDiameter);
    bgLayer.backgroundColor = [UIColor clearColor].CGColor;
    // 创建圆环
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(SpinDiameter/2, SpinDiameter/2) radius:SpinDiameter/2-SpinWidth startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    // 圆环遮罩
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor whiteColor].CGColor;
    shapeLayer.lineWidth = SpinWidth;
    shapeLayer.strokeStart = 0;
    shapeLayer.strokeEnd = 1;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.lineDashPhase = 0.8;
    shapeLayer.path = bezierPath.CGPath;
    [bgLayer setMask:shapeLayer];
    //颜色渐变
    NSMutableArray *colors = [NSMutableArray arrayWithObjects:(id)StartColor.CGColor,(id)EndColor.CGColor, nil];
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.shadowPath = bezierPath.CGPath;
    gradientLayer.frame = CGRectMake(0, 0, SpinDiameter, SpinDiameter/2);
    gradientLayer.startPoint = CGPointMake(1, 0);
    gradientLayer.endPoint = CGPointMake(0, 0);
    [gradientLayer setColors:[NSArray arrayWithArray:colors]];
    //
    NSMutableArray *colors1 = [NSMutableArray arrayWithObjects:(id)EndColor.CGColor,(id)[[UIColor clearColor] CGColor], nil];
    CAGradientLayer *gradientLayer1 = [CAGradientLayer layer];
    gradientLayer1.shadowPath = bezierPath.CGPath;
    gradientLayer1.frame = CGRectMake(0, SpinDiameter/2, SpinDiameter, SpinDiameter/2);
    gradientLayer1.startPoint = CGPointMake(0, 1);
    gradientLayer1.endPoint = CGPointMake(1, 1);
    [gradientLayer1 setColors:[NSArray arrayWithArray:colors1]];
    [bgLayer addSublayer:gradientLayer]; //设置颜色渐变
    [bgLayer addSublayer:gradientLayer1];
    // 旋转动画
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2.0*M_PI];
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.duration = 1;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [bgLayer addAnimation:rotationAnimation forKey:@"rotationAnnimation"];
    
    return bgLayer;
   
}
// 根据颜色生成图片
+ (UIImage *)createImageWithColor:(UIColor *)color  imgSize:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width,size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 填充color
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    // 获取图片
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭
    UIGraphicsEndImageContext();
    return theImage;
}
+ (MBProgressHUD *)showGif:(NSString * _Nullable)name withText:(NSString * _Nullable)text toView:(UIView * _Nullable)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:.7];
    hud.contentColor = [UIColor whiteColor]; // 改变content上的菊花和文字颜色
//    [UIImage imag]
    if (name) {
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"gif"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:data];
        FLAnimatedImageView *imV = [[FLAnimatedImageView alloc] init];
        imV.animatedImage = animatedImage;
        imV.imageSize = CGSizeMake(35, 35);
        hud.customView = imV;
        hud.square = NO;
    }
    if (text) {
        hud.detailsLabel.font = [UIFont systemFontOfSize:HudFont];
        hud.detailsLabel.textColor = [UIColor whiteColor];
        hud.detailsLabel.text = text;
    }
    hud.removeFromSuperViewOnHide = YES;
    [hud showHud];
    
    return hud;
}
+ (MBProgressHUD *)showSpinProgress:(NSString * _Nullable)text toView:(UIView * _Nullable)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:.7];
    hud.contentColor = [UIColor orangeColor];
    if (text) {
        hud.detailsLabel.text = text;
        hud.detailsLabel.textColor = [UIColor whiteColor];
        hud.detailsLabel.font = [UIFont systemFontOfSize:HudFont];
    }
    [hud showHud];
    // 带按钮
//    [hud.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    hud.button.titleLabel.font = [UIFont systemFontOfSize:HudFont-1];
//    [hud.button setTitle:@"取消" forState:UIControlStateNormal];
//    [hud.button addTarget:self action:@selector(cancelWork:) forControlEvents:UIControlEventTouchUpInside];
    return hud;
}
+ (MBProgressHUD *)showHorizontalProgress:(NSString * _Nullable)text toView:(UIView * _Nullable)view {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0 alpha:.7];
    hud.contentColor = [UIColor orangeColor];
    if (text) {
        hud.detailsLabel.text = text;
        hud.detailsLabel.textColor = [UIColor whiteColor];
        hud.detailsLabel.font = [UIFont systemFontOfSize:HudFont];
    }
    [hud showHud];
    return hud;
}
- (void)showHud {
    [self showAnimated:YES];
}
- (void)hiddenHud {
    [self hideAnimated:YES];
}

@end
