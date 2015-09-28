//
//  CNDowloaderProtocol.h
//  Networking
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CNDowloaderProtocol <NSObject>

- (NSOperation *)dowloadDataFromURL:(NSString *)url completion:(DataBlock)block error:(ErrorBlock)errorBlock;

- (NSOperation *)downloadArrayFromURL:(NSString *)url completion:(ArrayBlock)block error:(ErrorBlock)errorBlock;

@end
