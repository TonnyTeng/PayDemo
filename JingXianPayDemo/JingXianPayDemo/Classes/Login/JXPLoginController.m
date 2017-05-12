//
//  JXPLoginController.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "JXPLoginController.h"
#import "JXPTestController.h"

@interface JXPLoginController ()

@property (nonatomic, strong) UITextField *accountTF;
@property (nonatomic, strong) UITextField *passWordTF;

@end

@implementation JXPLoginController

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
//    [self showLeftButtonItemWithTitle:nil Sel:nil];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:self action:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self initWithUserInterface];
}

#pragma mark - InitUI
- (void)initWithUserInterface{

    self.navigationItem.title = @"登录";
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(backAction)];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(registerAction)];
    [self showRightButtonItemWithTitle:@"注册" Sel:@selector(registerAction)];
    
    
    UILabel *accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    accountLabel.textColor = kJXPColorTextSubBlack;
    accountLabel.textAlignment = NSTextAlignmentCenter;
    accountLabel.text = @"账号:";
    
    _accountTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 100, kScreenWidth - 100, 40)];
    _accountTF.placeholder = @"请输入手机号";
    _accountTF.keyboardType = UIKeyboardTypePhonePad;
    _accountTF.borderStyle = UITextBorderStyleRoundedRect;
    _accountTF.leftView = accountLabel;
    _accountTF.leftViewMode = UITextFieldViewModeAlways;
    _accountTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_accountTF];
    
    
    UILabel *passWordLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    passWordLabel.textColor = kJXPColorTextSubBlack;
    passWordLabel.textAlignment = NSTextAlignmentCenter;
    passWordLabel.text = @"密码:";
    
    
    _passWordTF = [[UITextField alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(_accountTF.frame) + 20, kScreenWidth - 100, 40)];
    _passWordTF.placeholder = @"请输入密码";
    _passWordTF.borderStyle = UITextBorderStyleRoundedRect;
    _passWordTF.leftView = passWordLabel;
    _passWordTF.secureTextEntry = YES;
    _passWordTF.leftViewMode = UITextFieldViewModeAlways;
    _passWordTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.view addSubview:_passWordTF];
    
    
    UIButton *forgotButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 130, CGRectGetMaxY(_passWordTF.frame) + 20, 80, 30)];
//    forgotButton.backgroundColor = kRGB(61, 144, 247);
    forgotButton.layer.cornerRadius = kJXPCornerRadius;
    forgotButton.layer.borderColor = kJXPColorTextSubBlack.CGColor;
    forgotButton.layer.borderWidth = 0.4;
    [forgotButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgotButton setTitleColor:kJXPColorTextSubBlack forState:UIControlStateNormal];
    forgotButton.titleLabel.font = kJXPFontNormal;
    [forgotButton addTarget:self action:@selector(forgotAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgotButton];
    
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(forgotButton.frame) + 20, kScreenWidth - 100, 40)];
    loginButton.backgroundColor = kRGB(61, 144, 247);
    loginButton.layer.cornerRadius = kJXPCornerRadius;
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginButton];

    UIButton *testButton = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(loginButton.frame) + 20, kScreenWidth - 100, 40)];
    testButton.backgroundColor = kJXPColorMainRed;
    testButton.layer.cornerRadius = kJXPCornerRadius;
    [testButton setTitle:@"测试刷卡器" forState:UIControlStateNormal];
    [testButton addTarget:self action:@selector(testAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testButton];
    

}

-(void)testAction{

    JXPTestController *vc = [[JXPTestController alloc] initWithNibName:@"JXPTestController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)forgotAction{

}

- (void)loginAction{
    
    CLIENT.user = [[JXPUserModel alloc] init];
    //检测填写信息有效性 密码6-20位 Aa-Zz0-9   账号：手机号
    //开启定位 获取位置信息
    kWeakObject(self);
    [self showLoading];
    [JXPRequestUtil  userActionLoginWithParams:nil success:^(NSDictionary *responseData) {
        [weakObject hideLoading];
        //登录成功 - 1.初始化设备 2.写入返回数据到用户信息3.极光推送4.实名认证判断4.绑定刷卡器信息5.保存账号到本地NSUserDefaults6.返回首页
         [weakObject showHomeVC];
        //失败：提示错误信息
    } failure:^(NSString *errorInfo) {
//        [weakObject showFailedWithMessage:errorInfo];
        [weakObject showHomeVC];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}

#pragma mark - Action

- (void)registerAction{
    
    CLIENT.user = nil;
}

- (void)backAction{

    if (([self.fromVC isEqualToString:@"JXPMoreController"] ||
         [self.fromVC isEqualToString:@"JXPPassWordController"])
        && !CLIENT.user) {
        
//        [self showFailedWithMessage:@"请登录!"];
        XTTabBarController *tabBarVC = (XTTabBarController *)[self topViewController];
        [self.navigationController popToRootViewControllerAnimated:NO];
        tabBarVC.selectedIndex = 0;
        
    }else{
    
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
