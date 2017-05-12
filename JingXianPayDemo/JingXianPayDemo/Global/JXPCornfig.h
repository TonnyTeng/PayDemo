//
//  JXPCornfig.h
//  JingXianPayDemo
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#ifndef JXPCornfig_h
#define JXPCornfig_h

#pragma mark - Config

#define CLIENT                          [JXPClient sharedInstance]
#define APPDELEGATE                     ((AppDelegate *)[[UIApplication sharedApplication] delegate])


#pragma mark - Network

#define kTimeoutSec                     45
#define kEncryptUseDESKey               @"e9dv3n1t"
#define kEncryptUseDESIv                @"ac3f6n2d"
#define DataStateKey                    @"status"
#define DataMsgKey                      @"message"

#define kAppStoreInfo                   @"https://itunes.apple.com/us/app/ba-dou-ban-du/id1195827718?mt=8&uo=4"

#define DEBUG                           1 // 仅仅在线下时打开(DEBUG = 1)，线上产品模式时请关闭(DEBUG = 0)

#if DEBUG

//测试服务器：
#define kApiUrlAPP              [NSString stringWithFormat:@"http://mobile.hsmpay.com:8000/proOneMobile/"]
#define PORTSTR                 [NSString stringWithFormat:@"forward/fcn.action"]

#else


#define kApiUrlAPP              [NSString stringWithFormat:@"http://mobile.hsmpay.com:8000/proOneMobile/"]
#define PORTSTR                 [NSString stringWithFormat:@"forward/fcn.action"]

#endif



#pragma mark - 第三方SDK

#define kAppKey_uMeng           @"585b553ccae7e70365001367"//友盟 App Master Secret : t55v41wonrmddmyxhux35mx22zxp18fu
//微信
#define kAppID_WeiXin           @"wx12f1de56cbe7e1ba"
#define kAppSecret_WeiXin       @"60397aab51e31f9d4c6f446c7cfa06a0"
//QQ
#define kAppID_QQ               @"1105925418" // 1105925418//LvxmmSX5EDfOAvKW //1104945920
#define kAppKey_QQ              @"LvxmmSX5EDfOAvKW" //  fe8Eu5n1lDPvE5PN

#pragma mark - size

#define iPhoneRemoveWidth           120
#define iPadRemoveWidth             180
#define iPhoneLeftSpace             90
#define iPadLeftSpace               120

#define kShufflingViewHeight        (150 + 64)
#define kTalbeViewCellBiggerHeight   75
#define kTableViewCellHeight         45
#define kTableViewHeaderHeight       10

#define kScreenSize    [UIScreen mainScreen].bounds.size
//#define kScreenWidth   [[UIScreen mainScreen] bounds].size.width
//#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
//#define kViewHeight    ScreenSize.height - NavHeight

#define kPortrait                   60
#define kPortraitSmall              50
#define kBorderWidth                0.4

//大神卡片
#define kLeftSpacing               (IPHONE6_OR_BIGGER ? 25 : 15)

#define kGodButtonWidth            (IPHONE6_OR_BIGGER ? (45 + 60) : (kScreenWidth / 3- 20))
#define kGodButtonHeight           (280 / 2)

#define kPicturePath(name)       [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",name]]
#define kImageNameString(name)   [UIImage imageWithContentsOfFile:kPicturePath(name)]

#pragma mark - App Color

#define kJXPColorHexString(s)     [UIColor colorHexString:s]

#define kJXPColorMainWhite        [UIColor colorHexString:@"ffffff"]
#define kJXPColorMainGreen        [UIColor colorHexString:@"00cf9e"]
#define kJXPColorLightYellow      [UIColor colorHexString:@"ffea76"]
#define kJXPColorDeepYellow       [UIColor colorHexString:@"fec631"]
#define kJXPColorMainBlue         [UIColor colorHexString:@"3eb6eb"]
#define kJXPColorMainRed          [UIColor colorHexString:@"fb5f49"]
#define kJXPColorMainPurple       [UIColor colorHexString:@"b052c4"] //紫色

#define kJXPColorBackGround       [UIColor colorHexString:@"f0f0f0"]
#define kJXPColorAreaModule       [UIColor colorHexString:@"fafafa"]
#define kJXPColorLine             [UIColor colorHexString:@"dcdcdc"]

#define kJXPColorTextBlack        [UIColor colorHexString:@"333333"]
#define kJXPColorTextSubBlack     [UIColor colorHexString:@"666666"]
#define kJXPColorTextGray         [UIColor colorHexString:@"999999"]//再次级文字、不可点/取消Icon等

#pragma mark - Font

#define kJXPFont(s)               [UIFont systemFontOfSize:s]
#define kJXPBFont(s)              [UIFont boldSystemFontOfSize:s]

#define kJXPFontButton            [UIFont boldSystemFontOfSize:18]   //菜单按钮、导航标题
#define kJXPFontNormal            [UIFont systemFontOfSize:15]       //分栏标题、正文
#define kJXPFontSmaller           [UIFont systemFontOfSize:14]       //订单标题、次级文字
#define kJXPFontSubSmaller        [UIFont systemFontOfSize:12]       //说明文字、再次级文字
#define kJXPFontMinSmaller        [UIFont systemFontOfSize:10]       //特别次级文字

#pragma mark - other

#define UILABEL_LINE_SPACE       6//行间距
#define kJXPCornerRadius          (IPHONE6_OR_BIGGER ? (10) : (5))
#define kJXPAlpha                 0.4

#pragma mark - TEXT

#define kGDLoadingText                 @"加载中"
#define kGDFailedPopText               @"请检查网络"
#define kGDNetworkFailedText           @"数据获取失败，请检查一下，网络是否通畅？"

#pragma mark -                         Notification

#define NOTI_USER_DIDLOGIN             @"Notification_User_DidLogin"
#define NOTI_USER_DIDLOGOUT            @"Notification_User_DidLogout"




#endif /* JXPCornfig_h */
