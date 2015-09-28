//
//  CVLoadingView.m
//  View
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CVLoadingView.h"

@interface CVLoadingView ()
@property (strong, nonatomic) UIActivityIndicatorView *activity;
@end

@implementation CVLoadingView

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    if (self.superview)
        [self.activity startAnimating];
    else
        [self.activity stopAnimating];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
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
