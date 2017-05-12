//
//  BlueToothManager.m
//  JingXianPayDemo
//
//  Created by dengtao on 2017/5/12.
//  Copyright © 2017年 JingXian. All rights reserved.
//

#import "BlueToothManager.h"
#define isConectToDevice [BluetoothZXBLib isconnect_21]

@implementation BlueToothManager


#pragma mark --DeviceSearchListener--

- (id)init
{
    self = [super init];
    if (self) {
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        //爱创蓝牙
        NSLog(@"###initAishua");
        myRandom = "12345678";
        myRandomLen = 0;
//        [self.posCtrl scanBtDevice: 6];
        NSLog(@"scanlala1");
        
//        posCtrl = [MPosController sharedInstance];
//        posCtrl.delegate = self;
        
        self.cmManager = [ItronCommunicationManagerBase getInstance];
        [self.cmManager setDebug:1];
        self.cmManager.communication = self;
        isRuiQianBao = NO;
        [self initSDK];
        [self initSDKq];
    }
    return self;
}


- (void)discoverOneDevice:(CBPeripheral *)peripheral
{
    //    [appDelegate.devKeys addObject:peripheral.name];
}
- (void)discoverBLeDevice:(NSDictionary *)uuidAndName
{
    NSString *name = [uuidAndName objectForKey:[uuidAndName objectForKey:@"mainKey"]];
    [appDelegate.devKeys addObject:name];
    [appDelegate.asMutableDic setObject:[uuidAndName objectForKey:@"mainKey"] forKey:name];
    NSLog(@"###asMutableDic == %@",appDelegate.asMutableDic);
    NSLog(@"== devKeys == %@",appDelegate.devKeys);
    //    chooseDeviceViewController *chooceVC = [[chooseDeviceViewController alloc]init];
    //    [chooceVC.tableview reloadData];
}
- (void)discoverComplete
{
    NSLog(@"-----------------搜索结束-----------------");
    
}


char bout11[5096];
int  boutlen11;
char* HexToBin11(char* hin)
{
    int i;
    char highbyte,lowbyte;
    int len= (int)strlen(hin);
    for (i=0;i<len/2;i++)
    {
        if (hin[i*2]>='0'&&hin[i*2]<='9')
            highbyte=hin[i*2]-'0';
        if (hin[i*2]>='A'&&hin[i*2]<='F')
            highbyte=hin[i*2]-'A'+10;
        if (hin[i*2]>='a'&&hin[i*2]<='f')
            highbyte=hin[i*2]-'a'+10;
        
        if (hin[i*2+1]>='0'&&hin[i*2+1]<='9')
            lowbyte=hin[i*2+1]-'0';
        if (hin[i*2+1]>='A'&&hin[i*2+1]<='F')
            lowbyte=hin[i*2+1]-'A'+10;
        if (hin[i*2+1]>='a'&&hin[i*2+1]<='f')
            lowbyte=hin[i*2+1]-'a'+10;
        
        bout11[i]=(highbyte<<4)|(lowbyte);
    }
    boutlen11=len/2;
    return bout11;
}

