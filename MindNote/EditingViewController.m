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
    
//    if (!title) {
//        title = [[UITextField alloc] init];
//    }
    
    self.titleTextField.delegate = self;
    self.text.delegate = self;
    self.titleTextField.text = @"題名";
}

- (void)viewWillAppear:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"題名:%@ 内容:%@", [appDelegate.titleArray objectAtIndex:appDelegate.buttonNumber - 1], [appDelegate.textArray objectAtIndex:appDelegate.buttonNumber - 1]);
    self.titleTextField.text = [NSString stringWithFormat:@"%@", [appDelegate.titleArray objectAtIndex:appDelegate.buttonNumber - 1]];
    self.text.text = [NSString stringWithFormat:@"%@", [appDelegate.textArray objectAtIndex:appDelegate.buttonNumber - 1]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveData:(id)sender{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSLog(@"title = %@, text = %@",self.titleTextField.text ,self.text.text);
    [appDelegate.titleArray insertObject:self.titleTextField.text atIndex:appDelegate.buttonNumber - 1];
    [appDelegate.textArray insertObject:self.text.text atIndex:appDelegate.buttonNumber - 1];
    NSLog(@"題名:%@ 内容:%@", [appDelegate.titleArray objectAtIndex:appDelegate.buttonNumber - 1], [appDelegate.textArray objectAtIndex:appDelegate.buttonNumber - 1]);
    [appDelegate.userDefaults setObject:appDelegate.titleArray forKey:@"titleArray"];
    [appDelegate.userDefaults setObject:appDelegate.textArray forKey:@"textKey"];
    [appDelegate.userDefaults synchronize];
}

- (IBAction)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
