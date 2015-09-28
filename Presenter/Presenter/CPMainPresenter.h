//
//  CPMainPresenter.h
//  Presenter
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNInteractorIO.h"
#import "CVInterfaceEventsProtocol.h"

@interface CPMainPresenter : NSObject <CVInterfaceEventsProtocol, CNInteractorOutput>

@property (weak, nonatomic) id<CVInterfaceProtocol> interface;
@property (strong, nonatomic) id<CNInteractorInput> interactor;

@end
