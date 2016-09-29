//
//  NetworkClientResponseSerializerImpl.h
//
//  Created by Igor Vasilenko on 14/06/15.
//  Copyright (c) 2015 Igor Vasilenko. All rights reserved.
//

#import "NetworkClientResponseSerializer.h"

@class NSURLSessionDataTask;

@interface NetworkClientResponseSerializerImpl : NSObject <NetworkClientResponseSerializer>

@property (nonatomic, strong) dispatch_queue_t dispatch_queue;

+ (instancetype)serializer;

@end
