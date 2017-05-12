//
//  JXPAccountController.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "JXPAccountController.h"
//#import "FTEPassWordController.h"
//#import "FTECameraHeartBeatController.h"
//#import "FTEInfoView.h"
//#import "FTEBankView.h"

@interface JXPAccountController ()

@property (nonatomic, strong) UIScrollView  *scrollView;
@property (nonatomic, strong) XTButton      *passWordButton;
@property (nonatomic, strong) XTButton      *uploadLogButton;
//@property (nonatomic, strong) FTEBankView   *bankView;
//@property (nonatomic, strong) FTEInfoView   *infoView;

@end

@implementation JXPAccountController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showLeftButtonItemWithTitle:nil Sel:nil];
    
    [self.view addSubview:self.scrollView];
//    [self.scrollView addSubview:self.infoView];
//    [self.scrollView addSubview:self.bankView];
//    [self.scrollView addSubview:self.passWordButton];
//    [self.scrollView addSubview:self.uploadLogButton];
}

#pragma mark - Action
- (void)passWordManagementAction{
    
}


- (void)uploadLogAction{

    

    
}

#pragma mark - Setter/Getter
-(UIScrollView *)scrollView{

    if (_scrollView == nil) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 49)];
        _scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _scrollView;
}

//
//-(XTButton *)passWordButton{
//
//    if (_passWordButton == nil) {
//        
//        _passWordButton = [[XTButton alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.bankView.frame) + 20, kScreenWidth / 2 - 15 * 1.5, 40)];
//        _passWordButton.backgroundColor = kRGB(61, 144, 247);
//        _passWordButton.layer.cornerRadius = kFTECornerRadius;
//        [_passWordButton setTitle:@"密码管理" forState:UIControlStateNormal];
//        _passWordButton.titleLabel.font = kFTEFontButton;
//        [_passWordButton addTarget:self action:@selector(passWordManagementAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _passWordButton;
//}
//
//-(XTButton *)uploadLogButton{
//    
//    if (_uploadLogButton == nil) {
//        
//        _uploadLogButton = [[XTButton alloc] initWithFrame:CGRectMake(15 / 2 + kScreenWidth / 2, CGRectGetMaxY(self.bankView.frame) + 20, kScreenWidth / 2 - 15 * 1.5, 40)];
//        _uploadLogButton.backgroundColor = kRGB(61, 144, 247);
//        _uploadLogButton.layer.cornerRadius = kFTECornerRadius;
//        [_uploadLogButton setTitle:@"上传日志" forState:UIControlStateNormal];
//        _uploadLogButton.titleLabel.font = kFTEFontButton;
//        [_uploadLogButton addTarget:self action:@selector(uploadLogAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _uploadLogButton;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