//itron
- (NSString*)HexValue:(char*)bin Len:(int)binlen{
    char *hs;
    hs = BinToHex99(bin,0,binlen);//, <#int off#>, <#int len#>)
    hs[binlen*2]=0;
    NSString* str =[[NSString alloc] initWithFormat:@"%s",hs];
    return str;
}
char hout99[5096];
char* BinToHex99(char* bin,int off,int len)
{
    int i;
    //	hout=(char*)hout;
    for (i=0;i<len;i++)
    {
        sprintf((char*)hout99+i*2,"%02x",*(unsigned char*)((char*)bin+i+off));
    }
    hout99[len*2]=0;
    return hout99;
}
//@"313332"  转换成 { 0x31,0x33,0x32}类型的数据
-(NSData*) hexToBytes:(NSString *) string {
    NSMutableData *data = [NSMutableData data];
    int idx;
    for (idx = 0; idx+2 <= string.length; idx+=2) {
        NSRange range = NSMakeRange(idx, 2);
        NSString* hexStr = [string substringWithRange:range];
        NSScanner* scanner = [NSScanner scannerWithString:hexStr];
        unsigned int intValue;
        [scanner scanHexInt:&intValue];
        [data appendBytes:&intValue length:1];
    }
    return data;
}
//DES解密
-(NSString *) DecryptStr:(Byte *)encryptBytes key:(Byte *)keybytes
{
    Byte buffer[1024];
    size_t numBytesDecrypted = 0;
    
    CCCryptorStatus  DecryptStatus;
    
    DecryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithm3DES,
                            kCCOptionPKCS7Padding | kCCOptionECBMode,
                            keybytes, 24,
                            nil,
                            encryptBytes, 16,
                            buffer, 1024,
                            &numBytesDecrypted);
    NSLog(@"pan:%@",Pan);
    NSData *KeyData = [self hexToBytes:Pan];
    Byte *keybyte = (Byte *)[KeyData bytes];
    Byte mimabyte[8];
    for (int i=0; i<8; i++) {
        mimabyte[i]=keybyte[i]^buffer[i];
    }
    NSString *hexStr=@"";
    for(int i=0;i<[KeyData length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",mimabyte[i]&0xff];///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    //    NSLog(@"密码明文,,,%s",mimabyte);
    //    NSString *Byteresult = [self parseByteArray2HexString: mimabyte];
    //    NSLog(@"密码明文%@",Byteresult);
    return hexStr;
}
////byte数组 转换成NSString
//-(NSString *) parseByteArray2HexString:(Byte[]) bytes
//{
//    NSMutableString *hexStr = [[NSMutableString alloc]init];
//    int i = 0;
//    if(bytes)
//    {
//        while (bytes[i] != '\0')
//        {
//            NSString *hexByte = [NSString stringWithFormat:@"%x",bytes[i] & 0xff];///16进制数
//            if([hexByte length]==1)
//                [hexStr appendFormat:@"0%@", hexByte];
//            else
//                [hexStr appendFormat:@"%@", hexByte];
//
//            i++;
//        }
//    }
//    return hexStr;
//}

#pragma mark ---AishuaBluetooth---

- (void)initialJFBBluetooth{
    [self.cmManager closeDevice];
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化中..."];
    if ([Tools isEmptyWithString:appDelegate.jfbBluetoothUUID]) {
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化蓝牙设备失败！"];
    }else{
        int ret = [self.cmManager openDevice:appDelegate.jfbBluetoothUUID cbDelegate:self timeout:15*1000];
        NSLog(@"正在打开");
        if (ret == 0) {
            if ([appDelegate.jfbBluetoothName hasPrefix:@"A21B"]) {
                [self startAishuaBt];
            }else if ([appDelegate.jfbBluetoothName hasPrefix:@"AC"]){
                [self startAishuaBt1];
            }else{
                [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化蓝牙设备失败！"];
                NSLog(@"蓝牙连接失败(1)");
            }
        }else{
            [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化蓝牙设备失败！"];
            NSLog(@"蓝牙连接失败(2)");
        }
    }
}
- (void)initialAishuaBlueTooth
{
    [self.cmManager closeDevice];
    NSLog(@"testype::%@ - %@,%@",appDelegate.testype,appDelegate.blueToothDeviceUUID,appDelegate.blueToothDeviceUUID2);
    if (![appDelegate.blueToothDeviceUUID isEqualToString:appDelegate.blueToothDeviceUUID2] && ![appDelegate.testype isEqualToString:@"bindswiper"] && appDelegate.isLogin) {
        NSLog(@"请重新绑定刷卡器");
        sleep(1.5);
        [[KGModal sharedInstance] hideAnimated:YES];
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请重新设置蓝牙刷卡器！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        //        [alert show];
        return;
    }
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化中..."];
    if ([Tools isEmptyWithString:appDelegate.blueToothDeviceUUID]) {
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化蓝牙设备失败！"];
    }else{
        int ret = [self.cmManager openDevice:appDelegate.blueToothDeviceUUID cbDelegate:self timeout:15*1000];
        NSLog(@"正在打开");
        if (ret == 0) {
            if (appDelegate.isGetType == YES) {
                [self.cmManager setDeviceKind:6];
                [self.cmManager Request_GetKsn];     //签到方法
                //                appDelegate.isGetType = NO;
            }else{
                
                //gld-log
                [self startAishuaBt];
            }
        }else{
            [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化蓝牙设备失败！"];
            NSLog(@"蓝牙连接失败");
        }
    }
}

#pragma mark 魔方手刷
///posCtrl
- (void)initialRubikBlueTooth{
    
    NSLog(@"in initialRubikBlueTooth");
    if (appDelegate.vcType != RUBIKSWIPER) {
        [self.posCtrl scanBtDevice: 6];
        NSLog(@"scanlala2");
        
    }
    
    [self.posCtrl disconnectBtDevice];
    NSLog(@"testype::%@ - %@,%@",appDelegate.testype,appDelegate.blueToothDeviceUUID,appDelegate.blueToothDeviceUUID2);
    if (![appDelegate.blueToothDeviceUUID isEqualToString:appDelegate.blueToothDeviceUUID2] && ![appDelegate.testype isEqualToString:@"bindswiper"] && appDelegate.isLogin) {
        NSLog(@"请重新绑定刷卡器");
        sleep(1.5);
        [[KGModal sharedInstance] hideAnimated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请重新设置蓝牙刷卡器！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化中..."];
    if ([Tools isEmptyWithString:appDelegate.blueToothDeviceUUID]) {
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化蓝牙设备失败！"];
    }else{
        
        [self.posCtrl connectBtDevice:appDelegate.blueToothDeviceUUID];
        //        [self.posCtrl connectBtDevice:@"3CD4CA82-6F21-1E03-A525-5FEB745B92AC"];
    }
}

- (void)didFoundBtDevice:(NSString *)btDevice{
    
    if (appDelegate.vcType != RUBIKSWIPER) {
        [self.posCtrl connectBtDevice:appDelegate.blueToothDeviceUUID];
    }
    
    NSRange rrr = [btDevice rangeOfString: @","];
    if (rrr.length > 0) {
        NSString *name = [btDevice substringToIndex: rrr.location];
        NSString *uuid = [btDevice substringFromIndex: rrr.location + 1];
        [appDelegate.devKeys addObject:name];
        [appDelegate.asMutableDic setObject:uuid forKey:name];
    }
    
}
/// 成功连接到一个设备回调
/**
 * @param  devName 设备标识(音频参数为空)
 * @return 无
 */
-(void) didConnected:(NSString *)devName{
    
    NSLog(@"设备连接ok！");
    //    [self.posCtrl setFactoryCode: 0];   // 默认为0,具体ID分配请与我们联系
    
    //    [self.posCtrl getKsn];
    [self.posCtrl readPosInfoEx];
    
}

-(void) didReadPosInfoResp:(NSString *)ksn status: (MFEU_MSR_DEVSTAT)status battery: (MFEU_MSR_BATTERY)battery app_ver: (NSString *)app_ver data_ver: (NSString *)data_ver custom_info: (NSString *)custom_info{
    
    NSLog(@"ksn%@",ksn);
    rubikKSN = ksn;
    [self.posCtrl cardRead: 0 transType: MF_FUNC_SALE timeOutSecond: 15 isEncrypt: NO showMsg: nil];
}

/*! 刷卡数据回调
 * @param isICCard          判断是否IC刷卡还是磁道刷卡
 * @param maskedPAN         主账号
 * @param expiryDate        有效期
 * @param serviceCode       服务代码（仅针对磁条卡）
 * @param track2Size        二磁道长度
 * @param track3Size        三磁道长度（仅针对磁条卡）
 * @param track2data        二磁道数据
 * @param track3data        三磁道数据（仅针对磁条卡）
 * @param randomNumber      随机数数据
 * @param serialNum         序列号（仅针对IC卡）
 * @param data55            ic刷卡 55域数据（仅针对IC卡）
 * @param otherInfo         保留，用以扩充其他字段
 \return 无
 */
- (void)didDecodeCompleted:(BOOL) isICCard
                 maskedPAN:(NSString *)maskedPAN
                expiryDate:(NSString *)expiryDate
               serviceCode:(NSString *)serviceCode
                track2Size:(int)track2Size
                track3Size:(int)track3Size
                track2Data:(NSString *)track2Data
                track3Data:(NSString *)track3Data
              randomNumber:(NSString *)randomNumber
                 serialNum:(NSString *)serialNum
                   iccData:(NSString *)data55
                 otherInfo:(NSDictionary *)otherInfo{
    
    NSLog(@"%d",isICCard);
    NSLog(@"魔方刷卡器刷卡数据回调");
    NSLog(@"%@",maskedPAN);
    NSLog(@"%@",expiryDate);
    NSLog(@"%@",serviceCode);
    NSLog(@"hhssw%@",track2Data);
    NSLog(@"%@",track3Data);
    NSLog(@"%@",randomNumber);
    NSLog(@"%@",serialNum);
    NSLog(@"%@",data55);
    NSLog(@"%d,%d",track2Size,track3Size);
    
    if (!appDelegate.isTestSwipCard) {
        [[KGModal sharedInstance] hideAnimated:YES];
    }
    NSMutableString *starTrackStr = [self makeStarTrackWithStr:maskedPAN];
    [appDelegate.asTestSuccessArr addObject:starTrackStr];
    [appDelegate.testSuccessArr addObject:starTrackStr];
    NSMutableDictionary *aiShuaDic = [[NSMutableDictionary alloc] initWithCapacity:14];
    if (isICCard == YES) {
        
        NSLog(@"************ 插卡模式 ************");
        NSMutableDictionary *fiftyFiveDic = [[NSMutableDictionary alloc] initWithCapacity:10];
        NSString *fiftyFiveValue = data55;
        fiftyFiveValue = [fiftyFiveValue uppercaseString];
        [fiftyFiveDic setObject:fiftyFiveValue forKey:@"bit55"];
        if (![Tools isEmptyWithStr:expiryDate]) {
            [fiftyFiveDic setObject:expiryDate forKey:@"5f24"];
        }
        if (![Tools isEmptyWithStr:serialNum]) {
            [fiftyFiveDic setObject:serialNum forKey:@"5f34"];
        }
        NSDictionary *temDic = (NSDictionary *)fiftyFiveDic;
        NSString *fiftyFiveStr = [temDic JSONString];
        [aiShuaDic setObject:rubikKSN forKey:@"deviceId"];//设备id - ksn
        [aiShuaDic setObject:INSERTCARD forKey:TYPEMARK];
        [aiShuaDic setObject:maskedPAN forKey:CARDNUM];
        [aiShuaDic setObject:starTrackStr forKey:STARCARDNUM];
        [aiShuaDic setObject:track2Data forKey:SECONDTRACKKEY];
        [aiShuaDic setObject:@"" forKey:THIRDTRACKKEY];
        [aiShuaDic setObject:fiftyFiveStr forKey:FIFTYFIVEKEY];
        appDelegate.NL_cardInfoDic = aiShuaDic;
        
    }else{
        NSLog(@"************ 刷卡模式 ************");
        [aiShuaDic setObject:rubikKSN forKey:@"deviceId"];//设备id - ksn
        [aiShuaDic setObject:ICSWIPMARK forKey:TYPEMARK];
        [aiShuaDic setObject:maskedPAN forKey:CARDNUM];
        [aiShuaDic setObject:starTrackStr forKey:STARCARDNUM];
        [aiShuaDic setObject:track2Data forKey:SECONDTRACKKEY];
        if (track3Data) {
            [aiShuaDic setObject:track3Data forKey:THIRDTRACKKEY];
        }else{
            [aiShuaDic setObject:@"" forKey:THIRDTRACKKEY];
        }
        [aiShuaDic setObject:@"" forKey:FIFTYFIVEKEY];
    }
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //        [self sendASnoticeWithDic:aiShuaDic];
    NSLog(@"** aiShuaDic **%@",aiShuaDic);
    [self.posCtrl stopScan];
    appDelegate.NL_cardInfoDic = aiShuaDic;
    [appDelegate sendNLBtNoticeWithDic:aiShuaDic];//
    
}

- (void)didWaitingForCardSwipe{
    
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"请在蓝牙设备上刷卡/插卡"];
    NSLog(@"didWaitingForCardSwipe");
}

- (void)didReadCardCancel{
    
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"刷卡取消"];
    NSLog(@"didReadCardCancel");
}
//13552673580
- (void)didReadCardFail:(MFEU_MSR_OPENCARD_RESP)resp{
    
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"刷卡失败,请重试"];
    NSLog(@"刷卡失败：%u",resp);
}

- (void)didDetectIcc{
    
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"银行卡读取中,请勿拔卡!"];
}
- (void)didError:(NSInteger)errorCode andMessage:(NSString *)errorMessage{
    
    [self.posCtrl cardRead: 0 transType: MF_FUNC_SALE timeOutSecond: 15 isEncrypt: NO showMsg: nil];
}
#pragma mark 支付通设备
- (void)initialZFT_Qpos{
    NSLog(@"inside=======");
    //    [zft_qpos2 disconnectionDevice];
    NSLog(@"uuid:%@\nuuid2:%@",appDelegate.blueToothDeviceUUID,appDelegate.blueToothDeviceUUID2);
    if (![appDelegate.blueToothDeviceUUID isEqualToString:appDelegate.blueToothDeviceUUID2] && appDelegate.isLogin) {
        NSLog(@"请重新绑定刷卡器");
        sleep(1.5);
        [[KGModal sharedInstance] hideAnimated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请重新设置蓝牙刷卡器！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
        return;
    }
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化中..."];
    if ([Tools isEmptyWithString:appDelegate.blueToothDeviceUUID]) {
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化蓝牙设备失败！"];
    }else{
        [self.zft_qpos connectDevice:appDelegate.blueToothDeviceUUID];
    }
}
- (void)initialZFT_ZXB_BT{
    
    //    [zft_qpos2 disconnectionDevice];
    NSLog(@"uuid:%@\nuuid2:%@",appDelegate.blueToothDeviceUUID,appDelegate.blueToothDeviceUUID2);
    if (![appDelegate.blueToothDeviceUUID isEqualToString:appDelegate.blueToothDeviceUUID2] && appDelegate.isLogin) {
        NSLog(@"请重新绑定刷卡器");
        sleep(1.5);
        [[KGModal sharedInstance] hideAnimated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请重新设置蓝牙刷卡器！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
        return;
    }
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化中..."];
    if ([Tools isEmptyWithString:appDelegate.blueToothDeviceUUID]) {
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化蓝牙设备失败！"];
    }else{
        [self.zft_qpos2 connectDevice:appDelegate.blueToothDeviceUUID];
    }
}
-(BluetoothZXBLib *)zft_qpos2//zhangxinbao
{
    if(!zft_qpos2)
    {
        // 获得sdk单例
        zft_qpos2 = [BluetoothZXBLib getInstance];
    }
    return zft_qpos2;
}
-(ZftQiposLib *)zft_qpos//Qpos
{
    if(!zft_qpos)
    {
        // 获得sdk单例
        zft_qpos = [ZftQiposLib getInstance];
    }
    return zft_qpos;
}

- (void)initSDK
{
    // 首先获得sdk单例,然后设置监听
    [self.zft_qpos2 setLister:self];
    [BluetoothZXBLib getInstance];
    //    [ZftZXBS getInstance];
}
- (void)initSDKq
{
    // 首先获得sdk单例,然后设置监听
    [self.zft_qpos setLister:self];
    [ZftQiposLib getInstance];
    //    [ZftZXBS getInstance];
}

- (void)Plugin{
    
    
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"请在蓝牙设备上刷卡/插卡"];
    if (appDelegate.isTrade == NO) {
        //        [self.zft_qpos2 openCardReader:90 andScheme:@"00"];
        [self.zft_qpos2 doGetTerminalID];
    }
}
- (void)GetTerminal:(NSString *)devVersion andFirmVersion:(NSString *)firmVersion andDevId:(NSString *)devId andAdc:(NSString *)adc{
    
    appDelegate.deviceId = devId;
    [self.zft_qpos2 openCardReader:90 andScheme:@"00"];
}

- (void)QposPlugin{
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"请在蓝牙设备上刷卡/插卡"];
    
    [self getTerminalID];
    
    //    if (appDelegate.isGetType) {
    //        [self getTerminalID];
    //    }else{
    //        [self trade];
    //    }
    
    //    [self.zft_qpos doTradeWithAmount:appDelegate.accountStr andMode:2 andICType:@"02" andTimesOut:60];
}
- (void)getTerminalID{
    
    
    [self.zft_qpos doGetTerminalID];
    [self performSelector:@selector(terminalID2) withObject:nil afterDelay:2];
}

- (void)terminalID2{
    [self.zft_qpos terminalID];
    
}
//交易
- (void)trade{
    
    NSInteger tradeNum;
    tradeNum = [self.zft_qpos doTradeWithAmount:appDelegate.accountStr andMode:2 andICType:@"02" andTimesOut:60];
    NSLog(@"tradeNum: %d",tradeNum);//1:发送成功; 0:发送失败 ; -1:设备未连接
    if (isConectToDevice) {
        NSLog(@"已连接");
    }else{
        NSLog(@"没连接");
    }
}
-(void)QposGetTerminalID:(NSString *)terminalId{
    
    appDelegate.deviceId = terminalId;
    [self.zft_qpos doTradeWithAmount:appDelegate.accountStr andMode:2 andICType:@"02" andTimesOut:60];
}
- (void)PlugOut{
    
    [self.zft_qpos2 giveup];
}

- (void)QposPlugOut{
    
    NSLog(@" QposPlugOut");
}

- (void)CancleTrade:(NSString *)msg{
    
    NSLog(@"交易取消:%@",msg);
}
- (void)QposCancleTrade:(NSString*)msg{
    
    NSLog(@"交易取消：%@",msg);
}

-(void)GetopenCardReader:(NSString *)openStr{
    NSLog(@"liminnn  openStr:%@",openStr);
    if([openStr isEqualToString:@"00"])
    {
        [[BluetoothZXBLib getInstance] doGetCardTrack];
        
    }
    else if([openStr isEqualToString:@"01"])
    {
        [[BluetoothZXBLib getInstance] doGetCardTrack];
        
    }
    else if([openStr isEqualToString:@"05"])
    {
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"读卡中...(-10)"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.zft_qpos2 doGetICCard:@"1" andTrandeTime:appDelegate.collectModel.orderTime andTimeOut:60];
        });
    }
    else if([openStr isEqualToString:@"02"])
    {
        if (isConectToDevice) {
            [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"操作失败，请再次刷卡/插卡"];
            [self performSelector:@selector(repeatOpen) withObject:nil afterDelay:2];
        }
    }
    //    else if ([openStr isEqualToString:@"04"]){
    //        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"操作失败，请再次刷卡/插卡"];
    //        [self performSelector:@selector(repeatOpen) withObject:nil afterDelay:2];
    //    }
}

