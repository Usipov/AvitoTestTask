//
//  CVViewController.m
//  View
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CVViewController.h"
#import "CVEmptyView.h"
#import "CVNoInternetConnectionView.h"
#import "CVLoadingView.h"
#import "CVTableViewCell.h"

@interface CVViewController ()
@property (strong, nonatomic) CVEmptyView *emptyView;
@property (strong, nonatomic) CVLoadingView *loadingView;
@property (strong, nonatomic) CVNoInternetConnectionView *noInternetView;
@property (strong, nonatomic) NSArray *interfaceItems;
@property (weak, nonatomic) UIView *topView;
@end

@implementation CVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Users";
    
    self.navigationItem.rightBarButtonItem
    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                    target:self
                                                    action:@selector(onRefreshTapped:)];
    
    UIBarButtonItem *deleteThumbsButtonItem
    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                    target:self
                                                    action:@selector(onTrashThumbsTapped:)];
    
    UIBarButtonItem *deleteStoreButtonItem
    = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                    target:self
                                                    action:@selector(onTrashStoreTapped:)];
    deleteStoreButtonItem.tintColor = [UIColor redColor];
    
    self.navigationItem.leftBarButtonItems = @[deleteStoreButtonItem, deleteThumbsButtonItem];
    
    // скрываем лишние разделители клеток
    self.tableView.tableFooterView = [UIView new];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.eventsHandler didAppear];
}

#pragma mark - CVInterfaceProtocol

- (void)showInterfaceItems:(NSArray *)interfaceItems {
    [self.emptyView removeFromSuperview];
    
    self.interfaceItems = interfaceItems;
    [self.tableView reloadData];
}

- (void)setBeingUpdated {
    [self showViewAboveTheTableView:self.loadingView];
}

- (void)showNoInternetConnectionMessage {
    [self showViewAboveTheTableView:self.noInternetView];
}

- (void)showIsEmptyMessage {
    [self showViewAboveTheTableView:self.emptyView];
}

- (void)updateViewForInterfaceItem:(CVInterfaceItem *)item {
    NSUInteger index = [self indexOfInterfaceItem:item];
    if (index == NSNotFound)
        return;

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    if ([self.tableView.indexPathsForVisibleRows containsObject:indexPath]) {
        CVTableViewCell *cell = [(id)self.tableView cellForRowAtIndexPath:indexPath];
        [self configureCell:cell withInterfaceItem:item];
        
        // чтобы imageView стал ненулевого размера, нужно подсказать клеточке, что что-то изменилось
        [cell setNeedsLayout];
    }
}

#pragma mark - private

- (CVInterfaceItem *)interfaceItemAtIndex:(NSUInteger)index {
    return self.interfaceItems.count > index ? self.interfaceItems[index] : nil;
}

- (NSUInteger)indexOfInterfaceItem:(CVInterfaceItem *)item {
    if (! item)
        return NSNotFound;
    
    return [self.interfaceItems indexOfObject:item];
}

- (void)showViewAboveTheTableView:(UIView *)view {
    if (! view)
        return;
    
    [self.topView removeFromSuperview];
    self.topView = view;
    
    [self.view addSubview:view];
    WSELF;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(wself.view);
    }];
    
    [self.view layoutIfNeeded];
    [self.topView layoutIfNeeded];
}

- (void)showConfirmationAlertWithMessage:(NSString *)message action:(BasicBlock)action {
    if (! action)
        return;
    if (! message)
        return;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [UIAlertView bk_showAlertViewWithTitle:@"Please confirm"
                                       message:message
                             cancelButtonTitle:@"NO"
                             otherButtonTitles:@[@"YES"]
                                       handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                           if (alertView.cancelButtonIndex != buttonIndex) {
                                               action();
                                           }
                                       }];
    }];
}


- (void)configureCell:(CVTableViewCell *)cell withInterfaceItem:(CVInterfaceItem *)item {
    cell.imageView.image = item.image;
    cell.textLabel.text = item.login;
}

#pragma mark - lazy properties

- (CVEmptyView *)emptyView {
    if (! _emptyView) {
        _emptyView = [[CVEmptyView alloc] initWithFrame:self.view.bounds];
    }
    return _emptyView;
}

- (CVLoadingView *)loadingView {
    if (! _loadingView) {
        _loadingView = [[CVLoadingView alloc] initWithFrame:self.view.bounds];
    }
    return _loadingView;
}

- (CVNoInternetConnectionView *)noInternetView {
    if (! _noInternetView) {
        _noInternetView = [[CVNoInternetConnectionView alloc] initWithFrame:self.view.bounds];
    }
    return _noInternetView;
}

#pragma mark - actions

- (void)onRefreshTapped:(UIBarButtonItem *)sender {
    WSELF;
    [self showConfirmationAlertWithMessage:@"Are you sure you want to refresh?" action:^{
        [wself.eventsHandler didRequestViewUpdate];
    }];
}

- (void)onTrashThumbsTapped:(UIBarButtonItem *)sender {
    WSELF;
    [self showConfirmationAlertWithMessage:@"Are you sure you want to delete images from disk and ram?" action:^{
        [wself.eventsHandler didRequestTrashingThumbs];
    }];
}

- (void)onTrashStoreTapped:(UIBarButtonItem *)sender {
    WSELF;
    [self showConfirmationAlertWithMessage:@"Are you sure you want to clear storage?" action:^{
        [wself.eventsHandler didRequestTrashingStore];
    }];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.interfaceItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    CVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (! cell) {
        cell = [[CVTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if (cell.indexPath) {
        CVInterfaceItem *previousItem = [self interfaceItemAtIndex:cell.indexPath.row];
        [self.eventsHandler didFinishDisplayingInterfaceItem:previousItem];
    }
    
    cell.indexPath = indexPath;

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CVInterfaceItem *item = [self interfaceItemAtIndex:indexPath.row];
    [self.eventsHandler willDisplayInterfaceItem:item];
    [self configureCell:(id)cell withInterfaceItem:item];
}

@end
