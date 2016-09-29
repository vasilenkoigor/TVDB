//
// Created by Igor Vasilenko on 29/09/2016.
// Copyright (c) 2016 Igor Vasilenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^VASSessionResponseSerializerAnyBlock)(NSURLSessionDataTask *task, id object);
typedef void(^VASSessionResponseSerializerWithError)(NSURLSessionDataTask *task, NSError *error);

@protocol NetworkClientResponseSerializer <NSObject>

- (void)parseJSON:(id)JSON
           forKey:(NSString *)key
      resultClass:(Class)resultClass
             task:(NSURLSessionDataTask *)dataTask
          success:(VASSessionResponseSerializerAnyBlock)success
          failure:(VASSessionResponseSerializerWithError)failure;

@end