/**
 *  刷磁条卡的回调
 *
 *  主账号  account
 *  随机数  random
 *  2 3磁  track
 */
- (void)SwipCardAccount:(NSString *)account andRandom:(NSString *)random andTrack2:(NSString *)track2 andTrack3:(NSString *)track3{
    if (!appDelegate.isTestSwipCard) {
        [[KGModal sharedInstance] hideAnimated:YES];
    }
    if (appDelegate.isBindSwiper) {
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"测试成功(-1)"];
        [self.zft_qpos2 stopScan];
    }else{
        //        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"测试成功(-1)"];
        [self.zft_qpos2 stopScan];
    }
    
    [self StatusInText:[NSString stringWithFormat:@"主账号:%@\n随机数:%@\n2磁道:%@\n3磁道:%@",account,random,track2,track3]];
    NSString *SECONDTRACKKEY01 = [track2 substringWithRange:NSMakeRange([track2 length]-18, 16)];
    NSLog(@"SECONDTRACKKEY01:%@",SECONDTRACKKEY01);
    //    NSString* decryptStr = [DesUtil tripleDesDecrypt:SECONDTRACKKEY01 key:@"1234ABCD1234ABCD1234ABCD1234ABCD"];
    //    NSLog(@"liyang :strsecond:%@",decryptStr);
    NSString *SECONDECRYPT = [track2 stringByReplacingCharactersInRange:NSMakeRange([track2 length]-18, 18) withString:SECONDTRACKKEY01];
    
    NSString *SECONDECRYPT2 = [SECONDECRYPT stringByReplacingOccurrencesOfString:@"D" withString:@"d"];
    //解密后的二磁
    NSLog(@"liyang :SECONDECRYPT:%@",SECONDECRYPT2);
    
    NSMutableString *starTrackStr = [self makeStarTrackWithStr:account];//主账号
    NSMutableDictionary *aiShuaDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    [aiShuaDic setObject:SWIPCARD forKey:TYPEMARK];
    [aiShuaDic setObject:account forKey:CARDNUM];
    [aiShuaDic setObject:starTrackStr forKey:STARCARDNUM];
    [aiShuaDic setObject:SECONDECRYPT2 forKey:SECONDTRACKKEY];
    [aiShuaDic setObject:@"" forKey:THIRDTRACKKEY];
    [aiShuaDic setObject:@"" forKey:FIFTYFIVEKEY];
    NSLog(@"liyang ceshi shuaka:%@",aiShuaDic);
    [appDelegate sendNLBtNoticeWithDic:aiShuaDic];
}
- (void)QposSwipCardTrack2:(NSString *)cardTrack2 andCardTrack3Str:(NSString *)cardTrack3 andPinStr:(NSString *)pin{
    if (!appDelegate.isTestSwipCard) {
        [[KGModal sharedInstance] hideAnimated:YES];
    }
    if (appDelegate.isBindSwiper) {
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"测试成功(-1)"];
        [self.zft_qpos2 stopScan];
    }else{
        //        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"测试成功(-1)"];
        [self.zft_qpos2 stopScan];
    }
    
    NSLog(@"\n刷磁条卡的回调");
    NSLog(@"\n二磁：%@\n三磁：%@\npin：%@\n",cardTrack2,cardTrack3,pin);
    NSString *SECONDTRACKKEY01 = [cardTrack2 substringWithRange:NSMakeRange([cardTrack2 length]-18, 16)];
    NSLog(@"SECONDTRACKKEY01:%@",SECONDTRACKKEY01);
    NSString* decryptStr = [DesUtil tripleDesDecrypt:SECONDTRACKKEY01 key:@"1234ABCD1234ABCD1234ABCD1234ABCD"];//磁道密钥
    NSLog(@"liyang :strsecond:%@",decryptStr);
    NSString *SECONDECRYPT = [cardTrack2 stringByReplacingCharactersInRange:NSMakeRange([cardTrack2 length]-18, 16) withString:decryptStr];
    appDelegate.zft_cardPin = pin;
    NSLog(@"%@",appDelegate.zft_cardPin);
    NSString *littleCardNum = [cardTrack2 substringWithRange:NSMakeRange(0, 4)];
    NSString *starCardNum = [littleCardNum stringByAppendingString:@"**************"];
    
    NSString *SECONDECRYPT2 = [SECONDECRYPT stringByReplacingOccurrencesOfString:@"D" withString:@"d"];
    SECONDECRYPT2 = [SECONDECRYPT2 stringByReplacingOccurrencesOfString:@"F" withString:@""];
    SECONDECRYPT2 = [SECONDECRYPT2 stringByReplacingOccurrencesOfString:@"f" withString:@""];
    //解密后的二磁
    NSLog(@"gld :SECONDECRYPT:%@",SECONDECRYPT2);
    
    NSMutableDictionary *aiShuaDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    [aiShuaDic setObject:SWIPCARD forKey:TYPEMARK];
    
    //卡号和带星卡号都是假的。。。
    [aiShuaDic setObject:@"" forKey:CARDNUM];
    [aiShuaDic setObject:starCardNum forKey:STARCARDNUM];
    
    //上送的二磁道信息是直接取到的密文，未解密（解密后的是 SECONDECRYPT2）
    [aiShuaDic setObject:cardTrack2 forKey:SECONDTRACKKEY];
    
    //上送的三磁道信息是直接取到的密文，未解密（解密后的是 SECONDECRYPT2）
    [aiShuaDic setObject:@"" forKey:THIRDTRACKKEY];
    
    [aiShuaDic setObject:@"" forKey:FIFTYFIVEKEY];
    NSLog(@"aiShuaDic:%@",aiShuaDic);
    //    [self sendASnoticeWithDic:aiShuaDic];
    [appDelegate sendNLBtNoticeWithDic:aiShuaDic];
}

