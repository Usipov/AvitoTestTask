//
//  CVInterfaceProtocol.h
//  View
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVInterfaceItem.h"

@protocol CVInterfaceProtocol <NSObject>

- (void)setBeingUpdated;

- (void)showInterfaceItems:(NSArray *)interfaceItems;

- (void)updateViewForInterfaceItem:(CVInterfaceItem *)item;

@end
