//
//  NewsDetailViewController.m
//  VenusTests
//
//  Created by 谈文钊 on 4/14/16.
//  Copyright © 2016 caishi. All rights reserved.
//

#import "NewsDetailViewController.h"
#import "PhotoBrowserViewController.h"
@import Venus;

@interface NewsDetailViewController ()<VENewsDetailViewDelegate>
@property (weak, nonatomic) IBOutlet VENewsDetailView *detailView;
@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.detailView startLoadContentWithNews:self.news];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - detailView delegate

- (void)detailViewWillLoadContent:(VENewsDetailView *)detailView {
    
}

- (void)detailViewDidLoadContent:(VENewsDetailView *)detailView {
    
}

- (void)detailView:(VENewsDetailView *)detailView didFailToLoadContentWithError:(NSError *)erorr {
    
}

- (void)detailView:(VENewsDetailView *)detailView didClickImageList:(NSArray *)imageList atIndex:(NSUInteger)index {
    PhotoBrowserViewController *browser = [[PhotoBrowserViewController alloc] init];
    browser.photoList = [NSArray arrayWithArray:imageList];
    browser.initalPageIndex = index;
    [self.navigationController pushViewController:browser animated:YES];
}

- (void)detailView:(VENewsDetailView *)detailView didClickOrigin:(NSString *)srcLink {
    NSLog(@"srcLink:%@", srcLink);
}

@end
