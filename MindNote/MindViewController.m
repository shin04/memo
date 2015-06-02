//
//  MindViewController.m
//  MindNote
//
//  Created by 梶原大進 on 2015/03/07.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "MindViewController.h"
#import "AppDelegate.h"

@interface MindViewController ()

@property IBOutlet UIButton *button;

@end

@implementation MindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    if (!appDelegate.titleArray) {
        appDelegate.titleArray = [[NSMutableArray array] init];
    }
    
    if (!appDelegate.textArray) {
        appDelegate.textArray = [[NSMutableArray array] init];
    }
    
    if (!X_Array) {
        X_Array = [[NSMutableArray array] init];
    }
    
    if (!Y_Array) {
        Y_Array = [[NSMutableArray array] init];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.userDefaults = [NSUserDefaults standardUserDefaults];
    [appDelegate.userDefaults floatForKey:@"X_Key"];
    [appDelegate.userDefaults floatForKey:@"Y_Key"];
    [appDelegate.userDefaults integerForKey:@"Num_Key"];
    for (int c = 0; c < TagNumber - 1; c++) {
        //保存されている座標にbuttonを作成
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake([[X_Array objectAtIndex:c] floatValue], [[Y_Array objectAtIndex:c] floatValue], 40, 60);
        [button setTitle:@"NEW" forState:UIControlStateNormal];
        button.tag = TagNumber;
        [self.view addSubview:button];
        TagNumber ++;
        [appDelegate.userDefaults setInteger:TagNumber forKey:@"Num_Key"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newMind:(id)sender{
    if (Coordinate_X == 0) {
        buttonLabel.text = @"画面をタップしてください";
    }else{
        [self CreateButton];
        Coordinate_X = 0;
        Coordinate_Y = 0;
    }
}

- (IBAction)delMind:(id)sender{
    if (DellNumber < 0) {
        buttonLabel.text = @"オブジェクトを選択してください";
    }else{
        //MARK:ここを書いてる途中
        UIButton *button = (UIButton*)[self.view viewWithTag:DellNumber];
        //???:view自体が消える
        [button removeFromSuperview];
    }
}

- (IBAction)edit:(id)sender{
    EditingViewController *editing=[self.storyboard instantiateViewControllerWithIdentifier:@"editing"];
    [self presentViewController:editing animated:NO completion:nil];
}

//ボタン作成
- (void)CreateButton{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //ボタンを表示する横位置、縦位置、横幅、縦幅を設定する
    button.frame = CGRectMake(Coordinate_X, Coordinate_Y, 40, 60);
    //文字を表示
    [button setTitle:@"NEW" forState:UIControlStateNormal];
    //タグ設定(ボタン識別)
    button.tag = TagNumber;
    //Viewにボタンを追加して表示する。
    [self.view addSubview:button];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.userDefaults = [NSUserDefaults standardUserDefaults];
    
    TagNumber ++;
    [appDelegate.userDefaults setInteger:TagNumber forKey:@"Num_Key"];
    
    /*
    if (!appDelegate.titleArray) {
        appDelegate.titleArray = [[NSMutableArray array] init];
    }
    
    if (!appDelegate.textArray) {
        appDelegate.textArray = [[NSMutableArray array] init];
    }
     */
    
    [appDelegate.titleArray insertObject:@"題名" atIndex:button.tag];
    [appDelegate.textArray insertObject:@"内容" atIndex:button.tag];
    NSLog(@"%@", [appDelegate.titleArray objectAtIndex:button.tag]);
    
    /*
    if (!X_Array) {
        X_Array = [[NSMutableArray array] init];
    }
    
    if (!Y_Array) {
        Y_Array = [[NSMutableArray array] init];
    }
     */
    
    [X_Array insertObject:[NSNumber numberWithInteger:Coordinate_X] atIndex:button.tag];
    [Y_Array insertObject:[NSNumber numberWithInteger:Coordinate_Y] atIndex:button.tag];
    
    [appDelegate.userDefaults setObject:X_Array forKey:@"X_Key"];
    [appDelegate.userDefaults setObject:Y_Array forKey:@"Y_Key"];
    [appDelegate.userDefaults synchronize];
    
    [button addTarget:self
               action:@selector(hoge:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)hoge:(UIButton*)button{
    NSLog(@"%ld",(long)button.tag);
    //ボタンのタグをdellnumberに代入
    DellNumber = button.tag;
    //ボタンの番号をlabelに表示
    buttonLabel.text = [NSString stringWithFormat:@"%d",DellNumber];
    NSLog(@"dellnumber=%d",DellNumber);
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.buttonNumber = button.tag;
}

//座標取得
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint 座標 = [touch locationInView:self.view];
    Coordinate_X = 0;
    Coordinate_Y = 0;
    Coordinate_X = 座標.x;
    Coordinate_Y = 座標.y;
    NSLog(@"x座標=%f Coordinate_X=%f",座標.x,Coordinate_X);
}

@end
