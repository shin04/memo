//
//  MindViewController.h
//  MindNote
//
//  Created by 梶原大進 on 2015/03/07.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "ViewController.h"
#import "EditingViewController.h"

@interface MindViewController : UIViewController <UITextFieldDelegate>
{
    float Coordinate_X;
    float Coordinate_Y;
    int TagNumber;
    int DellNumber; //削除するbuttonのタグナンバーを記録
    IBOutlet UILabel *buttonLabel;
    IBOutlet UITextField *text;
    NSMutableArray *X_Array;
    NSMutableArray *Y_Array;
    float re_X;
    float re_Y;
}
- (IBAction)newMind:(id)sender;
- (IBAction)delMind:(id)sender;
- (IBAction)edit:(id)sender;

@end
