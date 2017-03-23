//
//  MovieResultTableViewController.h
//  OMDb
//
//  Created by Zup Beta on 13/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviePropertyObject.h"
#import <CoreData/CoreData.h>

@interface MovieResultTableViewController : UITableViewController
@property (strong, nonatomic) NSArray <MoviePropertyObject *> *movieCollectionResults;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *longPress;
@end
