//
//  VEConfig.h
//  Venus
//
//  Created by 谈文钊 on 4/13/16.
//  Copyright © 2016 caishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VEConfig : NSObject

/**
 *  配置SDK相关参数，需要在应用启动时候调用
 *
 *  @param appId    在http://www.9wuli.com/申请后获取
 *  @param appSecret 在http://www.9wuli.com/申请后获取
 */
+ (void)startWithAppId:(NSString *)appId appSecret:(NSString *)appSecret;

@end
