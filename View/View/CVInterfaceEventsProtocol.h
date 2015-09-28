//
//  CVInterfaceEventsProtocol.h
//  View
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CVInterfaceEventsProtocol <NSObject>

- (void)didRequestViewUpdate;

- (void)didRequestTrashingThumbs;

- (void)didRequestTrashingStore;

@end
