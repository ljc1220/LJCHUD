//
//  HUDViewController.m
//  HUDDemo
//
//  Created by Aliang Ren on 2020/6/23.
//  Copyright © 2020 Aliang Ren. All rights reserved.
//

#import "HUDViewController.h"
#import "MBProgressHUD+LJCHUD.h"

@interface HUDViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation HUDViewController
- (void)dealloc {
    NSLog(@"11111111");
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleGray;
        _tableView.separatorColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_tableView];
        
    }
    
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSource = [[NSMutableArray alloc]initWithArray:@[@"文字带自定义图片",@"纯文字提示",@"文字提示带标题",@"菊花加载框",@"环形加载框",@"环形进度条",@"横向进度条",@"动态图加载",@"成功提示",@"出错提示"]];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    return 50;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SettingCell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        // 文字带自定义图片
        [MBProgressHUD showTextHud:@"哈哈哈啊哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈" withImage:@"down_tyx.png" toView:self.view];
        
    } else if (indexPath.row == 1) {
        // 纯文字提示
        [MBProgressHUD showTextHud:@"哈哈哈啊哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈" toView:self.view];
        
    } else if (indexPath.row == 2) {
        // 文字提示带标题
        [MBProgressHUD showTextHud:@"这是一个标题" withDes:@"哈哈哈啊哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈" toView:self.view];
        
    } else if (indexPath.row == 3) {
        MBProgressHUD *hud = [MBProgressHUD showIndicatorHud:@"加载" toView:self.view];
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            sleep(2.);
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hiddenHud];
            });
        });
    } else if (indexPath.row == 4) {
        MBProgressHUD *hud = [MBProgressHUD showSpinIndicator:@"加载" toView:self.view];
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            sleep(2);
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hiddenHud];
            });
        });
    } else if (indexPath.row == 5)  {
        MBProgressHUD *hud = [MBProgressHUD showSpinProgress:@"加载进度" toView:self.view];
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            
            float progress = 0.0f;
            while (progress < 3.0f) {
                progress += 0.1f;
                dispatch_async(dispatch_get_main_queue(), ^{
                    hud.progress = progress/3.0f;
                });
                usleep(50000);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hiddenHud];
            });
        });
    } else if (indexPath.row == 6) {
        MBProgressHUD *hud = [MBProgressHUD showHorizontalProgress:@"加载进度" toView:self.view];
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            
            float progress = 0.0f;
            while (progress < 3.0f) {
                progress += 0.1f;
                dispatch_async(dispatch_get_main_queue(), ^{
                    hud.progress = progress/3.0f;
                });
                usleep(50000);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hiddenHud];
            });
        });
    } else if (indexPath.row == 7) {
        MBProgressHUD *hud = [MBProgressHUD showGif:@"mifeng" withText:@"加载中" toView:self.view];
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
            sleep(3);
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hiddenHud];
            });
        });
    } else if (indexPath.row == 8) {
        [MBProgressHUD showSuccTextHud:@"搞定了" toView:self.view];
    } else if (indexPath.row == 9) {
        [MBProgressHUD showErrorTextHud:@"搞不定了" toView:self.view];
    }
    
}

@end
