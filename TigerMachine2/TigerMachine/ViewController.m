//
//  ViewController.m
//  TigerMachine
//
//  Created by ShuangLei Zhou on 15/6/17.
//  Copyright (c) 2015年 shuangleizhou. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()
#define TOTAL @"total"
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    self.l_total.text = [userdefault objectForKey:TOTAL];
    
    _flagVolume = NO;
    _playLevel = 0.5;
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(getVolume:) name:@"avVolume" object:nil];
    [notificationCenter addObserver:self selector:@selector(getLevel:) name:@"level" object:nil];
    [notificationCenter addObserver:self selector:@selector(getMoney:) name:@"money" object:nil];

    // Do any additional setup after loading the view, typically from a nib.
    self.imagearray=[[NSMutableArray alloc]init];
    UIImage *image1=[UIImage imageNamed:@"1"];
    UIImage *image2=[UIImage imageNamed:@"2"];
    UIImage *image3=[UIImage imageNamed:@"3"];
    UIImage *image4=[UIImage imageNamed:@"4"];
    UIImage *image5=[UIImage imageNamed:@"5"];
    UIImage *image6=[UIImage imageNamed:@"6"];
    [self.imagearray addObject:image1];
    [self.imagearray addObject:image2];
    [self.imagearray addObject:image3];
    [self.imagearray addObject:image4];
    [self.imagearray addObject:image5];
    [self.imagearray addObject:image6];
    [self.b_menu setImage:[UIImage imageNamed:@"menu1"] forState:UIControlStateNormal];
    [self.b_betone setImage:[UIImage imageNamed:@"betone1"] forState:UIControlStateNormal];
    [self.b_betmax setImage:[UIImage imageNamed:@"betmax1"] forState:UIControlStateNormal];
    
    self.l_bet.text = @"0";
    self.l_win.text = @"0";
    //self.l_total.text = @"10";
    
    [self.b_up setImage:[UIImage imageNamed:@"up1"] forState:UIControlStateNormal];
    
    [self.picker selectRow:2 inComponent:0 animated:YES];
    [self.picker selectRow:2 inComponent:1 animated:YES];
    [self.picker selectRow:2 inComponent:2 animated:YES];
    
    self.isRunning=NO;
    srandom(time(NULL));
    
    self.lamptimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(lampMode) userInfo:nil repeats:YES];
    NSBundle *bundle=[NSBundle mainBundle];
    NSURL *url=[bundle URLForResource:@"mary" withExtension:@"mp3"];
    
    self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    self.player.delegate = self;
    self.player.numberOfLoops=-1;
    //[self.i_victory setImage:[UIImage imageNamed:@"t"]];

    [self.player play];
}

#pragma mark natification
-(void) getVolume:(NSNotification *)notification {
    float tmpVolume = [[notification object] floatValue];
    [self setVolume:tmpVolume];
    self.player.volume = tmpVolume/100;
    NSLog(@"%lf", _player.volume);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    if (self.l_total.text.intValue > 100000) {
        self.l_total.text = @"99999";
    }
}

- (void)getMoney:(NSNotification *)notifacationMoney {
    self.money = [[notifacationMoney object] intValue];
    self.l_total.text = [NSString stringWithFormat:@"%d", [self.l_total.text intValue] + self.money];
    NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
    [de setObject:self.l_total.text forKey:TOTAL];
    [de synchronize];
}
- (void)getLevel:(NSNotification *)notifactionlevel {
    _playLevel = [[notifactionlevel object] floatValue];
}

#pragma mark wheelsTimer
-(void)handleTimer:(NSTimer*)theTimer {
    NSLog(@"timer");
    if (self.mask&0b001) {
        [self.picker selectRow:random()%6 inComponent:0 animated:NO];
    }
    
    if (self.mask&0b010) {
        [self.picker selectRow:random()%6 inComponent:1 animated:NO];
    }
    
    if (self.mask&0b100) {
        [self.picker selectRow:random()%6 inComponent:2 animated:NO];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark----
#pragma mark picker view datasource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.imagearray count];
}

#pragma mark pickerview delegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UIImage *tmpimage=[self.imagearray objectAtIndex:row];
    UIImageView *tmpview=[[UIImageView alloc]initWithImage:tmpimage];
    return tmpview;
}

