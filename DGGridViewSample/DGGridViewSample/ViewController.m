//
//  ViewController.m
//  DGGridViewSample
//
//  Created by KDG on 2014. 3. 7..
//  Copyright (c) 2014년 302lab. All rights reserved.
//

#import "ViewController.h"
#import "DGGridView.h"

@interface ViewController () <DGGridViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DGGridView *gridView = [[DGGridView alloc] initWithDelegate:self frame:self.view.frame];
    [self.view addSubview:gridView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - DGGridView Delegate

- (NSInteger)numberOfCellsInGridView:(DGGridView *)gridView {
    return 5;
}

- (NSInteger)numberOfColumnsInGridView:(DGGridView *)gridView {
    return 10;
}

- (NSInteger)numberOfRowsInGridView:(DGGridView *)gridView {
    return 15;
}

- (NSString *)gridView:(DGGridView *)gridView titleForLeftScrollViewAtIndex:(NSInteger)index {
    return @"left";
}

- (NSString *)gridView:(DGGridView *)gridView titleForTopScrollViewAtIndex:(NSInteger)index {
    return @"top";
}

- (DGGridViewCell *)gridView:(DGGridView *)gridView cellForIndex:(NSInteger)index {
    DGGridViewCell *cell = [[DGGridViewCell alloc] init];
    [cell setStartRow:1 endRow:2 startColumn:1 endColumn:2];
    [cell setBackgroundColor:[UIColor redColor]];
    [cell setText:@"test"];
    [cell setTextColor:[UIColor yellowColor]];
    
    return cell;
}

@end
