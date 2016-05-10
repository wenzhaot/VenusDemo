//
//  PhotoBrowserViewController.m
//  VenusTests
//
//  Created by 谈文钊 on 5/5/16.
//  Copyright © 2016 caishi. All rights reserved.
//

#import "PhotoBrowserViewController.h"
#import "UIImageView+WebCache.h"
@import Venus;

@interface PhotoViewController : UIViewController
@property (copy, nonatomic) NSString *urlString;
@property (assign, nonatomic) NSUInteger index;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIActivityIndicatorView *activityView;
@end

@implementation PhotoViewController

- (void)loadView {
    [super loadView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.activityView.center = self.view.center;
    self.activityView.hidesWhenStopped = YES;
    [self.view addSubview:self.activityView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.activityView startAnimating];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.urlString]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 [self.activityView stopAnimating];
                             }];
    
}

@end




@interface PhotoBrowserViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) UIPageControl *pageControl;
@end

@implementation PhotoBrowserViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    // add page controller
    [self.pageController.view setFrame:self.view.bounds];
    [self.view addSubview:self.pageController.view];
    [self addChildViewController:self.pageController];
    [self.pageController didMoveToParentViewController:self];
    [self.view addSubview:self.pageControl];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *viewControllers = @[[self photoViewControllerAtIndex:self.initalPageIndex]];
    [self.pageController setViewControllers:viewControllers
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:NULL];
    
    [self.pageControl setNumberOfPages:[self numberOfPhotos]];
    [self.pageControl setCurrentPage:self.initalPageIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (PhotoViewController *)photoViewControllerAtIndex:(NSUInteger)index {
    PhotoViewController *photoVC = [[PhotoViewController alloc] init];
    photoVC.index = index;
    
    VENewsImage *newsImage = self.photoList[index];
    photoVC.urlString = newsImage.src;
    return photoVC;
}

- (NSInteger)numberOfPhotos {
    return [self.photoList count];
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(PhotoViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self photoViewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(PhotoViewController *)viewController index];
    
    index++;
    
    if (index == [self numberOfPhotos]) {
        return nil;
    }
    
    return [self photoViewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

- (void)pageViewController:(UIPageViewController *)pvc didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
    if (!completed) {
        return;
    }
    NSUInteger currentIndex = [[self.pageController.viewControllers lastObject] index];
    self.pageControl.currentPage = currentIndex;
}

- (UIPageViewController *)pageController {
    if (!_pageController) {
        _pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                                                          navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                        options:@{UIPageViewControllerOptionInterPageSpacingKey : @(10)}];
        _pageController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _pageController.dataSource = self;
        _pageController.delegate = self;
    }
    return _pageController;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        CGFloat height = 44;
        CGRect rect = CGRectMake(0, self.view.frame.size.height-height, self.view.frame.size.width, height);
        _pageControl = [[UIPageControl alloc] initWithFrame:rect];
        _pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        _pageControl.hidesForSinglePage = YES;
        _pageControl.defersCurrentPageDisplay = YES;
    }
    return _pageControl;
}

@end
