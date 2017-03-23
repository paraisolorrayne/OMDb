//
//  ListDetailViewController.h
//  OMDb
//
//  Created by Zup Beta on 18/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviePropertyObject.h"
#import "MovieDetailMO.h"

@interface ListDetailViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *exitButton;
@property (strong, nonatomic) MovieDetailMO *movie;
//Desc
@property (strong, nonatomic) IBOutlet UILabel *titleDes;
@property (strong, nonatomic) IBOutlet UILabel *yearDesc;
@property (strong, nonatomic) IBOutlet UILabel *plotDesc;
@property (strong, nonatomic) IBOutlet UILabel *directorDesc;
@property (strong, nonatomic) IBOutlet UILabel *actorsDesc;
@property (strong, nonatomic) IBOutlet UILabel *genreDesc;
@property (strong, nonatomic) IBOutlet UILabel *runtimeDesc;
@property (strong, nonatomic) IBOutlet UILabel *typeDesc;

//Cont
@property (strong, nonatomic) IBOutlet UILabel *titleDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *plotDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *directorDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *actorsDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *genreDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *runtimeDetailLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeDetailLabel;
@property (strong, nonatomic) IBOutlet UIImageView *posterImgDetail;


@end
