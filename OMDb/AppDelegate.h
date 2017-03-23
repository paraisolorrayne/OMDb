//
//  AppDelegate.h
//  OMDb
//
//  Created by Zup Beta on 12/01/17.
//  Copyright © 2017 Zup Beta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

