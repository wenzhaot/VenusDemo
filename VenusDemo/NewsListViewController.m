//
//  NewsListViewController.m
//  VenusTests
//
//  Created by 谈文钊 on 4/13/16.
//  Copyright © 2016 caishi. All rights reserved.
//

#import "NewsListViewController.h"
#import "NewsDetailViewController.h"
#import "UIImageView+WebImage.h"

@interface NewsListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;
@property (strong, nonatomic) NSMutableArray *newsList;
@property (strong, nonatomic) VENewsLoader *newsLoader;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation NewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(loadNews) forControlEvents:UIControlEventValueChanged];
    
    self.newsLoader = [[VENewsLoader alloc] init];
    [self.refreshControl beginRefreshing];
    [self loadNews];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadNews {
    [self.newsLoader loadNewsInBackgroundWithChannel:self.channel pageSize:20 block:^(NSArray *array, NSError *error) {
        [self.refreshControl endRefreshing];
        if (!error) {
            if (self.newsList) {
                [self.newsList addObjectsFromArray:array];
            } else {
                self.newsList = [NSMutableArray arrayWithArray:array];
            }
            [self.tableView reloadData];
        } else {
            [self alertWithError:error];
        }
    }];
}

- (void)alertWithError:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error.userInfo objectForKey:NSLocalizedDescriptionKey]
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NewsDetailViewController *detailVC = [segue destinationViewController];
        detailVC.news = self.newsList[[self.tableView indexPathForCell:sender].row];
    }
}

// MARK: - tableView dataSource & delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:345];
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:346];
    UILabel *summaryLabel = (UILabel *)[cell.contentView viewWithTag:347];
    VENews *news = self.newsList[indexPath.row];
    [imageView loadImageWithURLString:news.newsImage.url];
    [titleLabel setText:news.title];
    [summaryLabel setText:news.summary];
    return cell;
}


@end
