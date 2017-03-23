//
//  MovieResultTableViewController.m
//  OMDb
//
//  Created by Zup Beta on 13/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import "MovieResultTableViewController.h"
#import "MovieDetailViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface MovieResultTableViewController ()
@end

@implementation MovieResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear: animated];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@" segue para a tela de detalhes do filme");
    MovieDetailViewController *MovieDetailView = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Detail"];
    MoviePropertyObject *movie = self.movieCollectionResults [indexPath.row];
    MovieDetailView.movieCollection = movie;

    [self.navigationController pushViewController:MovieDetailView animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movieCollectionResults.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"cell"];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_movieCollectionResults count]) {
        MoviePropertyObject *movieCollection = self.movieCollectionResults [indexPath.row];
        [cell addGestureRecognizer:_longPress];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.text = [NSString stringWithFormat:@"%@", movieCollection.titleMovie];
        
        [cell.imageView cancelImageDownloadTask];
        cell.imageView.image = [UIImage imageNamed:@"defaultImage"];
        if (movieCollection.posterMovieURL) {
            NSLog(@"%@", cell.imageView);
            [cell.imageView setImageWithURL:movieCollection.posterMovieURL];
            
        }

    }
    else {
        UIAlertController *view = [UIAlertController
                                   alertControllerWithTitle:@"Erro"
                                   message:@"Filme não encontrado, voltar para a tela inicial."
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
    }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation


@end
