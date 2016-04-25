//
//  NewsDetailViewController.m
//  VenusTests
//
//  Created by 谈文钊 on 4/14/16.
//  Copyright © 2016 caishi. All rights reserved.
//

#import "NewsDetailViewController.h"

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
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"click (%ld/%ld)", index+1, imageList.count]
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}


@end
