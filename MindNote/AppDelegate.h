//
//  AppDelegate.h
//  MindNote
//
//  Created by 梶原大進 on 2015/03/07.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property int TextCount; //テキストの数をカウント
//@property NSString *MainText; //ココ配列にしたい要素数はTextCountの値

@property int buttonNumber;
@property NSMutableArray *titleArray;
@property NSMutableArray *textArray;
@property NSUserDefaults *userDefaults;

@end

