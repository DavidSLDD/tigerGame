//
//  ViewController.h
//  TigerMachine
//
//  Created by ShuangLei Zhou on 15/6/17.
//  Copyright (c) 2015年 shuangleizhou All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController <AVAudioPlayerDelegate, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property (strong,nonatomic) NSMutableArray *imagearray;
@property (strong,nonatomic) NSTimer *timer, *lamptimer, *victorytimer;
- (IBAction)Spin:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *b_spin;
- (IBAction)spinDown:(id)sender;
@property BOOL isRunning;
@property int mask;
@property (strong,nonatomic)AVAudioPlayer *player;
@property int level;
- (IBAction)menuClick:(id)sender;
- (IBAction)betClick:(id)sender;
- (IBAction)betMaxClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *b_betone;
@property (strong, nonatomic) IBOutlet UIButton *b_betmax;
@property (strong, nonatomic) IBOutlet UIButton *b_menu;
@property (strong, nonatomic) IBOutlet UILabel *l_bet;
@property (strong, nonatomic) IBOutlet UILabel *l_win;
@property (strong, nonatomic) IBOutlet UILabel *l_total;
@property (strong, nonatomic) IBOutlet UIButton *b_up;
@property (strong, nonatomic) IBOutlet UIButton *b_down;
-(void)lampMode;
@property (strong, nonatomic) IBOutlet UIImageView *i_image0;
@property (strong, nonatomic) IBOutlet UIImageView *i_image1;
@property (strong, nonatomic) IBOutlet UIImageView *i_image2;
@property (strong, nonatomic) IBOutlet UIImageView *i_image3;
@property (strong, nonatomic) IBOutlet UIImageView *i_image4;
@property float volume;
@property BOOL flagVolume;
@property float playLevel;
@property (strong, nonatomic) IBOutlet UIImageView *i_victory;
@property int money;
@end