/**
 执行结果  result
 终端交易时间  time
 随机数 random
 主账号   account
 IC卡序列号  sqn
 卡有效期  validityDate
 等效二磁数据密文  track
 55域数据 message55
 */
- (void)GetICCardResult:(NSString *)result andTime:(NSString *)time andRandom:(NSString *)random andAccount:(NSString *)account andSqn:(NSString *)sqn andValidityDate:(NSString *)validityDate andTrack:(NSString *)track andMessage:(NSString *)message55{
    
    NSLog(@"fuck oc again");
    if (!appDelegate.isTestSwipCard) {
        [[KGModal sharedInstance] hideAnimated:YES];
    }
    
    [self StatusInText:[NSString stringWithFormat:@"执行结果:%@\n终端交易时间:%@\n随机数%@\n主账号%@\n卡序列号%@\n卡有效期%@\n有效二磁%@\n55域数据:%@",result,time,random,account,sqn,validityDate,track,message55]];
    if (appDelegate.isBindSwiper) {
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"测试成功(-1)"];
        [self.zft_qpos2 stopScan];
    }else{
        //        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"测试成功(-1)"];
        [self.zft_qpos2 stopScan];
    }
    
    NSMutableDictionary *aiShuaDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    NSLog(@"未处理的磁道信息：%@",track);
    
    if (track.length == 0) {
        
        NSLog(@"没取到二磁");
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"读取失败，请重试(-10)"];
        return;
    }
    NSString *SECONDTRACKKEY01 = [track substringWithRange:NSMakeRange([track length]-18, 16)];
    NSLog(@"待解密的二磁数据:%@",SECONDTRACKKEY01);
    
    NSString* decryptStr = [DesUtil tripleDesDecrypt:SECONDTRACKKEY01 key:@"17E68722C9D0DF31EDAEFE4E4DED4525"];
    NSLog(@"解密后的二磁:%@",decryptStr);
    NSString *SECONDECRYPT = [track stringByReplacingCharactersInRange:NSMakeRange([track length]-18, 18) withString:decryptStr];
    NSString *SECONDECRYPT2 = [SECONDECRYPT stringByReplacingOccurrencesOfString:@"D" withString:@"d"];
    
    NSArray *strarray = [SECONDECRYPT2 componentsSeparatedByString:@"d"];
    NSString *cardnumm = [strarray objectAtIndex:0];
    NSString *account1;
    account1 = [account stringByReplacingOccurrencesOfString:@"f" withString:@""];
    account1 = [account stringByReplacingOccurrencesOfString:@"F" withString:@""];
    NSMutableString *starTrackStr = [self makeStarTrackWithStr:account1];//主账号xxxxx
    NSMutableDictionary *fiftyFiveDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    NSString *fiftyFiveValue = message55;
    fiftyFiveValue = [fiftyFiveValue uppercaseString];
    [fiftyFiveDic setObject:fiftyFiveValue forKey:@"bit55"];
    
    [fiftyFiveDic setObject:validityDate forKey:@"5f24"];
    [fiftyFiveDic setObject:sqn forKey:@"5f34"];
    
    NSDictionary *temDic = (NSDictionary *)fiftyFiveDic;
    NSString *fiftyFiveStr = [temDic JSONString];
    NSLog(@"###fiftyFiveStr == %@",fiftyFiveStr);
    
    [aiShuaDic setObject:INSERTCARD forKey:TYPEMARK];
    [aiShuaDic setObject:account forKey:CARDNUM];
    [aiShuaDic setObject:starTrackStr forKey:STARCARDNUM];
    [aiShuaDic setObject:SECONDECRYPT2 forKey:SECONDTRACKKEY];
    [aiShuaDic setObject:@"" forKey:THIRDTRACKKEY];
    [aiShuaDic setObject:fiftyFiveStr forKey:FIFTYFIVEKEY];
    NSLog(@"aiShuaDic:%@",aiShuaDic);
    [appDelegate sendNLBtNoticeWithDic:aiShuaDic];
}

- (void)QposGetIC55Data:(NSString *)data55 andICNum:(NSString *)cardNum andCardSqn:(NSString *)sqn andCardDataAsTrack2:(NSString *)dataAsTrack2 andPinStr:(NSString *)pin adnValidityDate:(NSString *)validityDate{
    
    NSLog(@"插入IC卡后的回调\n");
    NSLog(@"\n55域：%@  \n卡号：%@  \nsqn：%@\n  二磁：%@\n   pin：%@\n  卡有效期：%@\n",data55,cardNum,sqn,dataAsTrack2,pin,validityDate);
    if (!appDelegate.isTestSwipCard) {
        [[KGModal sharedInstance] hideAnimated:YES];
    }
    
    if (appDelegate.isBindSwiper) {
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"测试成功(-1)"];
        [self.zft_qpos stopScan];
    }else{
        //        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"测试成功(-2)"];
        [self.zft_qpos stopScan];
    }
    appDelegate.zft_cardPin = pin;
    NSMutableDictionary *aiShuaDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    
    //解密二磁
    NSString *SECONDTRACKKEY01 = [dataAsTrack2 substringWithRange:NSMakeRange([dataAsTrack2 length]-18, 16)];
    NSLog(@"SECONDTRACKKEY01:%@",SECONDTRACKKEY01);
    NSString* decryptStr = [DesUtil tripleDesDecrypt:SECONDTRACKKEY01 key:@"1234ABCD1234ABCD1234ABCD1234ABCD"];
    NSLog(@"liyang :strsecond:%@",decryptStr);
    NSString *SECONDECRYPT = [dataAsTrack2 stringByReplacingCharactersInRange:NSMakeRange([dataAsTrack2 length]-18, 18) withString:decryptStr];
    
    NSString *SECONDECRYPT2 = [SECONDECRYPT stringByReplacingOccurrencesOfString:@"D" withString:@"d"];
    SECONDECRYPT2 = [SECONDECRYPT2 stringByReplacingOccurrencesOfString:@"F" withString:@""];
    SECONDECRYPT2 = [SECONDECRYPT2 stringByReplacingOccurrencesOfString:@"f" withString:@""];
    //解密后的二磁
    NSLog(@"gld :SECONDECRYPT:%@",SECONDECRYPT2);
    
    NSMutableString *starTrackStr = [self makeStarTrackWithStr:cardNum];//主账号
    NSMutableDictionary *fiftyFiveDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    NSString *fiftyFiveValue = data55;
    fiftyFiveValue = [fiftyFiveValue uppercaseString];
    [fiftyFiveDic setObject:fiftyFiveValue forKey:@"bit55"];
    [fiftyFiveDic setObject:validityDate forKey:@"5f24"];
    [fiftyFiveDic setObject:sqn forKey:@"5f34"];
    NSDictionary *temDic = (NSDictionary *)fiftyFiveDic;
    NSString *fiftyFiveStr = [temDic JSONString];
    NSLog(@"###fiftyFiveStr == %@",fiftyFiveStr);
    [aiShuaDic setObject:INSERTCARD forKey:TYPEMARK];
    [aiShuaDic setObject:cardNum forKey:CARDNUM];
    [aiShuaDic setObject:starTrackStr forKey:STARCARDNUM];
    
    //上送的磁道信息是直接取到的密文，未解密（解密后的是 SECONDECRYPT2）
    [aiShuaDic setObject:dataAsTrack2 forKey:SECONDTRACKKEY];
    [aiShuaDic setObject:@"" forKey:THIRDTRACKKEY];
    [aiShuaDic setObject:fiftyFiveStr forKey:FIFTYFIVEKEY];
    
    NSMutableDictionary *nlBtPWDic = [[NSMutableDictionary alloc] initWithCapacity:10];
    [nlBtPWDic setObject:BLUETOORHPASSWORD forKey:TYPEMARK];
    [nlBtPWDic setObject:pin forKey:NLBTPWKEY];
    [NSThread detachNewThreadSelector:@selector(successNotice:) toTarget:appDelegate withObject:nlBtPWDic];
    
    
    NSLog(@"aiShuaDic:%@",aiShuaDic);
    [appDelegate sendNLBtNoticeWithDic:aiShuaDic];
}

