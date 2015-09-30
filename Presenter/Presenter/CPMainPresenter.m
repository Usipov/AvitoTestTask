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
@property (strong, nonatomic) NSMutableSet *visibleInterfaceItems;

@end

@implementation CPMainPresenter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.visibleInterfaceItems = [NSMutableSet new];
    }
    return self;
}

#pragma mark - CVInterfaceEventsProtocol

- (void)didAppear {
    if (self.lastInteractorItems.count == 0)
        [self didRequestViewUpdate];
}

- (void)didRequestViewUpdate {
    [self cancelImageRequests];
    
    self.lastInteractorItems = nil;
    self.lastInterfaceItems = nil;
    
    [self.interface setBeingUpdated];
    [self.interactor clearImages];
    [self.interactor findItemsForPresenter];
}

- (void)didRequestTrashingThumbs {
    [self.interactor clearImages];
    [self.interactor stopFindingImages];
    [self updateView];
}

- (void)didRequestTrashingStore {
    [self.interactor clearStorage];
    [self didRequestViewUpdate];
}

- (void)willDisplayInterfaceItem:(CVInterfaceItem *)item {
    if (! item)
        return;
    
    [self.visibleInterfaceItems addObject:item];
    [self findImageForInterfaceItem:item];
}

- (void)didFinishDisplayingInterfaceItem:(CVInterfaceItem *)item {
    if (! item)
        return;
    
    [self.visibleInterfaceItems removeObject:item];
    
    // очищаем память. пусть на картинку ссылается только кэш
    item.image = nil;
    
    CNDataItem *interactorItem = [self exisingInteractorItemForInterfaceItem:item];
    if (interactorItem.image) {
        // очищаем память
        interactorItem.image = nil;
    } else {
        // заканчиваем подготовку картинки
        [self.interactor stopFindingImageForPresenterMatchingDataItem:interactorItem];
    }
}

#pragma mark - CNInteractorOutput

- (void)foundItemsForPresenter:(NSArray *)items {
    self.lastInteractorItems = items;
    self.lastInterfaceItems = [self interfaceItemsForInteractorItems:items];
    [self updateView];
}

- (void)foundNoItemsForPresenterDueToUnreachableInternet {
    [self.interface showNoInternetConnectionMessage];
}

- (void)internetBecameReachable {
    // нужно заново загрузить все данные
    if (self.lastInterfaceItems.count == 0) {
        [self didRequestViewUpdate];
        return;
    }
    
    // данные есть, но картинок может не быть
    for (CVInterfaceItem *visibleInterfaceItem in self.visibleInterfaceItems) {
        [self findImageForInterfaceItem:visibleInterfaceItem];
    }
}

- (void)foundImageForPresenterMatchingDataItem:(CNDataItem *)item {
    CVInterfaceItem *interfaceItem = [self exisingInterfaceItemForInteractorItem:item];
    interfaceItem.image = item.image;
    [self.interface updateViewForInterfaceItem:interfaceItem];
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

- (void)findImageForInterfaceItem:(CVInterfaceItem *)item {
    NSParameterAssert(item);
    CNDataItem *interactorItem = [self exisingInteractorItemForInterfaceItem:item];
    [self.interactor findImageForPresenterMatchingDataItem:interactorItem];
}

- (void)updateView {
    [self.interface showInterfaceItems:self.lastInterfaceItems];
    
    if (self.lastInterfaceItems.count == 0) {
        [self.interface showIsEmptyMessage];
    }
}

#pragma mark -

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
