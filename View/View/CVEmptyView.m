//
//  CVEmptyView.m
//  View
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CVEmptyView.h"

@interface CVEmptyView ()
@property (strong, nonatomic) UILabel *label;
@end

@implementation CVEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizesSubviews = NO;
        self.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
        self.layer.cornerRadius = 10;
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self label];
}

- (UILabel *)label {
    if (! _label) {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.backgroundColor = [UIColor clearColor];
        _label.text = @"No data";
        _label.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_label];
        WSELF;
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wself);
        }];
    }
    return _label;
}


@end
