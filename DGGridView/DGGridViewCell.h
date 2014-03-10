//
//  DGGridViewCell.h
//  DGGridViewSample
//
//  Created by KDG on 2014. 3. 7..
//  Copyright (c) 2014년 302lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGGridViewCell : NSObject

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIColor *backgroundColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic) NSTextAlignment textAlignment;

@property (nonatomic) NSInteger startRow;
@property (nonatomic) NSInteger endRow;
@property (nonatomic) NSInteger startColumn;
@property (nonatomic) NSInteger endColumn;

- (void)setStartRow:(NSInteger)startRow endRow:(NSInteger)endRow startColumn:(NSInteger)startColumn endColumn:(NSInteger)endColumn;

@end
