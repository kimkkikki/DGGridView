//
//  DGGridView.h
//  DGGridViewSample
//
//  Created by KDG on 2014. 3. 7..
//  Copyright (c) 2014년 302lab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DGGridViewCell.h"

@class DGGridView;

@protocol DGGridViewDelegate <NSObject>

@required

- (NSInteger)numberOfRowsInGridView:(DGGridView *)gridView;
- (NSInteger)numberOfColumnsInGridView:(DGGridView *)gridView;
- (NSInteger)numberOfCellsInGridView:(DGGridView *)gridView;
- (DGGridViewCell *)gridView:(DGGridView *)gridView cellForIndex:(NSInteger)index;

- (NSString *)gridView:(DGGridView *)gridView titleForLeftScrollViewAtIndex:(NSInteger)index;
- (NSString *)gridView:(DGGridView *)gridView titleForTopScrollViewAtIndex:(NSInteger)index;

@optional
- (CGFloat)gridView:(DGGridView *)gridView heightForRowAtIndex:(NSInteger)index;
- (CGFloat)gridView:(DGGridView *)gridView widthForColumnAtIndex:(NSInteger)index;
- (CGFloat)heightForTopScrollViewInGridView:(DGGridView *)gridView;
- (CGFloat)widthForLeftScrollViewInGridView:(DGGridView *)gridView;

- (UIView *)gridView:(DGGridView *)gridView viewForLeftScrollViewAtIndex:(NSInteger)index;
- (UIView *)gridView:(DGGridView *)gridView viewForTopScrollViewAtIndex:(NSInteger)index;

- (void)gridView:(DGGridView *)gridView didSelectedCellAtIndex:(NSInteger)index;
- (CGFloat)gridViewThicknessOfLine:(DGGridView *)gridView;

@end

@interface DGGridView : UIView

@property (nonatomic, weak) id <DGGridViewDelegate> delegate;

- (id)initWithDelegate:(id <DGGridViewDelegate>)delegate frame:(CGRect)frame;
- (void)reloadGridView;

@end
