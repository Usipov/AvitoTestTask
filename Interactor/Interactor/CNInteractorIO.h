//
//  CNInteractorIO.h
//  Interactor
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "CNDataItem.h"

@protocol CNInteractorInput <NSObject>
- (void)findItemsForPresenter;
- (void)findImageForPresenterMatchingDataItem:(CNDataItem *)item;
- (void)clearStorage;
- (void)clearImages;
- (void)stopFindingImages;
@end

@protocol CNInteractorOutput <NSObject>
- (void)foundItemsForPresenter:(NSArray *)items;
- (void)foundImageForPresenterMatchingDataItem:(CNDataItem *)item;
@end
