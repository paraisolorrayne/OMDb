//
//  ListTableViewController.m
//  OMDb
//
//  Created by Zup Beta on 17/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import "ListTableViewController.h"
#import "AppDelegate.h"
#import "MovieDetailMO.h"
#import "ListDetailViewController.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ListTableViewController ()

@property (strong, nonatomic) NSArray <MovieDetailMO *> *movies;


@end

@implementation ListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    NSError *error = nil;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Movie"];
    self.movies = [context executeFetchRequest:fetchRequest error:&error];
    
    if (!self.movies) {
        NSLog(@"Error fetching Movie objects: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Segue para detalhes do filme salvo");
    ListDetailViewController *ListDetailView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ListDetail"];
    MovieDetailMO *movie = self.movies [indexPath.row];
    
    ListDetailView.movie = movie;
    [self.navigationController pushViewController:ListDetailView animated:YES];
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"celldetail"];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieDetailMO *movieMO = self.movies [indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = movieMO.titleMovie;
    [cell.imageView cancelImageDownloadTask];
    cell.imageView.image = [UIImage imageNamed:@"defaultImage"];
    if (movieMO.posterImgMovie) {
        [cell.imageView setImageWithURL:[NSURL URLWithString:movieMO.posterImgMovie]];
    }

}

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
     if (editingStyle == UITableViewCellEditingStyleDelete) {
         NSMutableArray *movies = [self.movies mutableCopy];
         MovieDetailMO *movieMO = movies[indexPath.row];
         [movies removeObject:movieMO];
         self.movies = movies;
         
         AppDelegate *appDelegate = (AppDelegate *) UIApplication.sharedApplication.delegate;
         NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
         [context deleteObject:movieMO];
         
         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     } else {
         NSLog(@"No delete");
     }
}


 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}


@end
