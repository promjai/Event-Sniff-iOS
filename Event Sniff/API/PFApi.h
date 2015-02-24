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

#pragma mark - Register Noneuser
- (void)PFApi:(id)sender registerNoneuserResponse:(NSDictionary *)response;
- (void)PFApi:(id)sender registerNoneuserErrorResponse:(NSString *)errorResponse;

#pragma mark - Profile
- (void)PFApi:(id)sender meResponse:(NSDictionary *)response;
- (void)PFApi:(id)sender meErrorResponse:(NSString *)errorResponse;

- (void)PFApi:(id)sender getUserSettingResponse:(NSDictionary *)response;
- (void)PFApi:(id)sender getUserSettingErrorResponse:(NSString *)errorResponse;

#pragma mark - Location
- (void)PFApi:(id)sender getLocationResponse:(NSDictionary *)response;
- (void)PFApi:(id)sender getLocationErrorResponse:(NSString *)errorResponse;

- (void)PFApi:(id)sender getCityResponse:(NSDictionary *)response;
- (void)PFApi:(id)sender getCityErrorResponse:(NSString *)errorResponse;

#pragma mark - Event
- (void)PFApi:(id)sender getEventResponse:(NSDictionary *)response;
- (void)PFApi:(id)sender getEventErrorResponse:(NSString *)errorResponse;

#pragma mark - Now
- (void)PFApi:(id)sender getNowResponse:(NSDictionary *)response;
- (void)PFApi:(id)sender getNowErrorResponse:(NSString *)errorResponse;

#pragma mark - Upcoming
- (void)PFApi:(id)sender getUpcomingResponse:(NSDictionary *)response;
- (void)PFApi:(id)sender getUpcomingErrorResponse:(NSString *)errorResponse;

#pragma mark - Category
- (void)PFApi:(id)sender getCategoryResponse:(NSDictionary *)response;
- (void)PFApi:(id)sender getCategoryErrorResponse:(NSString *)errorResponse;

- (void)PFApi:(id)sender getCategoryListResponse:(NSDictionary *)response;
- (void)PFApi:(id)sender getCategoryListErrorResponse:(NSString *)errorResponse;

@end

@interface PFApi : NSObject

#pragma mark - Property
@property (assign, nonatomic) id delegate;
@property AFHTTPRequestOperationManager *manager;
@property NSUserDefaults *userDefaults;
@property NSString *urlStr;

#pragma mark - Reset App
- (void)saveReset:(NSString *)reset;
- (NSString *)getReset;

#pragma mark - Check Intro
- (void)saveStatusIntro:(NSString *)status;
- (NSString *)getStatusIntro;

#pragma mark - App Language
- (void)saveLanguage:(NSString *)language;
- (NSString *)getLanguage;

#pragma mark - Content Language
- (NSString *)getContentLanguage;

#pragma mark - User_id
- (void)saveUserId:(NSString *)user_id;
- (void)saveAccessToken:(NSString *)access_token;

- (NSString *)getUserId;
- (NSString *)getAccessToken;

#pragma mark - Check Login
- (BOOL)checkLogin;

#pragma mark - Login facebook token
- (void)loginWithFacebookToken:(NSString *)fb_token;

#pragma mark - Register Noneuser
- (void)registerNoneuser;

#pragma mark - Log out
- (void)logOut;

#pragma mark - Profile
- (void)me;
- (void)getUserSetting;
- (void)settingUser:(NSString *)obj1 email:(NSString *)obj2 website:(NSString *)obj3 tel:(NSString *)obj4 gender:(NSString *)obj5 birthday:(NSString *)obj6;

#pragma mark - Location
- (void)getLocation;
- (void)getCity:(NSString *)country_id;

#pragma mark - Event
- (void)getEvent:(NSString *)event_id;

- (void)getNow;
- (void)getUpcoming;
- (void)getCategory;
- (void)getCategoryList:(NSString *)category_id;

@end
