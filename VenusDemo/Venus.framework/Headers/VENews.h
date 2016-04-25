//
//  VENews.h
//  Venus
//
//  Created by 谈文钊 on 4/13/16.
//  Copyright © 2016 caishi. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  新闻图片
 */
@interface VENewsImage : NSObject

/**
 *  是否为gif图片
 */
@property (readonly, assign, nonatomic) BOOL isGif;

/**
 *  图片宽度
 */
@property (readonly, assign, nonatomic) float width;

/**
 *  图片高度
 */
@property (readonly, assign, nonatomic) float height;

/**
 *  图片url
 */
@property (readonly, copy, nonatomic) NSString *url;

/**
 *  gif动图可以采用该地址
 */
@property (readonly, copy, nonatomic) NSString *src;

@end





@interface VENews : NSObject

/**
 *  新闻唯一标识
 */
@property (readonly, copy, nonatomic) NSString *identifier;

/**
 *  新闻标题
 */
@property (readonly, copy, nonatomic) NSString *title;

/**
 *  新闻概要
 */
@property (readonly, copy, nonatomic) NSString *summary;

/**
 *  新闻图片链接
 */
@property (readonly, strong, nonatomic) VENewsImage *newsImage;

/**
 *  新闻来源
 */
@property (readonly, copy, nonatomic) NSString *origin;

/**
 *  时间
 */
@property (readonly, assign, nonatomic) NSTimeInterval createTime;

@end
