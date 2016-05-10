//
//  VENewsDetailView.h
//  Venus
//
//  Created by 谈文钊 on 4/13/16.
//  Copyright © 2016 caishi. All rights reserved.
//

#import <UIKit/UIKit.h>


@class VENews;
@protocol VENewsDetailViewDelegate;

@interface VENewsDetailView : UIView

@property (weak, nonatomic) IBOutlet id<VENewsDetailViewDelegate> delegate;

@property (readonly, strong, nonatomic) UIWebView *webView;

/**
 *  是否显示查看原文按钮,如果YES则可实现delegate中的方法进行处理
 */
@property (assign, nonatomic) BOOL originDisplay;

/**
 *  开始加载新闻内容
 *
 *  @param news 传入news对象
 */
- (void)startLoadContentWithNews:(VENews *)news;

/**
 *  获取shareLink
 */
- (NSString *)getShareLink;

@end



@protocol VENewsDetailViewDelegate <NSObject>
@optional

/**
 *  新闻内容获取成功，即将开始展示
 *
 */
- (void)detailViewWillLoadContent:(VENewsDetailView *)detailView;

/**
 *  新闻内容展示成功
 *
 */
- (void)detailViewDidLoadContent:(VENewsDetailView *)detailView;

/**
 *  新闻内容展示失败
 *
 */
- (void)detailView:(VENewsDetailView *)detailView didFailToLoadContentWithError:(NSError *)erorr;

/**
 *  点击新闻内容中图片
 *
 *  @param imageList  所有图片列表，方便做相册展示
 *  @param index      当前点击图片下标
 */
- (void)detailView:(VENewsDetailView *)detailView didClickImageList:(NSArray *)imageList atIndex:(NSUInteger)index;

/**
 *  点击新闻内容中“查看原文”按钮
 *
 *  @param srcLink     原文链接
 */
- (void)detailView:(VENewsDetailView *)detailView didClickOrigin:(NSString *)srcLink;

@end
