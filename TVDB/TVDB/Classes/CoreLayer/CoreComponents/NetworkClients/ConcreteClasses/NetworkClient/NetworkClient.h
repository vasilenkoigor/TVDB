//
// Created by Igor Vasilenko on 23/03/16.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

typedef void(^NetworkClientCompletionBlockWithSuccess)(NSURLSessionDataTask *task, id responseObject);
typedef void(^NetworkClientCompletionBlockWithFailure)(NSURLSessionDataTask *task, NSError *error);

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
                         success:(NetworkClientCompletionBlockWithSuccess)success
                         failure:(NetworkClientCompletionBlockWithFailure)failure;

- (NSURLSessionDataTask *)method:(VASHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                     resultClass:(Class)resultClass
                          forKey:(NSString *)key
                         success:(NetworkClientCompletionBlockWithSuccess)success
                         failure:(NetworkClientCompletionBlockWithFailure)failure;

#pragma mark - ReactiveCocoa extended

/*
 * Note: RACSignal is immediately resume data task.
 */

- (RACSignal *)rac_method:(VASHTTPMethod)method
                URLString:(NSString *)URLString
               parameters:(id)parameters;

- (RACSignal *)rac_method:(VASHTTPMethod)method
                URLString:(NSString *)URLString
               parameters:(id)parameters
              resultClass:(Class)resultClass
                   forKey:(NSString *)key;

@end