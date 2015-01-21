//
//  PFApi.h
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/17/2558 BE.
//  Copyright (c) 2557 Platwo fusion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol PFApiDelegate <NSObject>

#pragma mark - Login facebook token
- (void)PFApi:(id)sender loginWithFacebookTokenResponse:(NSDictionary *)response;
- (void)PFApi:(id)sender loginWithFacebookTokenErrorResponse:(NSString *)errorResponse;

@end

@interface PFApi : NSObject

#pragma mark - Property
@property (assign, nonatomic) id delegate;
@property AFHTTPRequestOperationManager *manager;
@property NSUserDefaults *userDefaults;
@property NSString *urlStr;

#pragma mark - User_id
- (void)saveUserId:(NSString *)user_id;
- (void)saveAccessToken:(NSString *)access_token;

- (NSString *)getUserId;
- (NSString *)getAccessToken;

#pragma mark - Check Login
- (BOOL)checkLogin;

#pragma mark - Login facebook token
- (void)loginWithFacebookToken:(NSString *)fb_token;

#pragma mark - Log out
- (void)logOut;

@end
