//
//  DGGridView.m
//  DGGridViewSample
//
//  Created by KDG on 2014. 3. 7..
//  Copyright (c) 2014년 302lab. All rights reserved.
//

#import "DGGridView.h"

#define DEFAULT_ROW_HEIGHT 44.0
#define DEFAULT_COLUMN_WIDTH 100.0
#define DEFAULT_TOP_SCROLL_VIEW_HEIGHT 50.0
#define DEFAULT_LEFT_SCROLL_VIEW_WIDTH 120.0

@interface DGGridView () <UIScrollViewDelegate>

@property (nonatomic) NSInteger rowCount;
@property (nonatomic) NSInteger columnCount;
@property (nonatomic) NSInteger cellCount;
@property (nonatomic) CGFloat topHeight;
@property (nonatomic) CGFloat leftWidth;
@property (nonatomic) CGFloat rowHeight;
@property (nonatomic) CGFloat columnWidth;

@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, strong) UIScrollView *leftScrollView;
@property (nonatomic, strong) UIScrollView *mainGridView;

@end

@implementation DGGridView

#pragma mark - Initialize

- (void)setDelegate:(id<DGGridViewDelegate>)delegate {
    _delegate = delegate;
    
    [self initilize];
}

- (id)initWithDelegate:(id <DGGridViewDelegate>)delegate frame:(CGRect)frame {
    if (self = [super init]) {
        _delegate = delegate;
        self.frame = frame;
        
        [self initilize];
    }
    
    return self;
}

- (void)reloadGridView {
    for (UIView *view in _topScrollView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in _leftScrollView.subviews) {
        [view removeFromSuperview];
    }
    for (UIView *view in _mainGridView.subviews) {
        [view removeFromSuperview];
    }
    
    [self initilize];
}

- (void)initilize {
    _rowCount = [self.delegate numberOfRowsInGridView:self];
    _columnCount = [self.delegate numberOfColumnsInGridView:self];
    _cellCount = [self.delegate numberOfCellsInGridView:self];
    
    if ([self.delegate respondsToSelector:@selector(heightForTopScrollViewInGridView:)]) {
        _topHeight = [self.delegate heightForTopScrollViewInGridView:self];
    } else {
        _topHeight = DEFAULT_TOP_SCROLL_VIEW_HEIGHT;
    }
    
    if ([self.delegate respondsToSelector:@selector(widthForLeftScrollViewInGridView:)]) {
        _leftWidth = [self.delegate widthForLeftScrollViewInGridView:self];
    } else {
        _leftWidth = DEFAULT_LEFT_SCROLL_VIEW_WIDTH;
    }
    
    [self initTopScrollView];
    
    [self initLeftScrollView];
    
    [self initMainGridView];
}

- (void)initTopScrollView {
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(_leftWidth, 0, self.frame.size.width - _leftWidth, _topHeight)];
    [_topScrollView setDelegate:self];
    [_topScrollView setBounces:NO];
    
    for (int i = 0; i < _columnCount; i++) {
        CGFloat width;
        if ([self.delegate respondsToSelector:@selector(gridView:widthForColumnAtIndex:)]) {
            width = [self.delegate gridView:self widthForColumnAtIndex:i];
        } else {
            width = DEFAULT_COLUMN_WIDTH;
        }
        
        if ([self.delegate respondsToSelector:@selector(gridView:viewForTopScrollViewAtIndex:)]) {
            UIView *view = [self.delegate gridView:self viewForTopScrollViewAtIndex:i];
            [_topScrollView addSubview:view];
        } else {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(_topScrollView.contentSize.width, 0, width, _topHeight)];
            NSString *string = [self.delegate gridView:self titleForTopScrollViewAtIndex:i];
            [label setText:string];
            [label setTextAlignment:NSTextAlignmentCenter];
            [_topScrollView addSubview:label];
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(_topScrollView.contentSize.width, 0, 0.5, _topHeight)];
        [line setBackgroundColor:[UIColor darkGrayColor]];
        [_topScrollView addSubview:line];
        
        [_topScrollView setContentSize:CGSizeMake(_topScrollView.contentSize.width + width, _topHeight)];
    }
    
    [self addSubview:_topScrollView];
}

- (void)initLeftScrollView {
    _leftScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _topHeight, _leftWidth, self.frame.size.height - _topHeight)];
    [_leftScrollView setDelegate:self];
    [_leftScrollView setBounces:NO];
    
    for (int i = 0; i < _rowCount; i++) {
        CGFloat height;
        if ([self.delegate respondsToSelector:@selector(gridView:heightForRowAtIndex:)]) {
            height = [self.delegate gridView:self heightForRowAtIndex:i];
        } else {
            height = DEFAULT_ROW_HEIGHT;
        }
        
        if ([self.delegate respondsToSelector:@selector(gridView:viewForLeftScrollViewAtIndex:)]) {
            UIView *view = [self.delegate gridView:self viewForLeftScrollViewAtIndex:i];
            [_leftScrollView addSubview:view];
        } else {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, _leftScrollView.contentSize.height, _leftWidth, height)];
            NSString *string = [self.delegate gridView:self titleForLeftScrollViewAtIndex:i];
            [label setText:string];
            [label setTextAlignment:NSTextAlignmentCenter];
            [_leftScrollView addSubview:label];
        }
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _leftScrollView.contentSize.height, _leftWidth, 0.5)];
        [line setBackgroundColor:[UIColor darkGrayColor]];
        [_leftScrollView addSubview:line];
        
        [_leftScrollView setContentSize:CGSizeMake(_leftWidth, _leftScrollView.contentSize.height + height)];
    }
    
    [self addSubview:_leftScrollView];
}

