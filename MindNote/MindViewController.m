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
    
    NSLog(@"TagNumber = %d", TagNumber);
    
    //view上のbuttonを全て削除
    for (int c = 0; c < TagNumber; c++) {
        [[self.view viewWithTag:c + 1] removeFromSuperview];
    }
    
    for (int c = 0; c < TagNumber; c++) {
        //保存されている座標にbuttonを作成
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake([[X_Array objectAtIndex:c] floatValue], [[Y_Array objectAtIndex:c] floatValue], 40, 60);
        
        //文字を設定
        button.tintColor = [UIColor whiteColor];
        [button setTitle:[appDelegate.titleArray objectAtIndex:c] forState:UIControlStateNormal];
        
        //buttonにタグを設定
        button.tag = c + 1;
        NSLog(@"button.tag = %ld", (long)button.tag);
        
        //buttonを追加
        [self.view addSubview:button];
        
        [appDelegate.userDefaults setInteger:TagNumber forKey:@"Num_Key"];
        [button addTarget:self
                   action:@selector(hoge:) forControlEvents:UIControlEventTouchUpInside];
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
        buttonLabel.text = @"選択してください";
    }else{
        AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        [appDelegate.titleArray removeObjectAtIndex:DellNumber];
        [appDelegate.textArray removeObjectAtIndex:DellNumber];
        [X_Array removeObjectAtIndex:DellNumber];
        [Y_Array removeObjectAtIndex:DellNumber];
        [[self.view viewWithTag:DellNumber] removeFromSuperview];
    }
}

- (IBAction)edit:(id)sender{
    if (DellNumber > 0) {
        // サウンドの準備
        NSString *path = [[NSBundle mainBundle] pathForResource:@"paper" ofType:@"mp3"];
        NSURL *url = [NSURL fileURLWithPath:path];
        AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url), &sound);
        
        // サウンドの再生
        AudioServicesPlaySystemSound(sound);
    
        EditingViewController *editing=[self.storyboard instantiateViewControllerWithIdentifier:@"editing"];
        [self presentViewController:editing animated:NO completion:nil];
    } else {
        buttonLabel.text = @"選択してください";
    }
    
}

//ボタン作成
- (void)CreateButton{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    //ボタンを表示する横位置、縦位置、横幅、縦幅を設定する
    button.frame = CGRectMake(Coordinate_X, Coordinate_Y, 40, 60);
    
    //タイトルを設定
    button.tintColor = [UIColor whiteColor];
    [button setTitle:@"NEW" forState:UIControlStateNormal];
    
    // サウンドの準備
    NSString *path = [[NSBundle mainBundle] pathForResource:@"magnet" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((CFURLRef)CFBridgingRetain(url), &sound);
    
    // サウンドの再生
    AudioServicesPlaySystemSound(sound);

    //タグ設定
    TagNumber ++;
    button.tag = TagNumber;
    
    //Viewにボタンを追加して表示する。
    [self.view addSubview:button];
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.userDefaults = [NSUserDefaults standardUserDefaults];
    
    [appDelegate.userDefaults setInteger:TagNumber forKey:@"Num_Key"];
    
    [appDelegate.titleArray insertObject:@"題名" atIndex:button.tag-1];
    [appDelegate.textArray insertObject:@"内容" atIndex:button.tag-1];
    //NSLog(@"%@", [appDelegate.titleArray objectAtIndex:button.tag]);
    
    NSLog(@"%ld",(long)button.tag);

    
//    [X_Array addObject:[NSNumber numberWithInteger:Coordinate_X]];
//    [Y_Array addObject:[NSNumber numberWithInteger:Coordinate_Y]];
    [X_Array insertObject:[NSNumber numberWithInteger:Coordinate_X] atIndex:button.tag-1];
    [Y_Array insertObject:[NSNumber numberWithInteger:Coordinate_Y] atIndex:button.tag-1];
    
    [appDelegate.userDefaults setObject:X_Array forKey:@"X_Key"];
    [appDelegate.userDefaults setObject:Y_Array forKey:@"Y_Key"];
    [appDelegate.userDefaults synchronize];
    
    [button addTarget:self
               action:@selector(hoge:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)hoge:(UIButton*)button{
    NSLog(@"button.tag = %ld",(long)button.tag);
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
