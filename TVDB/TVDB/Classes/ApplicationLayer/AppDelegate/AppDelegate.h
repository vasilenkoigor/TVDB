//
//  AppDelegate.h
//  TVDB
//
//  Created by Igor Vasilenko on 27/09/2016.
//  Copyright © 2016 Igor Vasilenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Twitter;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic, readonly) Twitter *twitter;

@end

