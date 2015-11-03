//
//  SecondViewController.h
//  TigerMachine
//
//  Created by ShuangLei Zhou on 15/6/18.
//  Copyright (c) 2015年 shuangleizhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
@property (strong, nonatomic) IBOutlet UISlider *s_volume;
- (IBAction)volumeChanged:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *l_label;
- (IBAction)returnClick:(id)sender;
@property int volume;
@property (strong, nonatomic) IBOutlet UIImageView *i_hardimage;
@property (strong, nonatomic) IBOutlet UIImageView *i_lowimage;
- (IBAction)heighlevel:(id)sender;
- (IBAction)lowerLevel:(id)sender;

@property float playLevel;
@property (strong, nonatomic) IBOutlet UITextField *t_input;
- (IBAction)makeMoney:(id)sender;
@property int money;

@end
