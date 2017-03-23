//
//  OMDBService.h
//  OMDb
//
//  Created by Zup Beta on 13/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "MoviePropertyObject.h"


@interface OMDBService : NSObject

+ (instancetype)defaultService;

- (void)fetchMovies:(NSString *)query page:(NSString *)page success:(void (^)(NSArray<MoviePropertyObject *> *))success error:(void (^)(NSURLSessionDataTask *task, NSError *error))error;

- (void)fetchDetail:(NSString *)detail success:(void (^)(MoviePropertyObject *))success
              error:(void (^)(NSURLSessionDataTask *task, NSError *error))error;

- (void)fetchPoster: (NSString *)poster success:(void (^)(MoviePropertyObject *))success error:(void (^)(NSURLSessionDataTask *, NSError *))error;

@end
