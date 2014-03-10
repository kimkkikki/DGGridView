//
//  DGGridViewCell.m
//  DGGridViewSample
//
//  Created by KDG on 2014. 3. 7..
//  Copyright (c) 2014년 302lab. All rights reserved.
//

#import "DGGridViewCell.h"

@implementation DGGridViewCell

- (void)setStartRow:(NSInteger)startRow endRow:(NSInteger)endRow startColumn:(NSInteger)startColumn endColumn:(NSInteger)endColumn {
    _startRow = startRow;
    _endRow = endRow;
    _startColumn = startColumn;
    _endColumn = endColumn;
}

@end
