//
//  JXPHTTPClient.h
//  FingerTipEarn
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface JXPHTTPClient : AFHTTPSessionManager

AS_SINGLETON(JXPHTTPClient);

@property (nonatomic, strong) id currentErrorRespnse;//当前错误信息

- (void)updateBaseURL;
- (void)updateHeaderField;
- (void)resetHeaderfield;

- (void)changeRequestSerializerAcceptXML;
- (void)changeRequestSerializerAcceptJSON;

@end
