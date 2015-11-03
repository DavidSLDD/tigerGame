//
//  SecondViewController.m
//  TigerMachine
//
//  Created by ShuangLei Zhou on 15/6/18.
//  Copyright (c) 2015年 shuangleizhou. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_playLevel == 0.5) {
        [_i_hardimage setImage:[UIImage imageNamed:@"圈蓝"]];
        [_i_lowimage setImage:[UIImage imageNamed:@"选中蓝"]];
    } else {
        [_i_hardimage setImage:[UIImage imageNamed:@"选中蓝"]];
        [_i_lowimage setImage:[UIImage imageNamed:@"圈蓝"]];

    }
    _t_input.returnKeyType =  UIReturnKeyJoin;
    _s_volume.value = (float)_volume;
    _l_label.text = [NSString stringWithFormat:@"%d", _volume];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)volumeChanged:(id)sender {
    float tmpVolume = [_s_volume value];
    _l_label.text = [NSString stringWithFormat:@"%d", (int)tmpVolume];
    
}
- (IBAction)returnClick:(id)sender {
    NSNotification *notification = [NSNotification notificationWithName:@"avVolume" object:[NSNumber numberWithFloat:[_s_volume value]]];
    NSNotification *notificationlevel = [NSNotification notificationWithName:@"level" object:[NSNumber numberWithFloat:_playLevel]];
    NSNotification *notificationMoney = [NSNotification notificationWithName:@"money" object:[NSNumber numberWithInt:_money]];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [[NSNotificationCenter defaultCenter] postNotification:notificationlevel];
    [self dismissViewControllerAnimated:YES completion:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notificationMoney];
    [self dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)heighlevel:(id)sender {
    _playLevel = 0.1;
    self.i_hardimage.image = [UIImage imageNamed:@"选中蓝"];
    [self.i_lowimage setImage:[UIImage imageNamed:@"圈蓝"]];
}

- (IBAction)lowerLevel:(id)sender {
    _playLevel = 0.5;
    [self.i_lowimage setImage:[UIImage imageNamed:@"选中蓝"]];
    [_i_hardimage setImage:[UIImage imageNamed:@"圈蓝"]];
}
- (IBAction)makeMoney:(id)sender {
    int tmpMoney = [self.t_input.text intValue];
    self.money = tmpMoney;
    self.t_input.text = @"";
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"结果" message:@"充值成功" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [view show];
    [self.view endEditing:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
