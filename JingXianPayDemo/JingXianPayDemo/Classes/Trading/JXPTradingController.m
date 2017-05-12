//
//  JXPTradingController.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "JXPTradingController.h"

@interface JXPTradingController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView           *tableView;

@end

@implementation JXPTradingController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self showLeftButtonItemWithTitle:nil Sel:nil];
//    [self.view addSubview:self.tableView];
//    [self configData];
}



#pragma mark - ConfigData
- (void)configData{

    
}



#pragma mark - UITableViewDelegate,UITableViewDataSource



#pragma mark - Setter/Getter


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
