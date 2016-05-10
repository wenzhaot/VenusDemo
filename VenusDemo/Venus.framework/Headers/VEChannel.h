//
//  VEChannel.h
//  Venus
//
//  Created by 谈文钊 on 4/13/16.
//  Copyright © 2016 caishi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VEChannel : NSObject

/**
 *  频道唯一标识
 */
@property (copy, nonatomic) NSString *identifier;

/**
 *  频道名称
 */
@property (copy, nonatomic) NSString *name;

/**
 *  是否属于推荐频道
 */
@property (assign, nonatomic, getter=isRecommend) BOOL recommend;

@end
