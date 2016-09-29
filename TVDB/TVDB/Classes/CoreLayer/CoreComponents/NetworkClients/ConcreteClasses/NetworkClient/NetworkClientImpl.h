//
//  VASURLSessionManager.h
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "NetworkClient.h"
#import <AFNetworking/AFURLSessionManager.h>

@protocol NetworkClientResponseSerializer;

@interface NetworkClientImpl : AFURLSessionManager <NetworkClient>

@property (strong, nonatomic, readonly) id <NetworkClientResponseSerializer> networkClientResponseSerializer;

- (instancetype)initWithBaseURL:(NSURL *)baseURL
           sessionConfiguration:(NSURLSessionConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

@end
