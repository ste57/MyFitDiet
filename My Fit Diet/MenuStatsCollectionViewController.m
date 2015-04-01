//
//  MenuStatsCollectionViewController.m
//  My Fit Diet
//
//  Created by Stephen Sowole on 31/03/2015.
//  Copyright (c) 2015 Stephen Sowole. All rights reserved.
//

#import "MenuStatsCollectionViewController.h"
#import "MenuStatsCollectionViewCell.h"
#import "Constants.h"
#import "OptionsView.h"

@interface MenuStatsCollectionViewController ()

@end

@implementation MenuStatsCollectionViewController {
    
    NSIndexPath *indexPathForDeviceOrientation;
    NSDate *currentSetDate;
    int previousPage;
}

static NSString * const reuseIdentifier = @"MenuStatsCell";
static int const numberOfPages = 3;

- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    currentSetDate = [NSDate date];
    
    previousPage = numberOfPages;
    
    [self setNavigationBarDateTitle];
    
    self.collectionView.pagingEnabled = YES;
    
    [self.collectionView registerClass:[MenuStatsCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self createOptionsView];
}

- (void) setNavigationBarDateTitle {
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    
    [dateFormat setDateFormat:@"EEE | dd MMMM yyyy"];
    
    int dayDiff = ceil([currentSetDate timeIntervalSinceNow] / (60*60*24));

    if (dayDiff == 0) {
        
        self.title = @"TODAY";
        
    } else if (dayDiff == -1) {
        
        self.title = @"YESTERDAY";
        
    } else if (dayDiff == 1) {
        
        self.title = @"TOMORROW";
        
    } else {
        
        self.title = [[NSString stringWithFormat:@"%@", [dateFormat stringFromDate:currentSetDate]] uppercaseString];
    }
}

- (void) createOptionsView {
    
    OptionsView *optionsView = [[OptionsView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 1.1, self.view.frame.size.height/OPTIONS_VIEW_HEIGHT_DIVISION_FACTOR)];
    
    optionsView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height);

    [self.view addSubview:optionsView];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 0.8);
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
    
    if (cell) {
        
        cell.layer.anchorPoint = CGPointMake(0.5, 0);
        
        cell.center = CGPointMake(cell.center.x, 0);

        [cell createLayout];
    }
    
    return cell;
}

#pragma mark - <UIScrollViewDelegate>

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    static CGFloat lastContentOffsetX = FLT_MIN;
    
    // We can ignore the first time scroll,
    // because it is caused by the call scrollToItemAtIndexPath: in ViewWillAppear
    
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    
    CGFloat pageWidth = scrollView.frame.size.width;
    CGFloat offset = pageWidth * numberOfPages;
    
    // the first page(showing the last item) is visible and user is still scrolling to the left
    if (currentOffsetX < pageWidth && lastContentOffsetX > currentOffsetX) {
        
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

- (void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGFloat pageWidth = scrollView.frame.size.width;
    
    int currentPage = (int)((self.collectionView.contentOffset.x + pageWidth / 2) / pageWidth);

    if (currentPage != previousPage) {

        if (currentPage == 1 && previousPage == 3) {
         
            [self moveDateForward];
            
        } else if (currentPage == 2 && previousPage == 1) {
            
            [self moveDateForward];
            
        } else if (currentPage == 3 && previousPage == 2) {
            
            [self moveDateForward];
        }
        
        
        else if (currentPage == 3 && previousPage == 1) {
            
            [self moveDateBack];
            
        } else if (currentPage == 2 && previousPage == 3) {
            
            [self moveDateBack];
            
        } else if (currentPage == 1 && previousPage == 2) {
            
            [self moveDateBack];
        }

        previousPage = currentPage;
    }
}

- (void) moveDateBack {
    
    currentSetDate = [currentSetDate dateByAddingTimeInterval:60*60*24*-1];
    [self setNavigationBarDateTitle];
}

- (void) moveDateForward {
    
    currentSetDate = [currentSetDate dateByAddingTimeInterval:60*60*24*1];
    [self setNavigationBarDateTitle];
}

- (void) didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
