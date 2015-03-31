//
//  MenuStatsCollectionViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 31/03/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "MenuStatsCollectionViewController.h"
#import "MenuStatsCollectionViewCell.h"

@interface MenuStatsCollectionViewController ()

@end

@implementation MenuStatsCollectionViewController {
    
    NSIndexPath *indexPathForDeviceOrientation;
}

static NSString * const reuseIdentifier = @"MenuStatsCell";
static int const numberOfPages = 1;

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    self.collectionView.pagingEnabled = YES;
    
    [self.collectionView registerClass:[MenuStatsCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self createOptionsView];
}

- (void) createOptionsView {
    
    /*UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 200.0)];
    view.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view];
    
    
    /*UIButton *postButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     
     postButton.frame = CGRectMake(0, 0, 50.0, 30.0);
     
     //postButton.center = CGPointMake(0,0);
     
     postButton.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:19.0];
     
     [postButton setTitle:@"Post" forState:UIControlStateNormal];
     
     [postButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     
     //[postButton addTarget:self action:@selector(postMumble) forControlEvents:UIControlEventTouchUpInside];
     
     [view addSubview:postButton];*/
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    // scroll to the 2nd page, which is showing the first item.
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        // scroll to the first page, note that this call will trigger scrollViewDidScroll: once and only once
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    });
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height * 0.8);
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0f;
}

- (UIEdgeInsets) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
         insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0.0f;
}

#pragma mark - UIInterfaceOrientation

- (void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    
    indexPathForDeviceOrientation = [[self.collectionView indexPathsForVisibleItems] firstObject];
    
    [[self.collectionView collectionViewLayout] invalidateLayout];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self.collectionView scrollToItemAtIndexPath:indexPathForDeviceOrientation atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return numberOfPages;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (numberOfPages + 2);
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuStatsCollectionViewCell *cell = (MenuStatsCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.layer.anchorPoint = CGPointMake(0.5, 0);
    
    cell.center = CGPointMake(cell.center.x, 0);
    
    cell.backgroundColor = [UIColor whiteColor];
    
    [cell createLayout];
    
    return cell;
}

#pragma mark - <UIScrollViewDelegate>

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    static CGFloat lastContentOffsetX = FLT_MIN;
    
    // We can ignore the first time scroll,
    // because it is caused by the call scrollToItemAtIndexPath: in ViewWillAppear
    if (FLT_MIN == lastContentOffsetX) {
        lastContentOffsetX = scrollView.contentOffset.x;
        return;
    }
    
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    
    CGFloat offset = scrollView.frame.size.width;
    
    // the first page(showing the last item) is visible and user is still scrolling to the left
    if (currentOffsetX < offset && lastContentOffsetX > currentOffsetX) {
        lastContentOffsetX = currentOffsetX + offset;
        scrollView.contentOffset = (CGPoint){lastContentOffsetX, currentOffsetY};
    }
    
    // the last page (showing the first item) is visible and the user is still scrolling to the right
    else if (currentOffsetX > offset && lastContentOffsetX < currentOffsetX) {
        
        lastContentOffsetX = currentOffsetX - offset;
        scrollView.contentOffset = (CGPoint){lastContentOffsetX, currentOffsetY};
        
    } else {
        
        lastContentOffsetX = currentOffsetX;
    }
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
