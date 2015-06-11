//
//  AppDelegate.h
//  wlkg
//
//  Created by leo on 14/11/17.
//  Copyright (c) 2014年 leo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(retain,nonatomic) NSString *DeviceToken;
@property(retain,nonatomic) NSString *Code_User;
@property(retain,nonatomic) NSString *DeviceBinding;
@property(retain,nonatomic) NSString *Code_Company;
@property(retain,nonatomic) NSString *Code_Department;
@property(retain,nonatomic) NSString *UserName;
@property(retain,nonatomic) NSString *Department;
@property(retain,nonatomic) NSString *Update;
@property(retain,nonatomic) NSString *Version;
@property(retain,nonatomic) NSString *Url;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

