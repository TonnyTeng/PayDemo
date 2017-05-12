//
//  BlueToothManager.h
//  JingXianPayDemo
//
//  Created by dengtao on 2017/5/12.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItronCommunicationManagerBase.h"
#import <CommonCrypto/CommonCryptor.h>
#import <DesUtil/DesUtil.h>
#import "TribleDes.h"
//#import "BluetoothZXBLib.h"
#import <CoreLocation/CoreLocation.h>
//#import "ZftQiposLib.h"
//#import "MPosController.h"

@interface BlueToothManager : NSObject<DeviceSearchListener,CommunicationCallBack>//,CSwiperStateChangedListener//ZftZXBDelegate,ZftQiPosDelegate,MPosDelegate
{
@public
    AppDelegate *appDelegate;
    NSString *Pan;
    NSMutableDictionary *fiftyDic;
    NSMutableArray *AccountArr;
    char *myRandom;
    int myRandomLen;
    NSString *CardNum;
    //    vcom_Result *vs;
    BOOL isRuiQianBao;
    NSString *rubikKSN;
}
//@property (nonatomic,strong)MPosController *posCtrl;
//@property (nonatomic,strong)BluetoothZXBLib *zft_qpos2;
//@property (nonatomic,strong)ZftQiposLib *zft_qpos;
@property (nonatomic, retain) ItronCommunicationManagerBase *cmManager;
@property (strong,nonatomic) NSArray * NoticeArr;
- (void)initialAishuaBlueTooth;
- (void)initialAishuaBlueTooth1;
- (void)initialZFT_ZXB_BT;
- (void)initialZFT_Qpos;
- (void)initialJFBBluetooth;
- (void)initialRubikBlueTooth;
//苹果自带获取经纬度
@property (nonatomic, retain) CLLocationManager* locationMgr;
@property (nonatomic, retain) CLGeocoder* clGeocoder;
@property(readonly, nonatomic) CLLocationCoordinate2D coordinate;

@property (strong, nonatomic) NSMutableArray *asBtTestSuccessArr;//存放爱创蓝牙测试成功的卡号数组
-(void)AishuaKeyBoardInputPwd:(id)sender;
@property (nonatomic,retain) UIAlertView *alertView;

@end
