//
//  UIImageView+WebImage.m
//  VenusTests
//
//  Created by 谈文钊 on 4/14/16.
//  Copyright © 2016 caishi. All rights reserved.
//

#import "UIImageView+WebImage.h"
#import <objc/runtime.h>

char sessionAddress;
char dataTaskAddress;

@interface UIImageView ()
@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSURLSessionDataTask *dataTask;
@end

@implementation UIImageView (WebImage)

- (void)loadImageWithURLString:(NSString *)URLString {
    if (self.dataTask) {
        [self.dataTask cancel];
    }
    if (!self.session) {
        self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    }
    self.image = nil;
    self.dataTask = [self.session dataTaskWithURL:[NSURL URLWithString:URLString] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error && data != nil) {
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.image = image;
            });
        }
    }];
    [self.dataTask resume];
}

// MARK: - Getter & Setter

- (NSURLSession *)session {
    return objc_getAssociatedObject(self, &sessionAddress);
}

- (void)setSession:(NSURLSession *)session {
    objc_setAssociatedObject(self, &sessionAddress, session, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURLSessionDataTask *)dataTask {
    return objc_getAssociatedObject(self, &dataTaskAddress);
}

- (void)setDataTask:(NSURLSessionDataTask *)dataTask {
    return objc_setAssociatedObject(self, &dataTaskAddress, dataTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
