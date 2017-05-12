//
//  JXPHTTPClient.m
//  JingXianPayDemo
//
//  Created by dengtao on 2017/4/12.
//  Copyright © 2017年 dengtao. All rights reserved.
//

#import "JXPHTTPClient.h"
#import "GTMBase64.h"

@implementation JXPHTTPClient

+ (JXPHTTPClient *)sharedInstance {
    
    static JXPHTTPClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[JXPHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kApiUrlAPP]];
        _sharedClient.requestSerializer.timeoutInterval = kTimeoutSec;
        //忽略缓存直接从原始地址下载。http://blog.csdn.net/dean19900504/article/details/8134720
        //        _sharedClient.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];//申明返回的结果是json类型
    });
    
    return _sharedClient;
}


- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    NSString *client = nil;
    if (DEBUG) {
        
        client = @"god_ios:55835c0a772a6c81";
    }else{
        
        client = @"badou_ios:f07c641c2568d3d1";
    }
    
    
    
    
    NSData *getBytesData = [client dataUsingEncoding:NSASCIIStringEncoding];
    NSString *base64String = [NSString stringWithFormat:@"basic %@",[getBytesData base64Encoded]];
    
    [self.requestSerializer setValue:base64String                 forHTTPHeaderField:@"Authorization"];
    [self.requestSerializer setValue:@"application/json"          forHTTPHeaderField:@"Accept"];
    
    return self;
}

- (void)updateBaseURL
{
    [self.requestSerializer clearAuthorizationHeader];
    
    NSString *client = nil;
    if (DEBUG) {
        
        client = @"god_ios:55835c0a772a6c81";
    }else{
        
        client = @"badou_ios:f07c641c2568d3d1";
    }
    NSData *getBytesData = [client dataUsingEncoding:NSASCIIStringEncoding];
    NSString *base64String = [NSString stringWithFormat:@"basic %@",[getBytesData base64Encoded]];
    
    [self.requestSerializer setValue:base64String                 forHTTPHeaderField:@"Authorization"];
    [self.requestSerializer setValue:@"application/json"          forHTTPHeaderField:@"Accept"];
}

- (void)resetHeaderfield{
    
    [self.requestSerializer clearAuthorizationHeader];
    NSString *client = nil;
    if (DEBUG) {
        
        client = @"god_ios:55835c0a772a6c81";
    }else{
        
        client = @"badou_ios:f07c641c2568d3d1";
    }
    NSData *getBytesData = [client dataUsingEncoding:NSASCIIStringEncoding];
    NSString *base64String = [NSString stringWithFormat:@"basic %@",[getBytesData base64Encoded]];
    
    [self.requestSerializer setValue:base64String                 forHTTPHeaderField:@"Authorization"];
    [self.requestSerializer setValue:@"application/json"          forHTTPHeaderField:@"Accept"];
}

- (void)updateHeaderField
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *tokenType = [defaults valueForKey:@"user"][@"token_type"];
    NSString *accessToken = [defaults valueForKey:@"user"][@"access_token"];
    [self.requestSerializer setValue:[NSString stringWithFormat:@"%@ %@",tokenType,accessToken] forHTTPHeaderField:@"Authorization"];
}

- (void)changeRequestSerializerAcceptXML
{
    //    self.responseSerializer = [AFXMLParserResponseSerializer serializer];
    //    [self.requestSerializer setValue:@"application/xml" forHTTPHeaderField:@"Accept"];
}

- (void)changeRequestSerializerAcceptJSON
{
    //    self.requestSerializer = [AFJSONRequestSerializer serializer];//申明请求的数据是json类型
    //    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
}

//拦截网络错误信息
- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            self.currentErrorRespnse = nil;
            if (failure) {
                self.currentErrorRespnse = responseObject;
                failure(dataTask, error);
            }
        } else {
            if (success) {
                success(dataTask, responseObject);
            }
        }
    }];
    
    return dataTask;
}

- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                  uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
                                downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [self dataTaskWithRequest:request
                          uploadProgress:uploadProgress
                        downloadProgress:downloadProgress
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
                           if (error) {
                               self.currentErrorRespnse = nil;
                               if (failure) {
                                   self.currentErrorRespnse = responseObject;
                                   failure(dataTask, error);
                               }
                           } else {
                               if (success) {
                                   success(dataTask, responseObject);
                               }
                           }
                       }];
    
    return dataTask;
}


@end