- (void)StatusInText:(NSString *)text
{
    if (text) {
        NSLog(@"gld_test:%@",[NSString stringWithFormat:@"%@\n",text]);
    }
}

-(void)repeatOpen{
    
    NSLog(@"in repeatOpen");
    [self.zft_qpos2 openCardReader:100 andScheme:@"00"];
}

- (void)initialAishuaBlueTooth1
{
    
    [self.cmManager closeDevice];
    NSLog(@"testype::::%@,%@,%@",appDelegate.testype,appDelegate.blueToothDeviceUUID,appDelegate.blueToothDeviceUUID2);
    
    if (![appDelegate.blueToothDeviceUUID isEqualToString:appDelegate.blueToothDeviceUUID2] && ![appDelegate.testype isEqualToString:@"bindswiper"] && appDelegate.isLogin) {
        NSLog(@"请重新绑定刷卡器");
        sleep(1.5);
        [[KGModal sharedInstance] hideAnimated:YES];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请重新设置蓝牙刷卡器！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert show];
        return;
    }
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化中..."];
    NSLog(@"###initialAishuaBlueTooth---blueToothDeviceUUID == %@",appDelegate.blueToothDeviceUUID);
    if ([Tools isEmptyWithString:appDelegate.blueToothDeviceUUID]) {
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化蓝牙设备失败！"];
    }else{
        int ret = [self.cmManager openDevice:appDelegate.blueToothDeviceUUID cbDelegate:self timeout:15*1000];
        NSLog(@"正在打开");
        if (ret == 0) {
            [self startAishuaBt1];
        }else{
            [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"初始化蓝牙设备失败！"];
            NSLog(@"蓝牙连接失败");
        }
        
    }
}

//绑定刷卡器的时候调用此法
- (void)onGetKsnCompleted:(NSString *)ksn
{
    NSLog(@"/n***************  进入获取ksn回调  ***************");
    
    appDelegate.deviceId = ksn;
    NSDictionary *dic = [NetTools DeviceLoginWithDeviceId:[ksn uppercaseString]];  //签到方法
    NSString *reqCode = [dic objectForKey:@"reqCode"];
    if ([reqCode isEqualToString:@"6033"]) {
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"实名认证正在审核中"];
        return;
    }
    //产品类型判断
    if (![reqCode  isEqualToString: @"0000"] && CHANGPINGNAME != 14 && CHANGPINGNAME != 18 && CHANGPINGNAME != 20 && CHANGPINGNAME != 19 && CHANGPINGNAME != 21) {
        
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"刷卡器异常"];
        return;
    }else if (![reqCode isEqualToString:@"0000"]){
        if (CHANGPINGNAME == 14 || CHANGPINGNAME == 18 || CHANGPINGNAME == 20 ||CHANGPINGNAME == 19 || CHANGPINGNAME == 21) {
            isRuiQianBao = YES;
            [self startAishuaBt];
            return;
        }
    }
    
    NSString *pinKey = [dic objectForKey:@"pinKey"];
    NSString *macKey = [dic objectForKey:@"macKey"];
    NSString *desKey = [dic objectForKey:@"trackKey"];
    char pin[100],mac[100],des[100];
    pin[0]=0;
    mac[0]=0;
    des[0]=0;
    char *tempPin = HexToBin11((char*)[pinKey UTF8String]);
    memcpy(pin, tempPin, [pinKey length]/2);//一定要拷贝否则会占用通一块内存
    int len =(int)[pinKey length]/2;
    char *tempMac = HexToBin11((char*)[macKey UTF8String]);
    memcpy(mac, tempMac, [macKey length]/2);//一定要拷贝否则会占用通一块内存
    char *tempDes = HexToBin11((char*)[desKey UTF8String]);
    memcpy(des, tempDes, [desKey length]/2);//一定要拷贝否则会占用通一块内存
    [self.cmManager Request_ReNewKey:0 PinKey:pin PinKeyLen:len
                              MacKey:mac MacKeyLen:len
                              DesKey:des DesKeyLen:len];
    appDelegate.isGetType = NO;
}
- (void)onGetKsnAndVersionCompleted:(NSArray *)ksnAndVerson
{
    NSLog(@"ksn is %@", [ksnAndVerson objectAtIndex:0]);
    NSLog(@"version is %@", [ksnAndVerson objectAtIndex:1]);
}
- (void)onError:(int)errorCode ErrorMessage:(NSString *)errorMessage;
{
    if (errorCode == -3) {
        NSLog(@"获取ksn失败");
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"连接异常"];
        return;
    }
    else{
        NSLog(@"%@",errorMessage);
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"连接异常"];
        return;
    }
}

//--- okid           //刷卡操作
- (void)startAishuaBt
{
    //ic卡刷卡命令
    NSLog(@"/n***************  进入刷卡操作  ***************");
    NSString *str = @"123456";
    char *temp = HexToBin11((char *)[str UTF8String]);
    char rom[100];
    memcpy(rom, temp, [str length]/2);//一定要拷贝否则会占用通一块内存
    
    // 交易金额
    //    NSString *cash = @"100";
    NSString *cash;
    //NSDecimalNumber *cash;
    if ([Tools isEmptyWithString:appDelegate.accountStr]) {
        cash = @"";
    }else{
        cash = [NSString stringWithFormat:@"%0.0f",[appDelegate.accountStr floatValue]*100];
    }
    int cashLen = (int)[cash length];
    char cData[100];
    cData[0] = 0;
    strcpy(cData,((char*)[cash UTF8String]));
    /*
     8B030000 无法取到二慈明文，其他数据正常
     00be0400 能取到加密的磁道信息，通过密钥解密可以正常使用
     12030000 这个能取到明文二磁数据
     */
    Transactioninfo *tranInfo = [[Transactioninfo alloc] init];
    [self.cmManager setCustomer:36];
    NSString *ctrm;
    if (CHANGPINGNAME == 14 || CHANGPINGNAME == 18 || CHANGPINGNAME == 20 || CHANGPINGNAME == 19 || CHANGPINGNAME == 21) {
        
        if (isRuiQianBao == YES) {
            ctrm = @"12030000";               //标志位  通过标志位来获取磁道信息等 是明文还是密文
        }else{
            ctrm = @"00be0400";
        }
    }else{
        ctrm = @"00be0400";
    }
    char *temp2 = HexToBin11((char*)[ctrm UTF8String]);
    char ctr[4];
    memcpy(ctr, temp2, [ctrm length]/2);
    [self.cmManager setDeviceKind:6];
    if (appDelegate.isInputPWD) {
        [self.cmManager stat_EmvSwiper:1 PINKeyIndex:1
                            DESKeyInex:1 MACKeyIndex:1
                              CtrlMode:ctr ParameterRandom:"123"
                    ParameterRandomLen:3 cash:cData
                               cashLen:cashLen appendData:""
                         appendDataLen:0 time:30 Transactioninfo:tranInfo];
    }else{
        
        [self.cmManager stat_EmvSwiper:0 PINKeyIndex:1
                            DESKeyInex:1 MACKeyIndex:1
                              CtrlMode:ctr ParameterRandom:"123"
                    ParameterRandomLen:3 cash:cData
                               cashLen:cashLen appendData:""
                         appendDataLen:0 time:30 Transactioninfo:tranInfo];
    }
}

