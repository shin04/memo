//
//  EditingViewController.h
//  MindNote
//
//  Created by 梶原大進 on 2015/05/25.
//  Copyright (c) 2015年 梶原大進. All rights reserved.
//

#import "EditingViewController.h"
#import "ViewController.h"

@interface EditingViewController : UIViewController
<UITextFieldDelegate, UITextViewDelegate>
{
    IBOutlet UITextField *title;
    IBOutlet UITextView *text;
}

- (IBAction)saveData:(id)sender;
- (IBAction)back:(id)sender;

@end
