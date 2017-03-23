//
//  MovieDetailViewController.m
//  OMDb
//
//  Created by Zup Beta on 13/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "AppDelegate.h"
#import "OMDBService.h"
#import "MovieResultTableViewController.h"
#import "MovieDetailMO.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "ListTableViewController.h"
#import "MenuViewController.h"

@interface MovieDetailViewController ()
@property (strong, nonatomic) MovieDetailMO *movie;
@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleMovieLabel.text = @"\n";
    _yearMovieLabel.text = @"\n";
    _directorMovieLabel.text = @"\n";
    _actorsMovieLabel.text = @"\n";
    _genreMovieLabel.text = @"\n";
    _runtimeMovieLabel.text = @"\n";
    _plotMovieLabel.text = @"\n";
    _typeValueLabel.text = @"";
    _loading.hidden = NO;
    [_loading startAnimating];
}

- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear: animated];
    [self searchDetails];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) serviceDetails {
    NSString *movieName = self.movieCollection.imdbID;

    [[OMDBService defaultService] fetchDetail:movieName success:^(MoviePropertyObject *movieCollection) {
        self.movieCollection = movieCollection;
        _titleMovieLabel.text = _movieCollection.titleMovie;
        _yearMovieLabel.text = _movieCollection.yearMovie;
        _directorMovieLabel.text = _movieCollection.directorMovie;
        _actorsMovieLabel.text = _movieCollection.actorsMovie;
        _genreMovieLabel.text = _movieCollection.genreMovie;
        _runtimeMovieLabel.text = _movieCollection.runtimeMovie;
        _plotMovieLabel.text = _movieCollection.plotMovie;
        _typeValueLabel.text = _movieCollection.typeValue;
        [_posterUIImgMovie cancelImageDownloadTask];
        self.posterUIImgMovie.image = [UIImage imageNamed:@"defaultImage"];
        if (_movieCollection.posterMovieURL) {
            NSLog(@"%@", _posterUIImgMovie.image);
            [_posterUIImgMovie setImageWithURL:_movieCollection.posterMovieURL];
        }
        _loading.hidesWhenStopped = TRUE;
        [_loading stopAnimating];
    } error:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"Erro");
        
        UIAlertController *view = [UIAlertController
                                   alertControllerWithTitle:@"Erro"
                                   message:@"Ocorreu um erro inesperado, voltar."
                                   preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"Ok"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction *action) {
                                 NSArray *viewControllersFromStack = [self.navigationController viewControllers];
                                 for(UIViewController *currentVC in [viewControllersFromStack reverseObjectEnumerator]) {
                                     [currentVC.navigationController popViewControllerAnimated:NO];
                                 }
                                 [view dismissViewControllerAnimated:YES completion:^{
                                 }];
                             }];
        [view addAction:ok];
        [self presentViewController:view animated:YES completion:nil];
    }];
    
    
}

- (void)searchDetails {
    [self serviceDetails];
    if (![_titleMovieLabel.text  isEqual: @""]) {
         
    }
}

-(void)saveInCoreData {
    //save Movie in CoreData
    AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    _movie = [NSEntityDescription insertNewObjectForEntityForName:@"Movie" inManagedObjectContext:context];
    //para salvar pega o MoviePropertyObject utilizado na chamada do serviço e passa para o modelo MovieDetailMO
    _movie.titleMovie = _movieCollection.titleMovie;
    _movie.yearMovie = _movieCollection.yearMovie;
    _movie.plotMovie = _movieCollection.plotMovie;
    _movie.directorMovie = _movieCollection.directorMovie;
    _movie.actorsMovie = _movieCollection.actorsMovie;
    _movie.genreMovie = _movieCollection.genreMovie;
    _movie.runtimeMovie = _movieCollection.runtimeMovie;
    _movie.typeValue = _movieCollection.typeValue;
    _movie.posterImgMovie = _movieCollection.posterImgMovie;
    NSError *error = nil;
    [context save:&error];
    if (error) {
        NSLog(@"%@", error);
    }
}
- (IBAction)tapZoomImage:(id)sender {
    [UIView animateWithDuration:3.5 animations:^{
        _posterUIImgMovie.center = CGPointMake(160, 280);
        self.posterUIImgMovie.transform = CGAffineTransformMakeScale(2.0, 2.0);
    } completion:^(BOOL finished){
        _posterUIImgMovie.center = CGPointMake(160, 100);
        self.posterUIImgMovie.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}


- (IBAction)favoriteMovie:(id)sender {
        NSLog(@"Tap");
}


- (IBAction)saveMovie:(id)sender {
    [self saveInCoreData];
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Movie save"
                                 message:@"Deseja salvar mais filmes?"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [self.navigationController popViewControllerAnimated:YES];
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"No"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 //clear navigation stack
                                 NSArray *viewControllersFromStack = [self.navigationController viewControllers];
                                 for(UIViewController *currentVC in [viewControllersFromStack reverseObjectEnumerator]) {
                                     [currentVC.navigationController popViewControllerAnimated:NO];
                                 }
                                 [view dismissViewControllerAnimated:YES completion:^{
                                 }];
                                 
                             }];
    [view addAction:ok];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ListTable"]) {
        MovieDetailViewController *ctrl = (MovieDetailViewController *) segue.destinationViewController;
        ctrl.movieCollection = self.movieCollection;
    }
    
}


@end
