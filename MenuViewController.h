
//
//  MenuViewController.h
//  OMDb
//
//  Created by Zup Beta on 24/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <CoreData/CoreData.h>
#import "MoviePropertyObject.h"
#import "OMDBService.h"
#import "MovieResultTableViewController.h"
#import "ListTableViewController.h"


@interface MenuViewController : UIViewController <UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *searchMovieBar;
@property (strong, nonatomic) IBOutlet UIButton *goListButton;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) NSString *movieName;
@property (strong, nonatomic) NSArray <MoviePropertyObject *> *movieCollectionResults;

@end
