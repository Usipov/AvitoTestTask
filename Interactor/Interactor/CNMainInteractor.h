//
//  CNMainInteractor.h
//  Interactor
//
//  Created by Tim on 28.09.15.
//  Copyright (c) 2015 YusipovTimur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CNInteractorIO.h"
#import "CMDataStoring.h"
#import "CIImageCache.h"
#import "CNDownloader.h"

@interface CNMainInteractor : NSObject <CNInteractorInput>

@property (weak, nonatomic) id<CNInteractorOutput> outputReciever;
@property (strong, nonatomic) CMDataStoring *dataStoring;
@property (strong, nonatomic) CIImageCache *imageCache;
@property (strong, nonatomic) CNDownloader *downloader;

@end
