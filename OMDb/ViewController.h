//
//  ViewController.h
//  OMDb
//
//  Created by Zup Beta on 12/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <CoreData/CoreData.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISearchBar *searchTextBar;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;




@end