#pragma - mark pickerviewheightweith
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return 75.0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 72.0;
}

#pragma - mark spincount
- (IBAction)Spin:(id)sender {
    [self.b_up setImage:[UIImage imageNamed:@"up1"] forState:UIControlStateNormal];
    [self.b_spin setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    if (self.isRunning==NO) {
        self.lamptimer =nil;
        self.lamptimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(lampMode) userInfo:nil repeats:YES];
        
        self.isRunning=YES;
        [self.timer invalidate];
        self.timer=nil;
        self.mask=0b111;
        self.timer=[NSTimer scheduledTimerWithTimeInterval:_playLevel target:self selector:@selector(handleTimer:) userInfo:nil repeats:YES];
                NSBundle *bundle=[NSBundle mainBundle];
        NSURL *url=[bundle URLForResource:@"crunch" withExtension:@"wav"];
        [self.player stop];
        self.player=[self.player initWithContentsOfURL:url error:nil];
        _player.delegate = self;
        self.player.numberOfLoops=-1;
        [self.player play];
        
    } else {
        self.isRunning=NO;
        self.lamptimer = nil;
        self.lamptimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(lampMode) userInfo:nil repeats:YES];
        
        
        
        [self.picker selectRow:random()%6 inComponent:0 animated:YES];
        self.mask=0b110;
        
        [self performSelector:@selector(selectSecondComponent) withObject:nil afterDelay:1];
        [self performSelector:@selector(selectThirdComponent) withObject:nil afterDelay:2];
    }
}

-(void)selectSecondComponent {
    [self.picker selectRow:random()%6 inComponent:1 animated:YES];
    self.mask=0b100;
}
#define MAXLEVEL 2
#define MIDDLELEVEL 1
#define NOLEVEL 0

-(void)selectThirdComponent {
    [self.picker selectRow:random()%6 inComponent:2 animated:YES];
    self.mask=0b000;
    [self.timer invalidate];
    [self.player stop];

    [self.lamptimer invalidate];
    self.lamptimer =nil;
    self.lamptimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(lampMode) userInfo:nil repeats:YES];
    
    
    int resultOfOneComponent = [_picker selectedRowInComponent:0];
    int resultOfTwoComponent = [_picker selectedRowInComponent:1];
    int resultOfThirdComponent = [_picker selectedRowInComponent:2];
    if ((resultOfOneComponent == resultOfThirdComponent)  && (resultOfThirdComponent == resultOfTwoComponent)) {
        _level = MAXLEVEL;
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *url = [bundle URLForResource:@"vv" withExtension:@"mp3"];
        _player = [_player initWithContentsOfURL:url error:nil];
        self.victorytimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(victoryLight) userInfo:nil repeats:YES];
        [_player play];
    } else if (resultOfTwoComponent == resultOfOneComponent || resultOfThirdComponent == resultOfTwoComponent) {
        _level = MIDDLELEVEL;
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *url = [bundle URLForResource:@"vv" withExtension:@"mp3"];
        _player = [_player initWithContentsOfURL:url error:nil];
        _player.delegate = self;
        self.victorytimer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(victoryLight) userInfo:nil repeats:YES];
        [_player play];
    } else {
        _level = NOLEVEL;
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *url = [bundle URLForResource:@"loose" withExtension:@"wav"];
        _player = [_player initWithContentsOfURL:url error:nil];
        _player.delegate = self;
        [_player play];
    }
    if (_level == 0) {
        int tmp = [self.l_total.text intValue] - [self.l_bet.text intValue];
        self.l_total.text = [NSString stringWithFormat:@"%d", tmp];
        self.l_win.text = @"0";
        self.l_bet.text = @"0";
        NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
        [de setObject:self.l_total.text forKey:TOTAL];
        [de synchronize];
    } else if (_level == 1) {
        int tmp = [self.l_total.text intValue] + [self.l_bet.text intValue];
        self.l_total.text = [NSString stringWithFormat:@"%d", tmp];
        self.l_win.text =self.l_bet.text;
        NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
        [de setObject:self.l_total.text forKey:TOTAL];
        [de synchronize];

        //self.l_bet.text = @"0";
    } else {
        int tmp = [self.l_total.text intValue] + [self.l_bet.text intValue]*2;
        self.l_total.text = [NSString stringWithFormat:@"%d", tmp];
        int tmp2 = [self.l_bet.text intValue]*2;
        self.l_win.text =[NSString stringWithFormat:@"%d", tmp2];
        NSUserDefaults *de = [NSUserDefaults standardUserDefaults];
        [de setObject:self.l_total.text forKey:TOTAL];
        [de synchronize];

    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)victoryLight {
    if (_flagVolume == NO) {
        _flagVolume = YES;
        [self.i_victory setImage:[UIImage imageNamed:@"t"]];
    } else {
        _flagVolume = NO;
        [self.i_victory setImage:[UIImage imageNamed:@""]];
    }
}


