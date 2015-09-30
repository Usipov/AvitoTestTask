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
    
    return [self downloadObjectFromURL:url
                           withManager:manager
                       responseChecker:^BOOL(id responseObject) {
                           return [responseObject isKindOfClass:[NSData self]];
                       }
                            completion:block
                                 error:errorBlock];
}

- (NSOperation *)downloadArrayFromURL:(NSString *)url completion:(ArrayBlock)block error:(ErrorBlock)errorBlock {
    if (! block)
        return nil;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return [self downloadObjectFromURL:url
                           withManager:manager
                       responseChecker:^BOOL(id responseObject) {
                           return [responseObject isKindOfClass:[NSArray self]];
                       }
                            completion:block
                                 error:errorBlock];
    
}

- (NSOperation *)downloadImageFromURL:(NSString *)url completion:(IdBlock)block error:(ErrorBlock)errorBlock {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    
    return [self downloadObjectFromURL:url
                           withManager:manager
            responseChecker:^BOOL(id responseObject) {
                return [responseObject isKindOfClass:[UIImage self]];
            }
                            completion:block
                                 error:errorBlock];
}

#pragma mark - private

- (NSOperation *)downloadObjectFromURL:(NSString *)url
                           withManager:(AFHTTPRequestOperationManager *)manager
                       responseChecker:(BOOL (^) (id responseObject))responseChecker
                            completion:(IdBlock)block
                                 error:(ErrorBlock)errorBlock {
    if (! block)
        return nil;
    
    return [manager GET:url
             parameters:nil
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    BOOL willSubmitResult = YES;
                    if (responseChecker) {
                        willSubmitResult = responseChecker(responseObject);
                    }
                    
                    if (willSubmitResult) {
                        block(responseObject);
                    } else {
                        if (errorBlock) {
                            errorBlock([NSError errorWithDomain:@"CNDownloader.badResponse" code:0 userInfo:nil]);
                        }
                    }
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    if (errorBlock) {
                        errorBlock(error);
                    }
                }];
    
}

@end