- (void)startAishuaBt1
{
    NSString *str = @"123456";
    char *temp = HexToBin11((char *)[str UTF8String]);
    char rom[100];
    memcpy(rom, temp, [str length]/2);//一定要拷贝否则会占用通一块内存
    
    NSString *appendData = @"49900003200015141399";
    char *temp1 = HexToBin11((char*)[appendData UTF8String]);
    char appendDataChar[100];
    memcpy(appendDataChar, temp1, [appendData length]/2);//一定要拷贝否则会占用通一块内存
    //        int appendlen =[appendData length]/2;
    
    //输入金额
    NSString *cash;
    //NSDecimalNumber *cash;
    if ([Tools isEmptyWithString:appDelegate.accountStr]) {
        cash = @"";
    }else{
        cash = [NSString stringWithFormat:@"%0.0f",[appDelegate.accountStr floatValue]*100];
    }
    int cashLen = [cash length];
    char cData[100];
    cData[0] = 0;
    strcpy(cData,((char*)[cash UTF8String]));
    
    Transactioninfo *tranInfo = [[Transactioninfo alloc] init];
    //            Bit0 = 0/1 表示数据域+ 55域/只有数据域参与
    //            Bit1 = 0/1 全部ic卡域/标准55域
    //            Bit2 =0/1 密钥索引不启用/启用
    //            Bit3=0/1 刷卡的卡号密文/明文 不上送/上送
    //            Bit4=0/1 不上送/上送psam卡卡号
    //            Bit5=0/1 不上送/上送终端ID
    //            Bit6=0/1  手输入卡号加密/明文
    //            Bit7 =0/1  支持/不支持IC卡降级
    //            0110 0000 0001 0000
    //            NSString *ctrm = @"ff5b0400";
    //            NSString *ctrm = @"223B0000";
    //            NSString *ctrm = @"18790400";
    //NSString *ctrm = @"10080400";
    NSString *ctrm = @"187F0400";
    
    char *temp2 = HexToBin11((char*)[ctrm UTF8String]);
    char ctr[4];
    memcpy(ctr, temp2, [ctrm length]/2);
    [self.cmManager setDeviceKind:0];
    
    if (appDelegate.isInputPWD) {
        
        [self.cmManager stat_EmvSwiper:1 PINKeyIndex:1
                            DESKeyInex:1 MACKeyIndex:1
                              CtrlMode:ctr ParameterRandom:""
                    ParameterRandomLen:0 cash:cData
                               cashLen:cashLen appendData:""
                         appendDataLen:0 time:30 Transactioninfo:tranInfo];
        
    }else{
        
        [self.cmManager stat_EmvSwiper:0 PINKeyIndex:1
                            DESKeyInex:1 MACKeyIndex:1
                              CtrlMode:ctr ParameterRandom:""
                    ParameterRandomLen:0 cash:cData
                               cashLen:cashLen appendData:""
                         appendDataLen:0 time:30 Transactioninfo:tranInfo];
    }
}

-(void)onDecodeCompleted:(NSString*) formatID      //i21B刷卡成功的回调
                  andKsn:(NSString*) ksn
            andencTracks:(NSString*) encTracks
         andTrack1Length:(int) track1Length
         andTrack2Length:(int) track2Length
         andTrack3Length:(int) track3Length
         andRandomNumber:(NSString*) randomNumber
           andCardNumber:(NSString *)maskedPAN
                  andPAN:(NSString*) pan
           andExpiryDate:(NSString*) expiryDate
       andCardHolderName:(NSString*) cardHolderName
                  andMac:(NSString *)mac
        andQTPlayReadBuf:(NSString*) readBuf
                cardType:(int)type
              cardserial:(NSString *)serialNum
             emvDataInfo:(NSString *)data55
                 cvmData:(NSString *)cvm
{
    NSLog(@"/n***************  进入刷卡回调  ***************");
    NSString* string =[[NSString alloc] initWithFormat:@"ksn:%@\n encTracks:%@ \n track1Length:%i \n track2Length:%i \n track3Length:%i \n randomNumber:%@ \n cardNum:%@ \n PAN:%@ \n expiryDate:%@ \n cardHolderName:%@ \n mac:%@ \n cardType:%d \n cardSerial:%@ \n emvDataInfo:%@ \n cmv:%@  \n readBuf:%@",ksn,encTracks,track1Length,track2Length,track3Length,randomNumber, maskedPAN,pan,expiryDate,cardHolderName,mac,type,serialNum,data55,cvm,readBuf];
    NSLog(@"%@",string);
    
    
    
    if (!appDelegate.isTestSwipCard) {
        [[KGModal sharedInstance] hideAnimated:YES];
    }
    appDelegate.deviceId = [ksn uppercaseString];
    NSMutableString *lowStr = [[NSMutableString alloc] initWithString:[(NSString *)encTracks lowercaseString]];
    NSMutableString *mutableEncTrack = [[NSMutableString alloc] initWithString:[lowStr substringWithRange:NSMakeRange(0, 48)]];//track2Length*2
    NSMutableString *SecondTrackKey = [[NSMutableString alloc] initWithString:[encTracks substringWithRange:NSMakeRange(0, 48)]];//track2Length*2
    
    NSMutableString *starTrackStr = [self makeStarTrackWithStr:maskedPAN];
    [appDelegate.asTestSuccessArr addObject:starTrackStr];
    [appDelegate.testSuccessArr addObject:starTrackStr];
    NSMutableDictionary *aiShuaDic = [[NSMutableDictionary alloc] initWithCapacity:14];
    if ([encTracks length] <= 48 && ![data55 isEqualToString:@""]) {
        NSLog(@"************ 插卡模式 ************");
        mutableEncTrack = [self makeSecondTrackWithStr:mutableEncTrack];
        
        NSMutableDictionary *fiftyFiveDic = [[NSMutableDictionary alloc] initWithCapacity:10];
        NSString *fiftyFiveValue = data55;
        fiftyFiveValue = [fiftyFiveValue uppercaseString];
        [fiftyFiveDic setObject:fiftyFiveValue forKey:@"bit55"];
        if (![Tools isEmptyWithStr:expiryDate]) {
            [fiftyFiveDic setObject:expiryDate forKey:@"5f24"];
        }
        if (![Tools isEmptyWithStr:serialNum]) {
            [fiftyFiveDic setObject:serialNum forKey:@"5f34"];
        }
        NSDictionary *temDic = (NSDictionary *)fiftyFiveDic;
        NSString *fiftyFiveStr = [temDic JSONString];
        NSLog(@"###fiftyFiveStr == %@",fiftyFiveStr);
        
        //新增 二三磁传密文 其它不变
        [aiShuaDic setObject:ksn forKey:@"deviceId"];//设备id - ksn
        [aiShuaDic setObject:INSERTCARD forKey:TYPEMARK];
        [aiShuaDic setObject:maskedPAN forKey:CARDNUM];
        [aiShuaDic setObject:starTrackStr forKey:STARCARDNUM];
        NSString *str;
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        if (ud) {
            str = [ud objectForKey:@"typeId"];
        }
        if ([str isEqualToString:@"21"]) {
            [aiShuaDic setObject:encTracks forKey:SECONDTRACKKEY];
        }else{
            [aiShuaDic setObject:encTracks forKey:SECONDTRACKKEY];
        }
        //        if (appDelegate.typeId == 21) {
        //            [aiShuaDic setObject:encTracks forKey:SECONDTRACKKEY];
        //        }else{
        //            [aiShuaDic setObject:mutableEncTrack forKey:SECONDTRACKKEY];
        //        }
        [aiShuaDic setObject:@"" forKey:THIRDTRACKKEY];
        [aiShuaDic setObject:fiftyFiveStr forKey:FIFTYFIVEKEY];
        
        appDelegate.NL_cardInfoDic = aiShuaDic;
        
    }else{
        NSLog(@"************ 刷卡模式 ************");
        mutableEncTrack = [self makeSecondTrackWithStr:mutableEncTrack];
        NSLog(@"** 带星卡号 ** %@",starTrackStr);
        NSString *thirdTrackStr;
        
        if (encTracks.length > 48) {
            if (appDelegate.typeId == 21) {
                if (isRuiQianBao == YES) {
                    thirdTrackStr = [lowStr substringWithRange:NSMakeRange(48, encTracks.length - 48)];
                    
                    isRuiQianBao = NO;
                }else{
                    thirdTrackStr = [encTracks substringWithRange:NSMakeRange(48, encTracks.length - 48)];
                    thirdTrackStr = [thirdTrackStr stringByReplacingOccurrencesOfString:@"f" withString:@""];
                    thirdTrackStr = [thirdTrackStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                    thirdTrackStr = [thirdTrackStr stringByReplacingOccurrencesOfString:@">" withString:@""];
                    thirdTrackStr = [thirdTrackStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
                    thirdTrackStr = [thirdTrackStr stringByReplacingOccurrencesOfString:@"F" withString:@""];
                    thirdTrackStr = [thirdTrackStr stringByReplacingOccurrencesOfString:@"=" withString:@""];
                }
            }else{
                thirdTrackStr = [lowStr substringWithRange:NSMakeRange(48, encTracks.length - 48)];
                //                thirdTrackStr = [thirdTrackStr stringByReplacingOccurrencesOfString:@"f" withString:@""];
                //                thirdTrackStr = [thirdTrackStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                //                thirdTrackStr = [thirdTrackStr stringByReplacingOccurrencesOfString:@">" withString:@""];
                //                thirdTrackStr = [thirdTrackStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
                //                thirdTrackStr = [thirdTrackStr stringByReplacingOccurrencesOfString:@"F" withString:@""];
                //                thirdTrackStr = [thirdTrackStr stringByReplacingOccurrencesOfString:@"=" withString:@""];
                NSLog(@"------ 三磁信息 ------ %@",thirdTrackStr);
            }
        }
        [aiShuaDic setObject:ksn forKey:@"deviceId"];//设备id - ksn
        [aiShuaDic setObject:ICSWIPMARK forKey:TYPEMARK];
        [aiShuaDic setObject:maskedPAN forKey:CARDNUM];
        [aiShuaDic setObject:starTrackStr forKey:STARCARDNUM];
        //        [aiShuaDic setObject:SecondTrackKey forKey:SECONDTRACKKEY];
        [aiShuaDic setObject:encTracks forKey:SECONDTRACKKEY];
        
        if (thirdTrackStr) {
            [aiShuaDic setObject:thirdTrackStr forKey:THIRDTRACKKEY];
        }else{
            [aiShuaDic setObject:@"" forKey:THIRDTRACKKEY];
        }
        [aiShuaDic setObject:@"" forKey:FIFTYFIVEKEY];
    }
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    //        [self sendASnoticeWithDic:aiShuaDic];
    appDelegate.NL_cardInfoDic = aiShuaDic;
    
    [appDelegate sendNLBtNoticeWithDic:aiShuaDic];//
    
    [self.cmManager stopSearching];
}

- (NSMutableString *)makeSecondTrackWithStr:(NSMutableString *)str
{
    for (int i = 0; i < str.length; i ++) {
        char c = [str characterAtIndex:i];
        if (c == 'f') {
            [str deleteCharactersInRange:NSMakeRange(i, str.length-i)];
            break;
        }
    }
    return str;
}
- (NSMutableString *)makeStarTrackWithStr:(NSString *)str
{
    NSMutableString *starTrackStr = [[NSMutableString alloc] initWithCapacity:10];
    [starTrackStr appendString:[str substringToIndex:6]];
    [starTrackStr appendString:@"******"];
    [starTrackStr appendString:[str substringFromIndex:str.length-4]];
    return starTrackStr;
}

#pragma mark --AishuaBtMethod--
- (void)onWaitingForCardSwipe
{
    
    NSLog(@"AishuaBt---onWaitingForCardSwipe");
    if (appDelegate.isBindSwiper) {
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"请先刷卡/插卡测试！"];
    }else{
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"请刷卡/插卡！"];
    }
}
- (void)EmvOperationWaitiing{
    
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"IC卡读取中，请勿拔卡！(-8)"];
    NSLog(@"ic卡插入，请不要拔卡！");
}

