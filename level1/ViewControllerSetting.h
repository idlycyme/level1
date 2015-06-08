//
//  ViewControllerSetting.h
//  level1
//
//  Created by Yi-De Lin on 6/4/15.
//  Copyright (c) 2015 Yi-De Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewControllerSetting : UIViewController <UITextViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIPageControl *pageControlSetting;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewSetting;
@property (weak, nonatomic) IBOutlet UIPickerView *mPicker;
@property (weak, nonatomic) IBOutlet UISwitch *alarmSwitch;
@property (weak, nonatomic) IBOutlet UITextField *alarmHourText;
@property (weak, nonatomic) IBOutlet UITextField *alarmMinText;
@property (weak, nonatomic) IBOutlet UIStepper *alarmHourStepper;
@property (weak, nonatomic) IBOutlet UIStepper *alarmMinStepper;
@property (weak, nonatomic) IBOutlet UITextView *alarmMsgText;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
