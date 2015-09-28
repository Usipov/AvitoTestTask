//
//  CVViewController.m
//  View
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CVViewController.h"
#import "CVEmptyView.h"

@interface CVViewController ()
@property (strong, nonatomic) CVEmptyView *emptyView;
@property (strong, nonatomic) NSArray *interfaceItems;
@end

@implementation CVViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.emptyView = [CVEmptyView new];
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
}

- (void)setBeingUpdated {
    [self.view addSubview:self.emptyView];
}

- (void)showInterfaceItems:(NSArray *)interfaceItems {
    [self.emptyView removeFromSuperview];
    
    self.interfaceItems = interfaceItems;
    [self.tableView reloadData];
}

- (void)updateViewForInterfaceItem:(CVInterfaceItem *)item {
    NSUInteger index = [self indexOfInterfaceItem:item];
    if (index == NSNotFound)
        return;
    
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]
                          withRowAnimation:UITableViewRowAnimationFade];
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

#pragma mark - actions 

- (void)onRefreshTapped:(UIBarButtonItem *)sender {
    [self.eventsHandler didRequestViewUpdate];
}

- (void)onTrashThumbsTapped:(UIBarButtonItem *)sender {
    [self.eventsHandler didRequestTrashingThumbs];
}

- (void)onTrashStoreTapped:(UIBarButtonItem *)sender {
    [self.eventsHandler didRequestTrashingStore];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    CVInterfaceItem *item = [self interfaceItemAtIndex:indexPath.row];
    cell.imageView.image = item.image;
    cell.textLabel.text = item.login;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

@end
