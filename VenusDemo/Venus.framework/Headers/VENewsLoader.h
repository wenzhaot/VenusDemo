//
//  VENewsLoader.h
//  Venus
//
//  Created by 谈文钊 on 4/13/16.
//  Copyright © 2016 caishi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^VenusArrayResultBlock)(NSArray *array, NSError *error);

@class VEChannel;

@interface VENewsLoader : NSObject

/**
 *  获取所有新闻频道列表
 *
 *  @param block 查询结果回调
 */
- (void)loadChannelsInBackgroundWithBlock:(VenusArrayResultBlock)block;

/**
 *  获取新闻列表
 *
 *  @param channel  当前需要获取新闻的频道
 *  @param pageSize 当前需要获取新闻列表的条目数
 *  @param block    查询结果回调
 */
- (void)loadNewsInBackgroundWithChannel:(VEChannel *)channel pageSize:(NSUInteger)pageSize block:(VenusArrayResultBlock)block;

@end
