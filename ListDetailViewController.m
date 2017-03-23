//
//  ListDetailViewController.m
//  OMDb
//
//  Created by Zup Beta on 18/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import "ListDetailViewController.h"
#import "MovieDetailMO.h"
#import "ListTableViewController.h"
#import "MenuViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self showDetailMovie];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)posterZoom:(UIPinchGestureRecognizer *)recognizer {
    
}

- (IBAction)zoomImageDetail: (UITapGestureRecognizer *) recognizer {
    // Animate the image view so that it fades out
    [UIView animateWithDuration:3.5 animations:^{
        _posterImgDetail.center = CGPointMake(180, 280);
        self.posterImgDetail.transform = CGAffineTransformMakeScale(2.0, 2.0);
    } completion:^(BOOL finished){
        _posterImgDetail.center = CGPointMake(160, 100);
        self.posterImgDetail.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

- (void) showDetailMovie {
    NSLog(@"%@", _movie);
    _titleDes.text = @"Title:";
    _yearDesc.text = @"Year:";
    _plotDesc.text = @"Plot:";
    _directorDesc.text = @"Director:";
    _actorsDesc.text = @"Actors:";
    _genreDesc.text = @"Genre:";
    _runtimeDesc.text = @"Runtime:";
    
    _titleDes.textColor = [UIColor redColor];
    _yearDesc.textColor = [UIColor redColor];
    _plotDesc.textColor = [UIColor redColor];
    _directorDesc.textColor = [UIColor redColor];
    _actorsDesc.textColor = [UIColor redColor];
    _genreDesc.textColor = [UIColor redColor];
    _runtimeDesc.textColor = [UIColor redColor];
    
    _titleDetailLabel.textColor = [UIColor whiteColor];
    _yearDetailLabel.textColor = [UIColor whiteColor];
    _plotDetailLabel.textColor = [UIColor whiteColor];
    _directorDetailLabel.textColor = [UIColor whiteColor];
    _actorsDetailLabel.textColor = [UIColor whiteColor];
    _genreDetailLabel.textColor = [UIColor whiteColor];
    _runtimeDetailLabel.textColor = [UIColor whiteColor];
    _typeDetailLabel.textColor = [UIColor whiteColor];
    
    _titleDetailLabel.text = self.movie.titleMovie;
    _yearDetailLabel.text = _movie.yearMovie;
    _plotDetailLabel.text = _movie.plotMovie;
    _directorDetailLabel.text = _movie.directorMovie;
    _actorsDetailLabel.text = _movie.actorsMovie;
    _genreDetailLabel.text = _movie.genreMovie;
    _runtimeDetailLabel.text = _movie.runtimeMovie;
    _typeDetailLabel.text = _movie.typeValue;
    self.posterImgDetail.image = [UIImage imageNamed:@"defaultImg"];
    if (_movie.posterImgMovie) {
        [_posterImgDetail setImageWithURL:[NSURL URLWithString:_movie.posterImgMovie]];
    }
    
}

- (IBAction)backHome:(id)sender {
    NSLog(@"Exit");
    UIAlertController *view = [UIAlertController
                               alertControllerWithTitle:@""
                               message:@"Retornar"
                               preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* exit = [UIAlertAction
                               actionWithTitle:@"Exit"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction *action) {
                                   NSArray *viewControllersFromStack = [self.navigationController viewControllers];
                                   for(UIViewController *currentVC in [viewControllersFromStack reverseObjectEnumerator]) {
                                           [currentVC.navigationController popViewControllerAnimated:NO];
                                   }
        [view dismissViewControllerAnimated:YES completion:^{
        }];
    }];
    [view addAction:exit];
    [self presentViewController:view animated:YES completion:nil];
}

#pragma mark - Navigation



@end
