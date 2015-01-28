//
//  PFApi.m
//  Event Sniff
//
//  Created by Pariwat Promjai on 1/17/2558 BE.
//  Copyright (c) 2557 Platwo fusion. All rights reserved.
//

#import "PFApi.h"

@implementation PFApi

- (id) init
{
    if (self = [super init])
    {
        self.manager = [AFHTTPRequestOperationManager manager];
        self.userDefaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

#pragma mark - Access Token
- (void)saveAccessToken:(NSString *)access_token {
    [self.userDefaults setObject:access_token forKey:@"access_token"];
}

- (NSString *)getAccessToken {
    return [self.userDefaults objectForKey:@"access_token"];
}

#pragma mark - User ID
- (void)saveUserId:(NSString *)user_id {
    [self.userDefaults setObject:user_id forKey:@"user_id"];
}

- (NSString *)getUserId {
    return [self.userDefaults objectForKey:@"user_id"];
}

#pragma mark - Check Log in
- (BOOL)checkLogin {
    if ([self.userDefaults objectForKey:@"user_id"] != nil || [self.userDefaults objectForKey:@"access_token"] != nil) {
        return true;
    } else {
        return false;
    }
}

#pragma mark - Login facebook token
- (void)loginWithFacebookToken:(NSString *)fb_token {

    self.urlStr = [[NSString alloc] initWithFormat:@"%@oauth/facebook",API_URL];
    
    NSDictionary *parameters;
    
    if ([[self.userDefaults objectForKey:@"deviceToken"] isEqualToString:@""] || [[self.userDefaults objectForKey:@"deviceToken"] isEqualToString:@"(null)"]) {
        
        parameters = @{@"facebook_token":fb_token , @"ios_device_token[key]":@"" , @"ios_device_token[type]":@"product"};
        
    } else {
        
        parameters = @{@"facebook_token":fb_token , @"ios_device_token[key]":[self.userDefaults objectForKey:@"deviceToken"] , @"ios_device_token[type]":@"product"};
        
    }
    
    [self.manager POST:self.urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self loginWithFacebookTokenResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self loginWithFacebookTokenErrorResponse:[error localizedDescription]];
    }];
    
}

#pragma mark - Log out
- (void)logOut {
    [self.userDefaults removeObjectForKey:@"access_token"];
    [self.userDefaults removeObjectForKey:@"user_id"];
}

#pragma mark - Event
- (void)getNow {
    
    self.urlStr = [[NSString alloc] initWithFormat:@"%@event/today_event",API_URL];
    
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self getNowResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self getNowErrorResponse:[error localizedDescription]];
    }];
    
}

- (void)getCategory {

    self.urlStr = [[NSString alloc] initWithFormat:@"%@event/category_lists/%@",API_URL,@"en"];
    
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self getCategoryResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self getCategoryErrorResponse:[error localizedDescription]];
    }];

}

@end
