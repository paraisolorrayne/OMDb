//
//  MovieDetailMO.h
//  OMDb
//
//  Created by Zup Beta on 16/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface MovieDetailMO : NSManagedObject
@property (strong, nonatomic) NSString *titleMovie;
@property (strong, nonatomic) NSString *yearMovie;
@property (strong, nonatomic) NSString *runtimeMovie;
@property (strong, nonatomic) NSString *genreMovie;
@property (strong, nonatomic) NSString *directorMovie;
@property (strong, nonatomic) NSString *actorsMovie;
@property (strong, nonatomic) NSString *plotMovie;
@property (strong, nonatomic) NSString *typeValue;
@property (strong, nonatomic) NSString *posterImgMovie;
@end
