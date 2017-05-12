//
//  JXPClient.m
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "JXPClient.h"
#import "DDTTYLogger.h"
#import "DDFileLogger.h"
#import <SystemConfiguration/CaptiveNetwork.h>


@interface JXPClient ()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation JXPClient

DEF_SINGLETON(JXPClient)

- (id)init{
    self = [super init];
    if (self) {
        
        [self initLog];
        self.isNetwork = YES;
        self.isEncrypt = YES;
        //b5f5bbb1515235205fe7463bb65e487d271dbc65
        //F2F9D88F-E909-4691-8A11-9B348492B852
        //4BB58348-90E0-4E3F-B928-DBF84A5D207F
        self.mobilePhoneUDID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//        self.mobilePhoneUDID = [NSString newUUID];//[[UIDevice currentDevice] uniqueBundleIdentifier];//[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    }
    return self;
}

#pragma mark - Init

/**
 初始日志系统
 */
- (void)initLog
{
    //文件日志系统
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24;
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
    //控制台日志系统
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
}

#pragma mark - Private Methods

- (void)setUser:(JXPUserModel *)user
{
    _user = user;
    if (_user) {
        
    } else {
        
    }
}

- (void)signOutUser
{
    _user = nil;
    //    [SSKeychain deletePasswordForService:kBundleIdentifier account:kKeyUser];
    //    [SSKeychain deletePasswordForService:kBundleIdentifier account:kKeyPassword];
}

#pragma mark - 定位

- (CLLocationManager *)locationManager
{
    if (_locationManager == nil)
    {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        //        _locationManager.distanceFilter = 20;
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

//普通态
- (void)startLocation
{
    DDLogInfo(@"开始定位");
    if (IOS8_OR_LATER)
    {
        [self.locationManager requestWhenInUseAuthorization];
    }
    // 检查定位服务是否可用
    if ([CLLocationManager locationServicesEnabled])
    {
        [self.locationManager startUpdatingLocation]; // 开始定位
    }
    else
    {
        NSLog(@"定位不可用");
        [self stopLocation];
    }
}

- (void)stopLocation
{
    [self.locationManager stopUpdatingLocation]; // 开始定位
}

// 定位成功时调用
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    DDLogInfo(@"定位成功");
    [self stopLocation];
    CLLocationCoordinate2D mylocation = newLocation.coordinate;
    self.currentLocation = mylocation;
    [self getCity:[[CLLocation alloc] initWithLatitude:self.currentLocation.latitude longitude:self.currentLocation.longitude]];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    DDLogInfo(@"定位失败");
    [self stopLocation];
}

- (void)getCity:(CLLocation *)location
{
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil && [placemarks count] > 0)
        {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:placemark.addressDictionary];
            //1---城市
            NSMutableString *city = [[NSMutableString alloc] initWithString:[dic objectForKey:@"City"]];
            NSRange range = [city rangeOfString:@"市"];
            if (range.length > 0)
            {
                [city  deleteCharactersInRange:range];
            }
            _currentLocationCity = city;
            //2---区
            self.currentLocationDistrict = placemark.subLocality ? placemark.subLocality : placemark.subLocality;
            //3---详细地址
            self.currentLocationDesc = [NSString stringWithFormat:@"%@%@",
                                        placemark.thoroughfare.length > 0 ? placemark.thoroughfare: @"",
                                        placemark.subThoroughfare.length > 0 ? placemark.subThoroughfare: @""];
        }
        else if (error == nil &&[placemarks count] == 0)
        {
            DDLogInfo(@"No results were returned.");
        }
        else if (error != nil)
        {
            DDLogInfo(@"An error occurred = %@", error);
        }
    }];
}


@end
