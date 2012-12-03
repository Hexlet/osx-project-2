//
//  HRAppDelegate.h
//  HabraReader
//
//  Created by Sergey Starukhin on 06.09.12.
//  Copyright (c) 2012 Sergey Starukhin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// Инициализация CoreData будет происходить в другом классе
/*
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
*/
@end
