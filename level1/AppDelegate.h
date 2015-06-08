//
//  AppDelegate.h
//  level1
//
//  Created by Yi-De Lin on 6/4/15.
//  Copyright (c) 2015 Yi-De Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property int alarmHour;
@property int alarmMin;
@property NSMutableString* alarmMsg;
@property BOOL alarmOn;
@property AVSpeechSynthesizer* speaker;
@property BOOL alarmStopped;
@property (atomic) int flow;

- (void) speak;
- (void) pause;
- (void) stop;
@end