//参数下载回调
- (void)onLoadParam:(NSString *)param{
    NSLog(@"onLoadParam");
}

- (void)onDeviceKind:(int)result{
    NSLog(@"onDeviceKind");
}

//收到数据回调
- (void)dataArrive:(vcom_Result *)vs Status:(int)_status    //点付宝的回调   i21BB错误时也会调用此方法
{
    NSLog(@"******** dataArrive ********");
    fiftyDic=[[NSMutableDictionary alloc]initWithCapacity:10];
    if(_status==-3){
        //设备没有响应
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:self withObject:@"通信超时，请重试！"];
        [self.cmManager closeDevice];
        return;
    }
    else if(_status==-1){
        [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:self withObject:@"数据传递错误，请重试！"];
        [self.cmManager closeDevice];
        //接收数据的格式错误
    }
    else if(vs->res == 0){
        //设备有成功返回指令
        //刷卡连续操作
        //获取psam卡号
        if (vs->rescode[0] == 0x02 &&vs->rescode[1] == 0x10) {
            NSLog(@"^^^^^^^^^^^  更新工作密钥成功  ^^^^^^^^^^^");
            [self startAishuaBt];
            return;
        }
        
        if (vs->panLen>0) {
            //NSLog(@"%d", vs->panLen);
            Pan = [NSString stringWithFormat:@"%@",[self HexValue:vs->pan Len:vs->panLen]];
        }
        if (vs->psamnoLen>0){
            NSLog(@"%s", BinToHex99(vs->psamno, 0, vs->psamnoLen));
            NSString *psamNum = [NSString stringWithFormat:@"%@",[self HexValue:vs->psamno Len:vs->psamnoLen]];
            NSLog(@"psam卡号：%@",psamNum);
        }
        
        if(vs->pinEncryptionLen > 0){
            NSString *userInput = [NSString stringWithFormat:@"%@", [self HexValue:vs->pinEncryption Len:vs->pinEncryptionLen]];
            NSLog(@"<<<<<<<<%@",userInput);
            NSData *inputData = [self hexToBytes:userInput];
            NSLog(@"%@",inputData);
            Byte *encry= (Byte *)[inputData bytes];
            Byte keyBytes[] = {
                0x3f, 0x9e, 0x84, 0xca, 0xc9, 0xa5, 0x31, 0x56,
                0x08, 0x1f, 0x4a, 0xde, 0x12, 0xe4, 0xca, 0xf1,
                0x3f, 0x9e, 0x84, 0xca, 0xc9, 0xa5, 0x31, 0x56,
            };
            //            Byte keyBytes[] = {
            //                0x78, 0xb1, 0x9e, 0x8e, 0x3a, 0xe9, 0x87, 0x13,
            //                0x78, 0xb1, 0x9e, 0x8e, 0x3a, 0xe9, 0x87, 0x13
            //            };
            NSLog(@"<><><><><<>:%s,%s",encry,keyBytes);
            NSString *result = [self DecryptStr:encry key:keyBytes];
            NSString *pwd=[result substringWithRange:NSMakeRange(2, 6)];
            NSLog(@"###pwd == %@",pwd);
            NSMutableDictionary *nlBtPWDic = [[NSMutableDictionary alloc] initWithCapacity:10];
            [nlBtPWDic setObject:BLUETOORHPASSWORD forKey:TYPEMARK];
            [nlBtPWDic setObject:pwd forKey:NLBTPWKEY];
            [NSThread detachNewThreadSelector:@selector(successNotice:) toTarget:appDelegate withObject:nlBtPWDic];
            
        }
        if (vs->data55Len>0) {
            //插卡形式
            NSString *bankCardStr = [NSString stringWithFormat:@"%s", vs->cardPlaintext];
            NSMutableString *disStr = [[NSMutableString alloc] initWithCapacity:10];
            if (vs->cardPlaintextLen>0) {
                [disStr appendString:[bankCardStr substringToIndex:6]];
                [disStr appendString:@"******"];
                [disStr appendString:[bankCardStr substringFromIndex:[bankCardStr length]-4]];
            }
            ////磁道
            NSString *needStr = [NSString stringWithFormat:@"%@",[self HexValue:vs->trackPlaintext Len:vs->trackPlaintextLen]];
            if (vs->trackPlaintextLen>0) {
                needStr = [needStr stringByReplacingOccurrencesOfString:@"=" withString:@"d"];
                needStr = [needStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                needStr = [needStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
                needStr = [needStr stringByReplacingOccurrencesOfString:@">" withString:@""];
                needStr = [needStr stringByReplacingOccurrencesOfString:@"f" withString:@""];
                needStr = [needStr stringByReplacingOccurrencesOfString:@"F" withString:@""];
                NSLog(@"磁道明文%@",needStr);
            }
            NSString *Data55=[NSString stringWithFormat:@"%@",[self HexValue:vs->data55 Len:vs->data55Len] ];
            Data55 = [Data55 uppercaseString];
            NSLog(@"55域数据%@",Data55);
            [fiftyDic setObject:Data55 forKey:@"bit55"];
            //有效期
            if (vs->carddate>0) {
                NSString *bankCardStr=[NSString stringWithFormat:@"%s", vs->carddate];
                NSMutableString *disStr = [[NSMutableString alloc] initWithCapacity:10];
                [disStr appendString:[bankCardStr substringToIndex:4]];
                [fiftyDic setObject:disStr forKey:@"5f24"];
            }
            //序列号
            if (vs->xulieDataLen)
            {
                NSString *xulie = [NSString stringWithFormat:@"%@",[self HexValue:vs->xulieData Len:vs->xulieDataLen] ];
                [fiftyDic setObject:xulie forKey:@"5f34"];
            }
            NSLog(@"###fiftyDic == %@",fiftyDic);
            NSDictionary *temDic = (NSDictionary *)fiftyDic;
            NSString *fiftyFiveStr = [temDic JSONString];
            NSMutableDictionary *btSwipDic = [[NSMutableDictionary alloc] initWithCapacity:10];
            [btSwipDic setObject:bankCardStr forKey:CARDNUM];
            [btSwipDic setObject:disStr forKey:STARCARDNUM];
            [btSwipDic setObject:needStr forKey:SECONDTRACKKEY];
            [btSwipDic setObject:@"" forKey:THIRDTRACKKEY];
            [btSwipDic setObject:fiftyFiveStr forKey:FIFTYFIVEKEY];
            [appDelegate.nlBtTestSuccessArr addObject:disStr];
            [appDelegate sendNLBtNoticeWithDic:btSwipDic];
            NSLog(@"hljqk%@",btSwipDic);
            appDelegate.NL_cardInfoDic = btSwipDic;
            
            [self.cmManager stopSearching];
        }else{
            //刷卡形式
            //卡号
            NSString *bankCardStr = [NSString stringWithFormat:@"%s", vs->cardPlaintext];
            NSMutableString *disStr = [[NSMutableString alloc] initWithCapacity:10];
            
            if (vs->cardPlaintextLen>0) {
                [disStr appendString:[bankCardStr substringToIndex:6]];
                [disStr appendString:@"******"];
                [disStr appendString:[bankCardStr substringFromIndex:[bankCardStr length]-4]];
                NSLog(@"卡号明文%@",bankCardStr);
                NSLog(@"卡号带星%@",disStr);
            }
            //磁道
            NSString *trackData = [NSString stringWithFormat:@"%@",[self HexValue:vs->trackPlaintext Len:vs->trackPlaintextLen]];
            NSString *needStr= [trackData substringWithRange:NSMakeRange(0, 40)];
            
            if (vs->trackPlaintextLen>0) {
                NSLog(@"截取F之前的数据%@",needStr);
                needStr = [needStr stringByReplacingOccurrencesOfString:@"=" withString:@"d"];
                needStr = [needStr stringByReplacingOccurrencesOfString:@" " withString:@""];
                needStr = [needStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
                needStr = [needStr stringByReplacingOccurrencesOfString:@">" withString:@""];
                needStr = [needStr stringByReplacingOccurrencesOfString:@"f" withString:@""];
                needStr = [needStr stringByReplacingOccurrencesOfString:@"F" withString:@""];
                NSLog(@"磁道明文%@",needStr);
                appDelegate.offline_tracks = needStr;
            }
            
            NSMutableDictionary *btSwipDic = [[NSMutableDictionary alloc] initWithCapacity:10];
            [btSwipDic setObject:@"" forKey:THIRDTRACKKEY];
            if (vs->track3Len > 0) {
                NSString *thirdTrack = [NSString stringWithFormat:@"\n Track3:%@",[self HexValue:vs->Track3 Len:vs->track3Len] ];
                [btSwipDic setObject:thirdTrack forKey:THIRDTRACKKEY];
            }
            [btSwipDic setObject:SWIPCARD forKey:TYPEMARK];
            [btSwipDic setObject:bankCardStr forKey:CARDNUM];
            [btSwipDic setObject:disStr forKey:STARCARDNUM];
            [btSwipDic setObject:needStr forKey:SECONDTRACKKEY];
            [btSwipDic setObject:@"" forKey:FIFTYFIVEKEY];
            appDelegate.NL_cardInfoDic = btSwipDic;
            
            [appDelegate.nlBtTestSuccessArr addObject:disStr];
            [appDelegate sendNLBtNoticeWithDic:btSwipDic];
            [self.cmManager stopSearching];
        }
        
    }
    else{
        NSLog(@"cmd exec error:%d\n",vs->res);
        switch (vs->res) {
                //            case 1:
                //                [self performSelectorOnMainThread:@selector(updateData:) withObject:@"通信超时" waitUntilDone:NO];
                //                break;
                /*
                 case 2:
                 [self performSelectorOnMainThread:@selector(updateData:) withObject:@"PSAM卡认证失败" waitUntilDone:NO];
                 break;
                 case 3:
                 [self performSelectorOnMainThread:@selector(updateData:) withObject:@"Psam卡上电失败或者不存在" waitUntilDone:NO];
                 break;
                 case 4:
                 [self performSelectorOnMainThread:@selector(refreshStatusNotSupportCmdFormPosToPhone1) withObject:nil waitUntilDone:NO];
                 break;
                 
                 case 11:
                 [self performSelectorOnMainThread:@selector(updateData:) withObject:@"MAC校验失败" waitUntilDone:NO];
                 break;
                 case 12:
                 [self performSelectorOnMainThread:@selector(updateData:) withObject:@"终端加密失败" waitUntilDone:NO];
                 break;
                 */
            case 10:
                [self performSelectorOnMainThread:@selector(UserExit:) withObject:@"用户退出" waitUntilDone:NO];
                break;
            case 14:
                [self performSelectorOnMainThread:@selector(UserCancle:) withObject:@"用户按了取消健" waitUntilDone:NO];
                break;
            case 0x86:
                [self performSelectorOnMainThread:@selector(UserFail:) withObject:@"ic卡操作失败" waitUntilDone:NO];
                break;
            case 0x87:
                [self performSelectorOnMainThread:@selector(UserFail:) withObject:@"ic卡操作失败" waitUntilDone:NO];
                break;
            case 15:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"Psam卡状态异常" waitUntilDone:NO];
                break;
            case 0x20:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"不匹配的主命令码" waitUntilDone:NO];
                break;
            case 0x21:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"不匹配的子命令码" waitUntilDone:NO];
                break;
            case 0x50:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"获取电池电量失败" waitUntilDone:NO];
                break;
            case 0xe0:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"重传数据无效" waitUntilDone:NO];
                break;
            case 0xe1:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"终端设置待机信息失败" waitUntilDone:NO];
                break;
            case 0xf0:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"不识别的包头" waitUntilDone:NO];
                break;
            case 0xf1:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"不识别的主命令码" waitUntilDone:NO];
                break;
            case 0xf3:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"该版本不支持此指令" waitUntilDone:NO];
                break;
            case 0xf5:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"不支持的部件" waitUntilDone:NO];
                break;
            case 0xf6:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"不支持的模式" waitUntilDone:NO];
                break;
            case 0xfd:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"终端ID错误" waitUntilDone:NO];
                break;
            case 0xfe:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"MAC_TK校验失败" waitUntilDone:NO];
                break;
            case 0xff:
                [self performSelectorOnMainThread:@selector(MessageError:) withObject:@"校验和错误" waitUntilDone:NO];
                break;
            default:
