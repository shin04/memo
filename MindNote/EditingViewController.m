//
//  EditingViewController.m
//  MindNote
//
//  Created by 梶原大進 on 2015/05/25.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "EditingViewController.h"
#import "AppDelegate.h"

@implementation EditingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    title.delegate = self;
    text.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"題名:%@ 内容:%@", [appDelegate.titleArray objectAtIndex:appDelegate.buttonNumber], [appDelegate.textArray objectAtIndex:appDelegate.buttonNumber]);
    //title.text = [NSString stringWithFormat:@"%@", [appDelegate.titleArray objectAtIndex:appDelegate.buttonNumber]];
    //[title setText:[appDelegate.titleArray objectAtIndex:appDelegate.buttonNumber]];
    text.text = [NSString stringWithFormat:@"%@", [appDelegate.textArray objectAtIndex:appDelegate.buttonNumber]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveData:(id)sender{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"title = %@, text = %@",title.text ,text.text);
    //???:textFieldがnilになってる
    //[appDelegate.titleArray insertObject:title.text atIndex:appDelegate.buttonNumber];
    [appDelegate.textArray insertObject:text.text atIndex:appDelegate.buttonNumber];
    NSLog(@"題名:%@ 内容:%@", [appDelegate.titleArray objectAtIndex:appDelegate.buttonNumber], [appDelegate.textArray objectAtIndex:appDelegate.buttonNumber]);
    [appDelegate.userDefaults setObject:appDelegate.titleArray forKey:@"titleArray"];
    [appDelegate.userDefaults setObject:appDelegate.textArray forKey:@"textKey"];
    [appDelegate.userDefaults synchronize];
}

- (IBAction)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
