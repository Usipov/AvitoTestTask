//
//  CVNoInternetConnectionView.m
//  View
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CVNoInternetConnectionView.h"

@interface CVNoInternetConnectionView ()
@property (strong, nonatomic) UILabel *label;
@end

@implementation CVNoInternetConnectionView

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self label];
}

- (UILabel *)label {
    if (! _label) {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.text = @"No internet connection";
        [self addSubview:_label];
        WSELF;
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(wself);
        }];
    }
    return _label;
}


@end

