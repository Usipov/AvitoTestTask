//
//  CVEmptyView.m
//  View
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CVEmptyView.h"

@interface CVEmptyView ()
@property (strong, nonatomic) UIActivityIndicatorView *activity;
@end

@implementation CVEmptyView

- (void)didMoveToSuperview {
    if (self.superview)
        [self.activity startAnimating];
    else
        [self.activity stopAnimating];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview)
        [self.activity startAnimating];
    else
        [self.activity stopAnimating];
}

- (UIActivityIndicatorView *)activity {
    if (! _activity) {
        _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:_activity];
        WSELF;
        [_activity mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wself);
        }];
    }
    return _activity;
}

@end
