//
//  JXPMoreController.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "JXPMoreController.h"
#import "JXPHomeController.h"
#import "JXPBaseNavController.h"
#import "JXPLoginController.h"
#define kTitle  @"title"
#define kTag    @"tag"


#define kTag_Help               100
#define kTag_ChangeAccount      101
#define kTag_BindBank           102
#define kTag_RealNameAuth       103
#define kTag_TestMachine        104
#define kTag_NewGuide           105
#define kTag_SettingMachine     106
#define kTag_FixBindBank        107


@interface JXPMoreController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray        *dataSource;
@property (nonatomic, strong) UITableView           *tableView;
@property (nonatomic, strong) XTView                *footerView;

@end

@implementation JXPMoreController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showRightButtonItemWithTitle:@"退出登录" Sel:@selector(logOutAction)];
    [self showLeftButtonItemWithTitle:nil Sel:nil];
    
//    [self.view addSubview:self.tableView];
//    [self configData];
}

#pragma mark - ConfigData
- (void)configData{
    
    [_dataSource addObject:@{kTitle:@"帮助",         kTag:@(kTag_Help)}];
    [_dataSource addObject:@{kTitle:@"切换账户",      kTag:@(kTag_ChangeAccount)}];
    [_dataSource addObject:@{kTitle:@"绑定银行卡",    kTag:@(kTag_BindBank)}];
    [_dataSource addObject:@{kTitle:@"实名认证",      kTag:@(kTag_RealNameAuth)}];
    [_dataSource addObject:@{kTitle:@"测试刷卡器",    kTag:@(kTag_TestMachine)}];
    [_dataSource addObject:@{kTitle:@"新手指南",      kTag:@(kTag_NewGuide)}];
    [_dataSource addObject:@{kTitle:@"设置刷卡器",    kTag:@(kTag_SettingMachine)}];
    [_dataSource addObject:@{kTitle:@"修改绑定银行卡", kTag:@(kTag_FixBindBank)}];
    
//    [self.tableView reloadData];
}

#pragma mark - Action
- (void)logOutAction{

    CLIENT.user = nil;
    JXPLoginController *loginVC = [[JXPLoginController alloc] init];
    loginVC.fromVC = NSStringFromClass([self class]);
    [self.navigationController pushViewController:loginVC animated:YES];
    
}


#pragma mark - UITableViewDelegate,UITableViewDataSource



#pragma mark - Setter/Getter


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
