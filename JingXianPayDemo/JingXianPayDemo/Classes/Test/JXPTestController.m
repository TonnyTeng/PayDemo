//
//  JXPTestController.m
//  JingXianPayDemo
//
//  Created by dengtao on 2017/5/12.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "JXPTestController.h"

@interface JXPTestController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation JXPTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self setNavigationTitle:@"测试刷卡器"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView reloadData];
}

#pragma mark - Action

- (IBAction)startAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        NSLog(@"开始");
    }else{
    
        NSLog(@"已经开始。。。");
    }
}

- (IBAction)endAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        NSLog(@"结束");
    }else{
        
        NSLog(@"已经结束。。。");
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"test";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    cell.textLabel.text = [NSString stringWithFormat:@"section:%d row:%d",indexPath.section,indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else{
    
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
