//
//  VASURLSessionManager.m
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "NetworkClientImpl.h"

#import "NetworkClientResponseSerializerImpl.h"

@interface NetworkClientImpl ()

@property (strong, nonatomic, readwrite) id <NetworkClientResponseSerializer> networkClientResponseSerializer;
@property (strong, nonatomic) NSURL *baseURL;

@end

@implementation NetworkClientImpl

- (instancetype)initWithBaseURL:(NSURL *)baseURL
           sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    self = [self initWithSessionConfiguration:configuration];
    if (self) {
        self.baseURL = baseURL;
    }
    return self;
}

#pragma mark - Requests data tasks

- (NSURLSessionDataTask *)method:(VASHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                         success:(SessionManagerCompletionBlockWithSuccess)success
                         failure:(SessionManagerCompletionBlockWithFailure)failure
{
    return [self dataTaskWithMethod:method
                          URLString:URLString
                         parameters:parameters
                            success:success
                            failure:failure];
}

- (NSURLSessionDataTask *)method:(VASHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                     resultClass:(Class)resultClass
                          forKey:(NSString *)key
                         success:(SessionManagerCompletionBlockWithSuccess)success
                         failure:(SessionManagerCompletionBlockWithFailure)failure
{
    __weak __typeof(self)weakSelf = self;

    return [self method:method
              URLString:URLString
             parameters:parameters
                success:^(NSURLSessionDataTask *task, id responseObject) {
                    [weakSelf.networkClientResponseSerializer parseJSON:responseObject
                                                                 forKey:key
                                                            resultClass:resultClass
                                                                   task:task
                                                                success:success
                                                                failure:failure];
                } failure:failure];
}

#pragma mark - HTTP Methods Data Tasks

- (NSURLSessionDataTask *)dataTaskWithMethod:(VASHTTPMethod)method
                                   URLString:(NSString *)URLString
                                  parameters:(id)parameters
                                     success:(SessionManagerCompletionBlockWithSuccess)success
                                     failure:(SessionManagerCompletionBlockWithFailure)failure
{
    NSURLRequest *urlRequest;

    switch (method) {
        case VASHTTPMethodGET:
            urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                       URLString:URLString
                                                                      parameters:parameters
                                                                           error:NULL];
            break;
        case VASHTTPMethodPOST:
            urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST"
                                                                       URLString:URLString
                                                                      parameters:parameters
                                                                           error:NULL];
            break;
        case VASHTTPMethodPUT:
            urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"PUT"
                                                                       URLString:URLString
                                                                      parameters:parameters
                                                                           error:NULL];
            break;
        case VASHTTPMethodPATCH:
            urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"PATCH"
                                                                       URLString:URLString
                                                                      parameters:parameters
                                                                           error:NULL];
            break;
        case VASHTTPMethodDELETE:
            urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"DELETE"
                                                                       URLString:URLString
                                                                      parameters:parameters
                                                                           error:NULL];
            break;

        default:
            urlRequest = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET"
                                                                       URLString:URLString
                                                                      parameters:parameters
                                                                           error:NULL];
    }

    NSMutableURLRequest *modifiedRequest = urlRequest.mutableCopy;
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
    if (!reachability.isReachable) {
        modifiedRequest.cachePolicy = NSURLRequestReturnCacheDataDontLoad;
    }

    NSURLSessionDataTask *dataTask = [self dataTaskWithRequest:modifiedRequest
                                             completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                 if (error)
                                                 {
                                                     failure(dataTask, error);
                                                 }
                                                 else
                                                 {
                                                     success(dataTask, responseObject);
                                                 }
                                             }];
    return dataTask;
}

@end