- (CGRect)getCellFrame:(DGGridViewCell *)cell {
    NSInteger cellx = 0, cellWidth = 0, celly = 0, cellHeight = 0;
    for (int i = 0; i < cell.startColumn; i++) {
        NSInteger width;
        if ([self.delegate respondsToSelector:@selector(gridView:widthForColumnAtIndex:)]) {
            width = [self.delegate gridView:self widthForColumnAtIndex:i];
        } else {
            width = DEFAULT_COLUMN_WIDTH;
        }
        cellx += width;
    }
    
    for (int i = cell.startColumn; i < cell.endColumn; i++) {
        NSInteger width;
        if ([self.delegate respondsToSelector:@selector(gridView:widthForColumnAtIndex:)]) {
            width = [self.delegate gridView:self widthForColumnAtIndex:i];
        } else {
            width = DEFAULT_COLUMN_WIDTH;
        }
        cellWidth += width;
    }
    
    for (int i = 0; i < cell.startRow; i++) {
        NSInteger height;
        if ([self.delegate respondsToSelector:@selector(gridView:heightForRowAtIndex:)]) {
            height = [self.delegate gridView:self heightForRowAtIndex:i];
        } else {
            height = DEFAULT_ROW_HEIGHT;
        }
        celly += height;
    }
    
    for (int i = cell.startRow; i < cell.endRow; i++) {
        NSInteger height;
        if ([self.delegate respondsToSelector:@selector(gridView:heightForRowAtIndex:)]) {
            height = [self.delegate gridView:self heightForRowAtIndex:i];
        } else {
            height = DEFAULT_ROW_HEIGHT;
        }
        cellHeight += height;
    }
    
    return CGRectMake(cellx, celly, cellWidth, cellHeight);
}

- (void)drawLineForMainGridView {
    NSInteger x = 0, y = 0;
    for (int i = 0; i < _columnCount; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 0.5, _mainGridView.contentSize.height)];
        [line setBackgroundColor:[UIColor darkGrayColor]];
        [_mainGridView addSubview:line];
        
        NSInteger width;
        if ([self.delegate respondsToSelector:@selector(gridView:widthForColumnAtIndex:)]) {
            width = [self.delegate gridView:self widthForColumnAtIndex:i];
        } else {
            width = DEFAULT_COLUMN_WIDTH;
        }
        
        x += width;
    }
    for (int i = 0; i < _rowCount; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, y, _mainGridView.contentSize.width, 0.5)];
        [line setBackgroundColor:[UIColor darkGrayColor]];
        [_mainGridView addSubview:line];
        
        NSInteger height;
        if ([self.delegate respondsToSelector:@selector(gridView:heightForRowAtIndex:)]) {
            height = [self.delegate gridView:self heightForRowAtIndex:i];
        } else {
            height = DEFAULT_ROW_HEIGHT;
        }
        
        y += height;
    }
}

- (void)didSelectedCell:(id)sender {
    if ([self.delegate respondsToSelector:@selector(gridView:didSelectedCellAtIndex:)]) {
        UIButton *button = (UIButton *)sender;
        [self.delegate gridView:self didSelectedCellAtIndex:button.tag];
    }
}

- (void)initMainGridView {
    _mainGridView = [[UIScrollView alloc] initWithFrame:CGRectMake(_leftWidth, _topHeight, self.frame.size.width - _leftWidth, self.frame.size.height - _topHeight)];
    [_mainGridView setDelegate:self];
    [_mainGridView setBounces:NO];
    
    [_mainGridView setContentSize:CGSizeMake(_topScrollView.contentSize.width, _leftScrollView.contentSize.height)];
    
    [self drawLineForMainGridView];
    
    for (int i = 0; i < _cellCount; i++) {
        DGGridViewCell *cell = [self.delegate gridView:self cellForIndex:i];
        CGRect cellFrame = [self getCellFrame:cell];
        
        UIButton *button = [[UIButton alloc] initWithFrame:cellFrame];
        [button setTag:i];
        [button addTarget:self action:@selector(didSelectedCell:) forControlEvents:UIControlEventTouchUpInside];
        
        if (cell.backgroundColor != nil) {
            [button setBackgroundColor:cell.backgroundColor];
        }
        
        if (cell.text != nil) {
            [button setTitle:cell.text forState:UIControlStateNormal];
        }
        
        if (cell.textAlignment) {
            [button.titleLabel setTextAlignment:cell.textAlignment];
        }
        
        if (cell.textColor != nil) {
            [button.titleLabel setTextColor:cell.textColor];
        }
        
        if (cell.font != nil) {
            [button.titleLabel setFont:cell.font];
        }
        
        [_mainGridView addSubview:button];
    }
    
    [self addSubview:_mainGridView];
}

#pragma mark - UIScrollViewDelegate {
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isEqual:_leftScrollView]) {
        [_mainGridView setContentOffset:CGPointMake(_mainGridView.contentOffset.x, scrollView.contentOffset.y)];
    } else if ([scrollView isEqual:_mainGridView]) {
        [_leftScrollView setContentOffset:CGPointMake(0, scrollView.contentOffset.y)];
        [_topScrollView setContentOffset:CGPointMake(scrollView.contentOffset.x, 0)];
    } else {
        [_mainGridView setContentOffset:CGPointMake(scrollView.contentOffset.x, _mainGridView.contentOffset.y)];
    }
}

@end
