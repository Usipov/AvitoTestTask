//
//  CNDownloader.m
//  Networking
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import "CNDownloader.h"

@implementation CNDownloader

- (NSOperation *)dowloadDataFromURL:(NSString *)url completion:(DataBlock)block error:(ErrorBlock)errorBlock {
    if (! block)
        return nil;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    return [self dowloadObjectFromURL:url
                          withManager:manager
                           completion:^(id obj) {
                               NSData *data = [obj isKindOfClass:[NSData self]] ? obj : nil;
                               block(data);
                           } error:^(NSError *error) {
                               if (errorBlock) {
                                   errorBlock(error);
                               }
                           }];
}

- (NSOperation *)dowloadArrayFromURL:(NSString *)url completion:(ArrayBlock)block error:(ErrorBlock)errorBlock {
    if (! block)
        return nil;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    return [self dowloadObjectFromURL:url
                          withManager:manager
                           completion:^(id obj) {
                               NSArray *array = [obj isKindOfClass:[NSArray self]] ? obj : nil;
                               block(array);
                           } error:^(NSError *error) {
                               if (errorBlock) {
                                   errorBlock(error);
                               }
                           }];
    
}

- (NSOperation *)dowloadObjectFromURL:(NSString *)url
                          withManager:(AFHTTPRequestOperationManager *)manager
                           completion:(IdBlock)block
                                error:(ErrorBlock)errorBlock {
    if (! block)
        return nil;
    
    return [manager GET:url
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    block(responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    if (errorBlock) {
                        errorBlock(error);
                    }
                }];
    
}

@end
