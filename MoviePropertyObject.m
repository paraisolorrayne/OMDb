//
//  MoviePropertyObject.m
//  OMDb
//
//  Created by Zup Beta on 13/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import "MoviePropertyObject.h"

@implementation MoviePropertyObject

- (instancetype)initWithData:(NSDictionary *)jsonDataObject
{
    self = [super init];
    
    if (self) {
        _titleMovie = jsonDataObject[@"Title"];
        _yearMovie = jsonDataObject[@"Year"];
        _runtimeMovie = jsonDataObject [@"Runtime"];
         _genreMovie = jsonDataObject [@"Genre"];
        _directorMovie = jsonDataObject[@"Director"];
        _actorsMovie = jsonDataObject [@"Actors"];
        _plotMovie = jsonDataObject [@"Plot"];
        _typeValue = jsonDataObject [@"Type"];
        _imdbID = jsonDataObject [@"imdbID"];
        _totalResults = jsonDataObject [@"totalResults"];
        _posterImgMovie = jsonDataObject [@"Poster"];
        _posterMovieURL = [NSURL URLWithString:_posterImgMovie];
   
    }
    
    return self;
}

@end
