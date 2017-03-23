//
//  MoviePropertyObject.h
//  OMDb
//
//  Created by Zup Beta on 13/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoviePropertyObject : NSObject
@property (strong, nonatomic) NSString *titleMovie;
@property (strong, nonatomic) NSURL *posterMovieURL;
@property (strong, nonatomic) NSString *yearMovie;
@property (strong, nonatomic) NSString *directorMovie;
@property (strong, nonatomic) NSString *actorsMovie;
@property (strong, nonatomic) NSString *genreMovie;
@property (strong, nonatomic) NSString *runtimeMovie;
@property (strong, nonatomic) NSString *plotMovie;
@property (strong, nonatomic) NSString *typeValue;
@property (strong, nonatomic) NSString *imdbID;
@property (strong, nonatomic) NSString *posterImgMovie;
@property (strong, nonatomic) NSString *totalResults;

- (instancetype)initWithData:(NSDictionary *) jsonDataObject;
@end