#warning message - 常报错 251 ？？？
                [self performSelectorOnMainThread:@selector(updateData:) withObject:nil waitUntilDone:NO];
                break;
        }
        /* 失败和中间状态代码
         01
         命令执行超时
         02
         PSAM卡认证失败
         03
         Psam卡上电失败或者不存在
         04
         Psam卡操作失败
         0A
         用户退出
         0B
         MAC校验失败
         0C
         终端加密失败
         0E
         用户按了取消健
         0F
         Psam卡状态异常
         20
         不匹配的主命令码
         21
         不匹配的子命令码
         50
         获取电池电量失败
         80
         数据接收正确
         E0
         重传数据无效
         E1
         终端设置待机信息失败
         F0
         不识别的包头
         F1
         不识别的主命令码
         F2
         不识别的子命令码
         F3
         该版本不支持此指令
         F4
         随机数长度错误
         F5
         不支持的部件
         F6
         不支持的模式
         F7
         数据域长度错误
         FC
         数据域内容有误
         FD
         终端ID错误
         FE
         MAC_TK校验失败
         FF
         校验和错误
         // 打印错误
         PROTOCOL_ERR_PRT_NOPAPER     == 0X40   ;打印机缺纸
         PROTOCOL_ERR_PRT_OFF         == 0X41   ;打印机离线
         PROTOCOL_ERR_PRT_NO          == 0X42   ;没有打印机
         PROTOCOL_ERR_PRT_NOBM        == 0X43  ;没有黑标
         PROTOCOL_ERR_PRT_CLOSE       == 0X44  ;打印机关闭
         PROTOCOL_ERR_PRT_OTHER       == 0X45  ;打印机故障
         */
    }
}


-(void)UserExit:(id)sender
{
    [self.cmManager closeDevice];
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"用户退出交易！"];
}
-(void)MessageError:(id)sender
{
    
    [self.cmManager closeDevice];
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"信息错误！"];
    
}
-(void)UserFail:(id)sender
{
    
    [self.cmManager closeDevice];
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"IC卡操作失败！"];
}
//用户按了取消键
- (void)UserCancle:(id)sender
{
    [self.cmManager closeDevice];
    [NSThread detachNewThreadSelector:@selector(noticeWithStr:) toTarget:appDelegate withObject:@"您取消交易！"];
}
-(void)updateData:(id)sender
{
    
}
//通信超时回调
- (void)onTimeout
{
    NSLog(@"onTimeout");
}
//出错回调
- (void)onError:(NSInteger) code msg:(NSString*) msg{
    NSLog(@"onError");
}
//蓝牙关闭成功的回调
- (void)closeOk{
    NSLog(@"closeOk");
}

-(void)AishuaKeyBoardInputPwd:(id)sender
{
    [self.cmManager Request_GetPin:0 keyIndex:1 cash:"" cashLen:5 random:myRandom randomLen:myRandomLen panData:"" pandDataLen:0 time:60];
}


@end
