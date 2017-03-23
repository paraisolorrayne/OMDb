//
//  OMDBService.m
//  OMDb
//
//  Created by Zup Beta on 13/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import "OMDBService.h"

@interface OMDBService ()

@property (strong, nonatomic) AFHTTPSessionManager *manager;
//AFHTTPSessionManager possui o método de fazer solicitação http (GET ou POST) através de passagem de uma URL

@property (nonatomic) AFNetworkReachabilityStatus *reachabilityStatus;
@property (nonatomic) AFNetworkReachabilityManager *reachabilityManager;

@end

@implementation OMDBService

+ (instancetype)defaultService {
    static OMDBService *__defaultService = nil;
    /*
     Dispatch inclui recursos de linguagem, bibliotecas de tempo de execução e aprimoramentos do sistema que fornecem melhorias sistêmicas e abrangentes para o suporte à execução simultânea de código em hardware multicore em macOS, iOS, watchOS e tvOS. Também é semanticamente mais limpo, porque também protege você de vários threads fazendo alloc init de sua sharedInstance - se todos tentarem na mesma hora exata. Não permitirá que duas instâncias sejam criadas. Toda a ideia de dispatch_once()é "executar alguma coisa uma vez e apenas uma vez", que é precisamente o que estamos fazendo. Nesse caso o defaultService tem a função de garantir que o OMDBService seja iniciado apenas uma vez em uma única thread.
     */
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __defaultService = [[OMDBService alloc] init];
    });
    return __defaultService;
}

- (instancetype)init {
    if (self = [super init]) {
        //manager recebe a URL de solicitação
        self.manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString: @"http://www.omdbapi.com/"] sessionConfiguration:nil];
        //AFJSONRequestSerializer codifica os parâmetros como JSON
        self.manager.requestSerializer = [AFJSONRequestSerializer new];
        [_manager.requestSerializer setTimeoutInterval:45]; //Time out after 45 seconds
        //AFJESONResponseSerializer valida e decodifica respostas JSON
        self.manager.responseSerializer = [AFJSONResponseSerializer new];
    }
    return self;
}


- (void)fetchMovies:(NSString *)query page:(NSString *)page success:(void (^)(NSArray<MoviePropertyObject *> *))success error:(void (^)(NSURLSessionDataTask *task, NSError *error))error {
    NSDictionary *params = @{@"s": query ?: NSNull.null, @"page": page};
    [self.manager GET:@"/" parameters:params progress:nil success:^(NSURLSessionDataTask *task, id response) {
        NSLog(@"%@", params);
        NSArray *jsons = [response objectForKey:@"Search"];
        NSLog(@"%@", response);
        NSMutableArray *movies = [NSMutableArray arrayWithCapacity:jsons.count];
        for (NSDictionary *json in jsons) {
            MoviePropertyObject *movie = [[MoviePropertyObject alloc] initWithData:json];
            [movies addObject:movie];
        }
        success(movies);
    } failure:error];  
}

-(void)fetchDetail:(NSString *)detail success:(void (^)(MoviePropertyObject *))success error:(void (^)(NSURLSessionDataTask *, NSError *))error{
    NSDictionary *paramDetail = [NSDictionary dictionaryWithObjectsAndKeys:detail ?: NSNull.null, @"i", nil];
    [self.manager GET:@"/" parameters:paramDetail progress:nil success:^(NSURLSessionDataTask *detailTask, id detailResponse) {
        NSLog(@"%@", paramDetail);
            MoviePropertyObject *movieDetail = [[MoviePropertyObject alloc] initWithData:detailResponse];
        NSLog(@"%@", movieDetail);
        success(movieDetail);
    }failure:error];
}

- (void)fetchPoster: (NSString *)poster success:(void (^)(MoviePropertyObject *))success error:(void (^)(NSURLSessionDataTask *, NSError *))error{
    NSDictionary *paramPoster = [NSDictionary dictionaryWithObjectsAndKeys:poster ?: NSNull.null, @"i", nil];
    [self.manager GET:@"/" parameters:paramPoster progress:nil success:^(NSURLSessionDataTask *posterTask, id posterResponse) {
        MoviePropertyObject *movieDetail = [[MoviePropertyObject alloc] initWithData:posterResponse];
        success(movieDetail);
    }failure:error];
    
}


@end
