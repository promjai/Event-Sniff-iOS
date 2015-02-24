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

#pragma mark - Reset
- (void)saveReset:(NSString *)reset {
    [self.userDefaults setObject:reset forKey:@"reset"];
}

- (NSString *)getReset {
    return [self.userDefaults objectForKey:@"reset"];
}

#pragma mark - Check Intro
- (void)saveStatusIntro:(NSString *)status {

    [self.userDefaults setObject:status forKey:@"statusintro"];

}

- (NSString *)getStatusIntro {

    return [self.userDefaults objectForKey:@"statusintro"];
    
}

#pragma mark - App Language
- (void)saveLanguage:(NSString *)language {
    
    [self.userDefaults setObject:language forKey:@"language"];

}

- (NSString *)getLanguage {
    
    return [self.userDefaults objectForKey:@"language"];
    
}

#pragma mark - Content Language
- (NSString *)getContentLanguage {

    NSString *userLocale = [[NSLocale currentLocale] localeIdentifier];
    NSString *userLanguage = [userLocale substringToIndex:2];
    
    if ([userLanguage isEqualToString:@"th"]) {
        return @"th";
    } else {
        return @"en";
    }

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

#pragma mark - Register Noneuser
- (void)registerNoneuser {
    
    self.urlStr = [[NSString alloc] initWithFormat:@"%@register/noneuser",API_URL];
    NSDictionary *parameters = @{@"ios_device_token":[self.userDefaults objectForKey:@"deviceToken"]};
    [self.manager POST:self.urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self registerNoneuserResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self registerNoneuserErrorResponse:[error localizedDescription]];
    }];

}

#pragma mark - Log out
- (void)logOut {
    
    [self.userDefaults removeObjectForKey:@"type"];
    [self.userDefaults removeObjectForKey:@"access_token"];
    [self.userDefaults removeObjectForKey:@"user_id"];
    
}

#pragma mark - Profile
- (void)me {

    self.urlStr = [[NSString alloc] initWithFormat:@"%@user/%@",API_URL,[self getUserId]];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self meResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self meErrorResponse:[error localizedDescription]];
    }];

}

- (void)getUserSetting {
    self.urlStr = [[NSString alloc] initWithFormat:@"%@user/setting/%@",API_URL,[self getUserId]];
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self getUserSettingResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self getUserSettingErrorResponse:[error localizedDescription]];
    }];
}

- (void)settingUser:(NSString *)obj1 email:(NSString *)obj2 website:(NSString *)obj3 tel:(NSString *)obj4 gender:(NSString *)obj5 birthday:(NSString *)obj6 {
    
    self.urlStr = [[NSString alloc] initWithFormat:@"%@user/setting/%@",API_URL,[self getUserId]];
    NSDictionary *parameters = @{@"show_facebook":obj1 , @"show_email":obj2 , @"show_website":obj3 , @"show_mobile":obj4 , @"show_gender":obj5 , @"show_birth_date":obj6};
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    [self.manager.requestSerializer setValue:nil forHTTPHeaderField:@"X-Auth-Token"];
    [self.manager PUT:self.urlStr parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self getUserSettingResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self getUserSettingErrorResponse:[error localizedDescription]];
    }];
    
}

#pragma mark - Location
- (void)getLocation {

    self.urlStr = [[NSString alloc] initWithFormat:@"%@location/countries",API_URL];
    
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self getLocationResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self getLocationErrorResponse:[error localizedDescription]];
    }];

}

- (void)getCity:(NSString *)country_id {
    
    self.urlStr = [[NSString alloc] initWithFormat:@"%@location/cities/%@",API_URL,country_id];
    
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self getCityResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self getCityErrorResponse:[error localizedDescription]];
    }];

}

#pragma mark - Event
- (void)getEvent:(NSString *)event_id {
    
    self.urlStr = [[NSString alloc] initWithFormat:@"%@event/%@",API_URL,event_id];
    
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self getEventResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self getEventErrorResponse:[error localizedDescription]];
    }];
    
}

#pragma mark - Now
- (void)getNow {
    
    self.urlStr = [[NSString alloc] initWithFormat:@"%@event/today/%@",API_URL,[self getContentLanguage]];
    
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self getNowResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self getNowErrorResponse:[error localizedDescription]];
    }];
    
}

#pragma mark - Upcoming
- (void)getUpcoming {

    self.urlStr = [[NSString alloc] initWithFormat:@"%@event/upcoming",API_URL];
    
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self getUpcomingResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self getUpcomingErrorResponse:[error localizedDescription]];
    }];
    
}

#pragma mark - Category
- (void)getCategory {

    self.urlStr = [[NSString alloc] initWithFormat:@"%@event/category_lists/%@",API_URL,[self getContentLanguage]];
    
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self getCategoryResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self getCategoryErrorResponse:[error localizedDescription]];
    }];

}

- (void)getCategoryList:(NSString *)category_id {
    
    self.urlStr = [[NSString alloc] initWithFormat:@"%@event/category/upcoming/%@",API_URL,category_id];
    
    [self.manager GET:self.urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self.delegate PFApi:self getCategoryListResponse:responseObject];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.delegate PFApi:self getCategoryListErrorResponse:[error localizedDescription]];
    }];

}

@end
