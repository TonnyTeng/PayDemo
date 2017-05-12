//
//  JXPHomeController.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "JXPHomeController.h"
#import "JXPLoginController.h"

#define kTitle      @"title"
#define kColor      @"color"
#define kTag        @"tag"


#define kSpaceWidth   15

#define kTagRecharge     100//余额充值
#define kTagReimburse    101//信用卡还款
#define kTagTransfer     102//卡卡转账
#define kTagIllegal      103//违章代办
#define kTagPassword     104//密码管理
#define kTagPayCost      105//公共缴费
#define kTagFeedback     106//用户反馈
#define kTagAboutUs      107//关于我们
#define kTagSetPayment   108//设置结算方式
#define kTagCollection   109//我要收款
#define kTagNoCardPay    110//无卡支付
//#define kTagSetPayment   108

@interface JXPHomeController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) JXPLoginController        *loginVC;
@property (nonatomic, strong) UICollectionView          *collectionView;
@property (nonatomic, strong) NSMutableArray            *dataSource;
@property (nonatomic, strong) UIScrollView              *scrollView;

@end

@implementation JXPHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"指尖赚";
    [self showLeftButtonItemWithTitle:nil Sel:nil];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    CLIENT.user = [[JXPUserModel alloc] init];

    [self.view addSubview:self.collectionView];
    
    _dataSource = [[NSMutableArray alloc] init];
    
    [_dataSource addObject:@{kTitle:@"余额充值",    kColor:[UIColor blueColor],     kTag:@(kTagRecharge)}];
    [_dataSource addObject:@{kTitle:@"信用卡还款",   kColor:[UIColor orangeColor],   kTag:@(kTagReimburse)}];
    [_dataSource addObject:@{kTitle:@"卡卡转账",    kColor:[UIColor redColor],      kTag:@(kTagTransfer)}];
    [_dataSource addObject:@{kTitle:@"违章代办",    kColor:[UIColor cyanColor],     kTag:@(kTagIllegal)}];
    [_dataSource addObject:@{kTitle:@"密码管理",    kColor:[UIColor redColor],      kTag:@(kTagPassword)}];
    [_dataSource addObject:@{kTitle:@"固话|宽带",   kColor:[UIColor purpleColor],   kTag:@(kTagPayCost)}];
    [_dataSource addObject:@{kTitle:@"用户反馈",    kColor:[UIColor greenColor],    kTag:@(kTagFeedback)}];
    [_dataSource addObject:@{kTitle:@"关于我们",    kColor:[UIColor redColor],      kTag:@(kTagAboutUs)}];
    [_dataSource addObject:@{kTitle:@"结算方式",    kColor:[UIColor blueColor],     kTag:@(kTagSetPayment)}];
    [_dataSource addObject:@{kTitle:@"我要收款",    kColor:[UIColor blueColor],     kTag:@(kTagCollection)}];
    [_dataSource addObject:@{kTitle:@"无卡支付",    kColor:[UIColor redColor],      kTag:@(kTagNoCardPay)}];
    
    
    [self.collectionView reloadData];
    
    
}

#pragma mark - Event Action
- (void)showLoginVC{

    [self.navigationController pushViewController:self.loginVC animated:YES];
}

- (void)clickAction:(XTButton *)sender{

    if (CLIENT.user) {
        
//        [self showAlertView:[NSString stringWithFormat:@"%@,请先实名认证! 开发中...",sender.titleLabel.text]];
        
    }else{
        
        [self showLoginVC];
        return;
    }
    
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataSource.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *collectionCell = @"CollectionCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCell forIndexPath:indexPath];
   
    cell.selectedBackgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    [cell.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, cell.width, cell.height)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = kJXPFontNormal;
    titleLabel.textColor = kJXPColorMainWhite;
    
    [cell addSubview:titleLabel];
    
    NSDictionary *dic = _dataSource[indexPath.row];
    cell.backgroundColor = dic[kColor];
    titleLabel.text = CHECK_STRING(dic[kTitle]);
    
    return cell;
}


#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (CLIENT.user) {
        
    }else{
        
        [self showLoginVC];
        return;
    }
    
    id vc;
    NSDictionary *dic = _dataSource[indexPath.row];
    switch ([CHECK_STRING(dic[kTag]) integerValue]) {
        case kTagRecharge:
        {
        }
            break;
        case kTagReimburse:
        {
        }
            break;
        case kTagTransfer:
        {
        }
            break;
        case kTagIllegal:
        {
        }
            break;
        case kTagPassword:
        {
        }
            break;
        case kTagPayCost:
        {
            
        }
            break;
        case kTagFeedback:
        {
        }
            break;
        case kTagAboutUs:
        {
        }
            break;
        case kTagSetPayment:
        {
        }
            break;
        case kTagNoCardPay:
        {
        }
            break;
        case kTagCollection:
        {
        }
            break;
        default:
            break;
    }
    if (vc) {
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// cell点击变色
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark --UICollectionViewDelegateFlowLayout

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10,10,10,10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.collectionView.width-30)/2, (self.collectionView.width-30)/2 - 30);
}


#pragma mark - Setter/Getter

-(JXPLoginController *)loginVC{
    
    if (_loginVC == nil) {
        
        _loginVC = [[JXPLoginController alloc] init];
    }
    return _loginVC;
}


//方法一：
-(UICollectionView *)collectionView{

    if (_collectionView == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64 - 49) collectionViewLayout:layout];
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.autoresizesSubviews = NO;
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeadView"];
    }
    return _collectionView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