#pragma - mark spindown
- (IBAction)spinDown:(id)sender {
    [self.b_up setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.b_spin setImage:[UIImage imageNamed:@"Spin.jpg"] forState:UIControlStateNormal];
    [self.lamptimer invalidate];
}

#pragma - mark menuclick
- (IBAction)menuClick:(id)sender {
}


#pragma - mark betclick
- (IBAction)betClick:(id)sender {
    NSString *tmpstr = self.l_bet.text;
    int tmpnumber = [tmpstr intValue];
    tmpnumber++;
    if (tmpnumber > [self.l_total.text intValue]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"错误" message:@"娱乐币不足，请充值" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"充值", nil];
        [alertView show];
    } else {
        self.l_bet.text = [NSString stringWithFormat:@"%d", tmpnumber];
    }
}



- (IBAction)betMaxClick:(id)sender {
    int totalBet = [self.l_total.text intValue];
    self.l_bet.text = [NSString stringWithFormat:@"%d", totalBet];
}


#pragma - mark avdidfinihplaying
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    NSBundle *bundle=[NSBundle mainBundle];
    NSURL *url=[bundle URLForResource:@"mary" withExtension:@"mp3"];
        self.player=[ _player initWithContentsOfURL:url error:nil];
    self.player.delegate = self;
    self.player.numberOfLoops=-1;
    [self.player play];
    [self.victorytimer invalidate];
    self.l_win.text = @"0";
    self.l_bet.text = @"0";

    
}


#pragma - mark lampmode
- (void)lampMode {
    //NSLog(@"%d", model);
    static int index = 0;
    [_i_image0 setImage:[UIImage imageNamed:@""]];
    [_i_image1 setImage:[UIImage imageNamed:@""]];

    [_i_image2 setImage:[UIImage imageNamed:@""]];

    [_i_image3 setImage:[UIImage imageNamed:@""]];
    [_i_image4 setImage:[UIImage imageNamed:@""]];
    switch (index) {
        case 0:
            [_i_image0 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"color%d", rand()%3]]];
            break;
        case 1:
            [_i_image1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"color%d", rand()%3]]];
            break;
        case 2:
            [_i_image2 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"color%d", rand()%3]]];
            break;
        case 3:
            [_i_image3 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"color%d", rand()%3]]];
            break;
        case 4:
            [_i_image4 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"color%d", rand()%3]]];
            break;
        default:
            break;
    }
    index++;
    if (index > 4) {
        index = 0;
    }
}

#pragma  mark alertviewdelegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecondViewController *menu = [story instantiateViewControllerWithIdentifier:@"1"];
    [self presentViewController:menu animated:YES completion:nil];
}


#pragma mark prepareforsegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    SecondViewController *menu = [segue destinationViewController];
    //menu.modalPresentationStyle = UIModalPresentationFormSheet;
    [menu setVolume:(int)(_player.volume*100)];
    [menu setPlayLevel:_playLevel];
    NSLog(@"%d", menu.volume);
    //menu.s_volume.value = self.player.volume*100;
}

@end
