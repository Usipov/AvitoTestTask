//
//  CPMainPresenter.m
//  Presenter
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CPMainPresenter.h"

@interface CPMainPresenter ()
@property (strong, nonatomic) NSArray *lastInteractorItems;
@property (strong, nonatomic) NSArray *lastInterfaceItems;
@property (strong, nonatomic) Reachability *reachability;
@end

@implementation CPMainPresenter

#pragma mark - CVInterfaceEventsProtocol

- (instancetype)init {
    self = [super init];
    if (self) {
        self.reachability = [Reachability reachabilityForInternetConnection];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onReachabilityChanged:)
                                                     name:kReachabilityChangedNotification
                                                   object:nil];
    }
    return self;
}

- (void)didAppear {
    if (self.lastInteractorItems.count == 0)
        [self didRequestViewUpdate];
}

- (void)didRequestViewUpdate {
    [self cancelImageRequests];
    
    self.lastInteractorItems = nil;
    self.lastInterfaceItems = nil;
    
    if (! [self.reachability isReachable]) {
        [self.interface showNoInternetConnectionMessage];
        return;
    }
    
    [self.interface setBeingUpdated];
    [self.interactor clearImages];
    [self.interactor findItemsForPresenter];
}

- (void)didRequestTrashingThumbs {
    [self.interactor clearImages];
    [self.interactor stopFindingImages];
}

- (void)didRequestTrashingStore {
    [self.interactor clearStorage];
}

- (void)willDisplayInterfaceItem:(CVInterfaceItem *)item {
    CNDataItem *interactorItem = [self exisingInteractorItemForInterfaceItem:item];
    [self.interactor findImageForPresenterMatchingDataItem:interactorItem];
}

- (void)didDisplayInterfaceItem:(CVInterfaceItem *)item {
    if (item.image)
        return;
    
    CNDataItem *interactorItem = [self exisingInteractorItemForInterfaceItem:item];
    [self.interactor stopFindingImageForPresenterMatchingDataItem:interactorItem];
}

#pragma mark - CNInteractorOutput

- (void)foundItemsForPresenter:(NSArray *)items {
    self.lastInteractorItems = items;
    self.lastInterfaceItems = [self interfaceItemsForInteractorItems:items];
    if (self.lastInterfaceItems.count > 0) {
        [self.interface showInterfaceItems:self.lastInterfaceItems];
    } else {
        [self.interface showIsEmptyMessage];
    }
}
     
- (void)foundImageForPresenterMatchingDataItem:(CNDataItem *)item {
    CVInterfaceItem *interfaceItem = [self exisingInterfaceItemForInteractorItem:item];
    interfaceItem.image = item.image;
    [self.interface updateViewForInterfaceItem:interfaceItem];
}

#pragma mark - notifications

- (void)onReachabilityChanged:(NSNotification *)sender {
    if (self.lastInterfaceItems.count == 0)
        [self didRequestViewUpdate];
    
}

#pragma mark - privates

- (NSArray *)interfaceItemsForInteractorItems:(NSArray *)interactorItems {
    NSArray *result = [interactorItems bk_map:^id(CNDataItem *interactorItem) {
        CVInterfaceItem *item = [[CVInterfaceItem alloc] initWithId:interactorItem.id login:interactorItem.login];
        return item;
    }];
    return result;
}

- (CVInterfaceItem *)exisingInterfaceItemForInteractorItem:(CNDataItem *)item {
    if (! item)
        return nil;
    
    CVInterfaceItem *result = [self.lastInterfaceItems bk_match:^BOOL(CVInterfaceItem *interfaceItem) {
        return [interfaceItem.id isEqualToNumber:item.id];
    }];
    
    return result;
}

- (CNDataItem *)exisingInteractorItemForInterfaceItem:(CVInterfaceItem *)item {
    if (! item)
        return nil;
    
    CNDataItem *result = [self.lastInteractorItems bk_match:^BOOL(CNDataItem *interactorItem) {
        return [interactorItem.id isEqualToNumber:item.id];
    }];
    
    return result;
}

- (void)cancelImageRequests {
    [self.interactor stopFindingImages];
}

#pragma mark - 

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
