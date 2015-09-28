//
//  CVViewController.h
//  View
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CVInterfaceProtocol.h"
#import "CVInterfaceEventsProtocol.h"

@interface CVViewController : UITableViewController <CVInterfaceProtocol>

@property (strong, nonatomic) id<CVInterfaceEventsProtocol> eventsHandler;

@end
