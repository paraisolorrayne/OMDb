//
//  MenuViewController.m
//  OMDb
//
//  Created by Zup Beta on 24/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchMovieBar.delegate = self;
    _searchMovieBar.placeholder = @"Movie Title";
   /* NSArray *imageNames = @[@"win_1.png", @"win_2.png", @"win_3.png", @"win_4.png",
                            @"win_5.png", @"win_6.png", @"win_7.png", @"win_8.png",
                            @"win_9.png", @"win_10.png", @"win_11.png", @"win_12.png",
                            @"win_13.png", @"win_14.png", @"win_15.png", @"win_16.png"];
    
    NSMutableArray *images = [[NSMutableArray alloc] init];
   for (int i = 0; i < imageNames.count; i++) {
        [images addObject:[UIImage imageNamed:[imageNames objectAtIndex:i]]];
    }
    UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(105, 335, 110, 235)];
   animationImageView.animationImages = images;
    animationImageView.animationDuration = 0.65;
    self.view.backgroundColor = [UIColor whiteColor]; //setar essa linha quando a Karine for testar
    [self.view addSubview:animationImageView];
    [animationImageView startAnimating];
    */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    //abre teclado
    [_searchMovieBar becomeFirstResponder];
   [self connectInternet];
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    return YES;
}


- (void)setupSearchBar
{
    self.navigationItem.titleView = _searchMovieBar;
     _movieName = [_searchMovieBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //abre o teclado
    [_searchMovieBar becomeFirstResponder];
    [self connectInternet];
}
 
 //esconder teclado ao tocar na lupa
 //parar loading quando limpa o campo de busca
 //quando da aperta o x da barra de pesquisa o teclado não aparece mais
 
 

- (IBAction)toucheBegan:(UITapGestureRecognizer *)sender {
    //esconder teclado quando usuário toca fora do campo de texto
    [_searchMovieBar resignFirstResponder];
}

- (void) connectInternet {
    NSURL *scrpitURL = [NSURL URLWithString:@"https://www.google.com"];
    NSData *data = [NSData dataWithContentsOfURL:scrpitURL];
    if (data) {
        _movieName = [_searchMovieBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        //esconde teclado
        [_searchMovieBar resignFirstResponder];
        _loading.hidden = NO;
        [_loading startAnimating];
        if ([_searchMovieBar.text  isEqual: @""]) {
            [_loading stopAnimating];
            _loading.hidesWhenStopped = TRUE;
        }
         _movieName = [_searchMovieBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSInteger pages = 100;
        __block NSInteger c = 0;
        for (int i = 1; i <= pages; i++) {
            //chamada do OMDb service
            [[OMDBService defaultService] fetchMovies:_movieName page:[NSString stringWithFormat:@"%ld", (long) i] success:^(NSArray<MoviePropertyObject*> *movieCollectionResults) {
                self.movieCollectionResults = [(self.movieCollectionResults ?: @[]) arrayByAddingObjectsFromArray:movieCollectionResults];
                c += 1;
                if (c >= pages) {
                    [_loading stopAnimating];
                    _loading.hidesWhenStopped = TRUE;
                    [self performSegueWithIdentifier:@"ListSearch" sender:nil];
                }
            } error:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"Erro");
                c += 1;
                if (c >= pages) {
                    [_loading stopAnimating];
                    _loading.hidesWhenStopped = TRUE;
                    [self performSegueWithIdentifier:@"ListSearch" sender:nil];
                }
            }
             ];
        } //fim for
       
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
                                     [self.view endEditing:YES];
                                     [_searchMovieBar resignFirstResponder];
                                 }];
                             }];
        [view addAction:ok];
        [self presentViewController:view animated:YES completion:nil];
    }
}

- (void)searchMovieFunc {
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
        [_searchMovieBar resignFirstResponder];
        _loading.hidden = NO;
        [_loading startAnimating];
        [self connectInternet];
    }

}

- (IBAction)searchMovie:(id)sender {
    _movieName = [_searchMovieBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //esconde teclado
    [_searchMovieBar resignFirstResponder];
    [self searchMovieFunc];
}


- (IBAction)goList:(id)sender {
    ListTableViewController *HomeViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ListTable"];
    [self.navigationController pushViewController:HomeViewController animated:YES];
    
}

#pragma mark - Navigation

 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     if ([segue.identifier isEqualToString:@"ListSearch"]) {
         MovieResultTableViewController *ctrl = (MovieResultTableViewController *) segue.destinationViewController;
         ctrl.movieCollectionResults = self.movieCollectionResults;
    }
 }


@end
