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
#import <AudioToolbox/AudioToolbox.h>
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
    [appDelegate stop];
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
        self.view.backgroundColor = [UIColor whiteColor];
        
        self.status.font = [self.status.font fontWithSize:23];
        //self.status.backgroundColor = [UIColor whiteColor];
        self.stopAlarm.enabled = NO;
        self.stopAlarm.hidden = YES;
        if (appDelegate.alarmOn) {
            self.status.text = @"You've set up an alarm";
        }else{
            self.status.text = @"";
        }
    } else {
        if (self.view.backgroundColor == [UIColor whiteColor]) {
        self.view.backgroundColor = [UIColor redColor];
        } else {
        self.view.backgroundColor = [UIColor whiteColor];
        }
        
        UILabel* status = self.status;
        status.font = [status.font fontWithSize:50];
        if ([status.text isEqual:@"IS"]) {
            status.text = @"UP";
        } else if ([status.text isEqual:@"TIME"]){
            status.text = @"IS";
        } else {
            status.text = @"TIME";
        }
        //status.backgroundColor = [UIColor redColor];
        //status.text = @"Time is up!!!!";
        self.stopAlarm.hidden = NO;
        self.stopAlarm.enabled = YES;
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
    }
    [self.view setNeedsDisplay];
//AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

- (void)showTime {
    NSDate *date = [NSDate date];
    
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitTimeZone) fromDate:date];
    int hour = (int)[components hour];
    int minute = (int)[components minute];
    int second = (int)[components second];
    NSTimeZone* zone = [components timeZone];
    //NSLog(@"h %d m %d", hour, minute);
    //self.currentTimeLabel.text = [formatter stringFromDate:date];
    //NSLog(@"sec is %d", second);
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minute, second];
    self.currentTimeZoneLabel.text = [NSString stringWithFormat:@"%@", [zone abbreviation]];
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

        [appDelegate speak];
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
