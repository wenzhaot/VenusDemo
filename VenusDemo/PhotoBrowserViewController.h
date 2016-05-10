//
//  PhotoBrowserViewController.h
//  VenusTests
//
//  Created by 谈文钊 on 5/5/16.
//  Copyright © 2016 caishi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoBrowserViewController : UIViewController

@property (strong, nonatomic) NSArray *photoList;
@property (assign, nonatomic) NSUInteger initalPageIndex;

@end
