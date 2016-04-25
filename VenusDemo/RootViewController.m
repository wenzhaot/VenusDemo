//
//  RootViewController.m
//  VenusTests
//
//  Created by 谈文钊 on 4/13/16.
//  Copyright © 2016 caishi. All rights reserved.
//

#import "RootViewController.h"
#import "NewsListViewController.h"

@interface RootViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSArray *channels;
@property (strong, nonatomic) VENewsLoader *newsLoader;
@property (assign, nonatomic) NSUInteger selectedChannelItem;
@property (weak, nonatomic) NewsListViewController *listController;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.newsLoader = [[VENewsLoader alloc] init];
    [self loadChannels];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadChannels {
    [self.activityView startAnimating];
    [self.newsLoader loadChannelsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        [self.activityView stopAnimating];
        if (!error) {
            self.channels = [NSMutableArray arrayWithArray:array];
            [self.collectionView reloadData];
            
            if (self.channels.count) {
                VEChannel *channel = [self.channels firstObject];
                [self presentNewsListWithChannel:channel];
            }
        } else {
            [self alertWithError:error];
        }
    }];
}

- (void)alertWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error.userInfo objectForKey:NSLocalizedDescriptionKey]
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"OK" otherButtonTitles:@"Retry", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self loadChannels];
    }
}

- (void)presentNewsListWithChannel:(VEChannel *)channel {
    if (self.listController) {
        [self.listController.view removeFromSuperview];
        [self.listController removeFromParentViewController];
    }
    
    if (channel) {
        NewsListViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NewsListViewController"];
        vc.channel = channel;
        vc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        vc.view.frame = self.contentView.bounds;
        [self.contentView addSubview:vc.view];
        [self addChildViewController:vc];
        [vc didMoveToParentViewController:self];
        [self setListController:vc];
    }
    
}

// MARK: - collectionView dataSource & delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.channels count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ChannelCell" forIndexPath:indexPath];
    UILabel *label = (UILabel *)[cell viewWithTag:345];
    VEChannel *channel = self.channels[indexPath.item];
    label.text = channel.name;
    label.textColor = indexPath.item == self.selectedChannelItem ? [UIColor yellowColor] : [UIColor whiteColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedChannelItem = indexPath.item;
    [collectionView reloadData];
    
    VEChannel *channel = self.channels[indexPath.item];
    [self presentNewsListWithChannel:channel];
    
}

@end
