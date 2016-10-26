//
//  AppDelegate.h
//  JMS
//
//  Created by 黄沐 on 2016/10/26.
//  Copyright © 2016年 JMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

