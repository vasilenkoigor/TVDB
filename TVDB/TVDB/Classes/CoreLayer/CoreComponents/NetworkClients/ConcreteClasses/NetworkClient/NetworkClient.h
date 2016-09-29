//
// Created by Igor Vasilenko on 23/03/16.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

typedef void(^SessionManagerCompletionBlockWithSuccess)(NSURLSessionDataTask *task, id responseObject);
typedef void(^SessionManagerCompletionBlockWithFailure)(NSURLSessionDataTask *task, NSError *error);

typedef NS_ENUM(NSUInteger, VASHTTPMethod) {
    VASHTTPMethodGET,
    VASHTTPMethodPOST,
    VASHTTPMethodPUT,
    VASHTTPMethodPATCH,
    VASHTTPMethodDELETE
};

@protocol NetworkClient <NSObject>

- (NSURLSessionDataTask *)method:(VASHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                         success:(SessionManagerCompletionBlockWithSuccess)success
                         failure:(SessionManagerCompletionBlockWithFailure)failure;

- (NSURLSessionDataTask *)method:(VASHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                     resultClass:(Class)resultClass
                          forKey:(NSString *)key
                         success:(SessionManagerCompletionBlockWithSuccess)success
                         failure:(SessionManagerCompletionBlockWithFailure)failure;

@end