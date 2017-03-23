//
//  ViewController.m
//  OMDb
//
//  Created by Zup Beta on 12/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import "ViewController.h"
#import "MoviePropertyObject.h"
#import "OMDBService.h"
#import "MovieResultTableViewController.h"



@interface ViewController ()
@property (strong, nonatomic) NSString *movieName;
@property (strong, nonatomic) NSArray <MoviePropertyObject *> *movieCollectionResults;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)setupSearchBar
{
    _searchTextBar.placeholder = @"Movie Title";
    self.navigationItem.titleView = _searchTextBar;
    [_searchTextBar becomeFirstResponder];
}

- (void) connectInternet {
    NSURL *scrpitURL = [NSURL URLWithString:@"https://www.google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scrpitURL];
    if (data) {
        //esconde teclado
        [_searchTextBar resignFirstResponder];
        _loading.hidden = NO;
        [_loading startAnimating];
        //chamada do OMDb service
        [[OMDBService defaultService] fetchMovies:_movieName success:^(NSArray<MoviePropertyObject *> *movieCollectionResults) {
            self.movieCollectionResults = movieCollectionResults;
            NSLog(@"%@", _movieCollectionResults);
            [self performSegueWithIdentifier:@"ListSearch" sender:nil];
            [_loading stopAnimating];
            _loading.hidesWhenStopped = TRUE;
        } error:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Erro");
        }
         ];
    }
    else {
        
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@""
                                     message:@"Sem conexão com a Internet!"
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action) {
                                 [view dismissViewControllerAnimated:YES completion:^{
                                 }];
                             }];
        [view addAction:ok];
        [self presentViewController:view animated:YES completion:nil];
    }
}

- (void) searchMovie {
    _movieName = [_searchTextBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([_movieName isEqualToString:@""]) {
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@"O nome do filme não foi digitado!"
                                     message:@"Digite um filme"
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action) {
                                 [view dismissViewControllerAnimated:YES completion:^{
                                 }];
                             }];
        [view addAction:ok];
        [self presentViewController:view animated:YES completion:nil];
    } else if ([_movieName length] == 1 || [_movieName length] == 2) {
        UIAlertController * view=   [UIAlertController
                                     alertControllerWithTitle:@"Busca inválida"
                                     message:@"Digite um nome com mais de 3 caracteres!"
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction* ok = [UIAlertAction
                             actionWithTitle:@"OK"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action) {
                                 [view dismissViewControllerAnimated:YES completion:^{
                                 }];
                             }];
        [view addAction:ok];
        [self presentViewController:view animated:YES completion:nil];
        NSLog(@"Digite uma busca com mais de 3 caracteres");
    } else {
        //esconde teclado
        [_searchTextBar resignFirstResponder];
        _loading.hidden = NO;
        [_loading startAnimating];
        [self connectInternet];
    }
}

- (IBAction)searchAction:(id)sender {
    [self searchMovie];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ListSearch"]) {
        MovieResultTableViewController *ctrl = (MovieResultTableViewController *) segue.destinationViewController;
        ctrl.movieCollectionResults = self.movieCollectionResults;
    }
}

@end
