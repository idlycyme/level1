//
//  ViewController.m
//  level1
//
//  Created by Yi-De Lin on 6/4/15.
//  Copyright (c) 2015 Yi-De Lin. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
//#import "ViewControllerSetting.h"
#import <Foundation/Foundation.h>

@interface ViewController () {
    NSTimer* timer;
    NSThread* thread;
    BOOL isThreadAlive;
    NSDateFormatter* formatter;
    AppDelegate *appDelegate;
    NSCalendar *calendar;
    
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stopAlarm.enabled = NO;
    appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.flow = 0;

    calendar = [NSCalendar currentCalendar];
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss zzz"];
    
    [self timerOn];
    
   

    
        NSLog(@"bac2");
    
   /*
    // Do any additional setup after loading the view, typically from a nib.
    [self.scrollViewMain setPagingEnabled:YES];
    [self.scrollViewMain setShowsHorizontalScrollIndicator: YES];
    [self.scrollViewMain setShowsVerticalScrollIndicator: NO];
    [self.scrollViewMain setScrollsToTop: YES];
    CGFloat width, height;
    width = self.scrollViewMain.frame.size.width;
    height = self.scrollViewMain.frame.size.height;
    [self.scrollViewMain setContentSize:CGSizeMake(width*2, height)];
    NSLog(@"======== %f", self.scrollViewMain.contentOffset.x);
*/

}

- (IBAction)stopAlarmMsg:(id)sender {
    self.stopAlarm.enabled = NO;
    self.stopAlarm.hidden = YES;
    [appDelegate stop];
    UILabel* status = self.status;
    
    if (appDelegate.alarmOn) {
        status.text = @"You've set up an alarm";
    } else {
        status.text = @"";
    }
    status.font = [status.font fontWithSize:23];
    status.backgroundColor = [UIColor whiteColor];
}

- (void)timerOn {
    if (thread == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(showTime) userInfo:nil repeats:YES];
    }
}

- (void)timerOff {
    if (thread != nil) {
        [timer invalidate];
        timer = nil;
    }
}

- (void) showStatus {
    if (!appDelegate.speaker.isSpeaking) {
        if (appDelegate.alarmOn) {
        self.status.text = @"You've set up an alarm";
        }else{
            self.status.text = @"";
        }
        NSLog(@"zasfasdfasdfaf");
    } else {
    UILabel* status = self.status;
    status.font = [status.font fontWithSize:25];
    status.backgroundColor = [UIColor redColor];
    status.text = @"Time is up!!!!";
    self.stopAlarm.hidden = NO;
    self.stopAlarm.enabled = YES;
    NSLog(@"vzcxvad %@", self.status.text);
    
    }
    [self.view setNeedsDisplay];
//AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

- (void)showTime {
    NSDate *date = [NSDate date];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:date];
    int hour = (int)[components hour];
    int minute = (int)[components minute];
    //NSLog(@"h %d m %d", hour, minute);
    self.currentTimeLabel.text = [formatter stringFromDate:date];
    [self showStatus];

    if (
        appDelegate.alarmOn &&
        hour == appDelegate.alarmHour &&
        minute == appDelegate.alarmMin
        
        ) {
 
        
        if (appDelegate.alarmStopped ||
            appDelegate.flow != 0 ||
            appDelegate.speaker.isSpeaking
            ) {
            return;
        }
        
        appDelegate.alarmStopped = YES;

        
        //[self alarmSinging];
        

        [appDelegate speak];
        NSLog(@"-----");
        
        /*
        NSLog(@"switch %d, h %d, m %d, msg %@",
              appDelegate.alarmOn,
              appDelegate.alarmHour,
              appDelegate.alarmMin,
              appDelegate.alarmMsg
              );
         */
        
    } else {
        appDelegate.alarmStopped = NO;
    }
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
