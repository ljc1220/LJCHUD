//
//  MBProgressHUD+LJCHUD.h
//  HUDDemo
//
//  Created by Aliang Ren on 2020/6/24.
//  Copyright © 2020 Aliang Ren. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (LJCHUD)

//**********以下方法调用后都会自动展示HUD，如需手动触发显示可再进行扩展*********/
/// 文字提示
+ (MBProgressHUD *)showTextHud:(NSString * _Nullable)text toView:(UIView * _Nullable)view;
/// 成功样式提示
+ (MBProgressHUD *)showSuccTextHud:(NSString * _Nullable)text toView:(UIView * _Nullable)view;
/// 出错样式提示
+ (MBProgressHUD *)showErrorTextHud:(NSString * _Nullable)text toView:(UIView * _Nullable)view;
/// 文字+描述提示
+ (MBProgressHUD *)showTextHud:(NSString * _Nullable)text withDes:(NSString * _Nullable)des toView:(UIView * _Nullable)view;
/// 文字+自定义图片提示
+ (MBProgressHUD *)showTextHud:(NSString * _Nullable)text withImage:(NSString * _Nullable)name toView:(UIView * _Nullable)view;
/// 文字+描述+自定义图片提示
+ (MBProgressHUD *)showTextHud:(NSString * _Nullable)text withDes:(NSString * _Nullable)des withImage:(NSString * _Nullable)name toView:(UIView * _Nullable)view;
/// 菊花提示
+ (MBProgressHUD *)showIndicatorHud:(NSString * _Nullable)text toView:(UIView * _Nullable)view;
/// 环形加载提示
+ (MBProgressHUD *)showSpinIndicator:(NSString * _Nullable)text toView:(UIView * _Nullable)view;
/// 自定义动图加载提示
+ (MBProgressHUD *)showGif:(NSString * _Nullable)name withText:(NSString * _Nullable)text toView:(UIView * _Nullable)view;
/// 环形进度条
+ (MBProgressHUD *)showSpinProgress:(NSString * _Nullable)text toView:(UIView * _Nullable)view;
/// 横向进度条
+ (MBProgressHUD *)showHorizontalProgress:(NSString * _Nullable)text toView:(UIView * _Nullable)view;
/// 显示提示框
- (void)showHud;
/// 隐藏提示框
- (void)hiddenHud;

@end

NS_ASSUME_NONNULL_END
