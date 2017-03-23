//
//  MovieDetailViewController.h
//  OMDb
//
//  Created by Zup Beta on 13/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviePropertyObject.h"

@interface MovieDetailViewController : UIViewController <UIAlertViewDelegate>

@property (strong,nonatomic) MoviePropertyObject *movieCollection;
@property (strong, nonatomic) IBOutlet UILabel *titleMovieLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearMovieLabel;
@property (strong, nonatomic) IBOutlet UILabel *directorMovieLabel;
@property (strong, nonatomic) IBOutlet UILabel *actorsMovieLabel;
@property (strong, nonatomic) IBOutlet UILabel *genreMovieLabel;
@property (strong, nonatomic) IBOutlet UILabel *runtimeMovieLabel;
@property (strong, nonatomic) IBOutlet UILabel *plotMovieLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeValueLabel;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UIImageView *posterUIImgMovie;

//Label Desc
@property (strong, nonatomic) IBOutlet UILabel *titleDescLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearDescLabel;
@property (strong, nonatomic) IBOutlet UILabel *directorDescLabel;
@property (strong, nonatomic) IBOutlet UILabel *actorsDescLabel;
@property (strong, nonatomic) IBOutlet UILabel *genreDescLabel;
@property (strong, nonatomic) IBOutlet UILabel *runtimeDescLabel;
@property (strong, nonatomic) IBOutlet UILabel *plotDescLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeDescLabel;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapImage;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *longTap;
@property (strong, nonatomic) IBOutlet UIProgressView *progress;

@end
