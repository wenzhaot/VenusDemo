//
//  VENews.h
//  Venus
//
//  Created by 谈文钊 on 4/13/16.
//  Copyright © 2016 caishi. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

/**
 *  新闻图片
 */
@interface VENewsImage : NSObject

/**
 *  是否为gif图片
 */
@property (assign, nonatomic) BOOL isGif;

/**
 *  图片宽度
 */
@property (assign, nonatomic) float width;

/**
 *  图片高度
 */
@property (assign, nonatomic) float height;

/**
 *  图片url
 */
@property (copy, nonatomic) NSString *url;

/**
 *  gif动图可以采用该地址
 */
@property (copy, nonatomic) NSString *src;


/**
 *  基于原图大小，按指定百分比缩放。其他相关规则可以参考http://developer.qiniu.com/code/v6/api/kodo-api/image/imagemogr2.html
 *
 *  @param scale 缩放比例，取值范围为0-100。
 *
 *  @return 处理后的链接
 */
- (NSString *)thumbnailUrlByScale:(float)scale;


/**
 *  当原图尺寸大于给定的宽度或高度时，按照给定宽高值缩小。否则返回原图。
 *
 *  @param size 指定尺寸大小
 *
 */
- (NSString *)thumbnailUrlWithSize:(CGSize)size;



@end





@interface VENews : NSObject

/**
 *  新闻唯一标识
 */
@property (copy, nonatomic) NSString *identifier;

/**
 *  新闻标题
 */
@property (copy, nonatomic) NSString *title;

/**
 *  新闻概要
 */
@property (copy, nonatomic) NSString *summary;

/**
 *  新闻图片
 */
@property (strong, nonatomic) VENewsImage *newsImage;

/**
 *  新闻来源
 */
@property (copy, nonatomic) NSString *origin;

/**
 *  时间
 */
@property (assign, nonatomic) NSTimeInterval createTime;

/**
 *  分享连接
 */
@property (copy, nonatomic) NSString *shareLink;

/**
 *  新闻类型
 */
@property (copy, nonatomic) NSString *newsType;

@end
