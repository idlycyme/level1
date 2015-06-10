//
//  ViewControllerSetting.m
//  level1
//
//  Created by Yi-De Lin on 6/4/15.
//  Copyright (c) 2015 Yi-De Lin. All rights reserved.
//

#import "ViewControllerSetting.h"
#import "AppDelegate.h"

@interface ViewControllerSetting ()
{
    AVSpeechSynthesizer* speaker;
    AppDelegate *appDelegate;
    int previousStepperHour;

}

@end

@implementation ViewControllerSetting

- (void)viewDidLoad {
    [super viewDidLoad];

    appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.flow = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(hideKeyboardForTextField)];
    [self.view addGestureRecognizer:tap];

    [self editSwitch:NO];
    self.alarmSwitch.on = appDelegate.alarmOn;
    self.alarmHourText.text = [NSString stringWithFormat:@"%d", appDelegate.alarmHour];
    self.alarmMinText.text = [NSString stringWithFormat:@"%d", appDelegate.alarmMin];
    self.alarmMsgText.text = appDelegate.alarmMsg;
    [self editSwitch:appDelegate.alarmOn];

    NSLog(@" a faa    %d", appDelegate.flow);
}
- (IBAction)playMsg:(id)sender {
    [self speak];
}

- (IBAction)pauseMsg:(id)sender {
    [self pause];
}

- (IBAction)stopMsg:(id)sender {
    [self stop];
}

- (void) stop {
    [speaker stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
}
- (void) pause {
    if (!speaker.isPaused) {
       [speaker pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
}
- (void) speak {
    if (speaker.isPaused) {
        [speaker continueSpeaking];
    } else {
    NSString* text = [NSString stringWithFormat:@"%@", self.alarmMsgText.text];
    NSLog(@"read %@", text);
    if (speaker == nil) {
        speaker = [[AVSpeechSynthesizer alloc]init];
    }
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:text];
    [utterance setRate:0.1f];
    [speaker speakUtterance:utterance];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint offset = scrollView.contentOffset;
    NSLog(@"a %f", offset.x);
    if (offset.x > self.view.frame.size.width) {
        [self performSegueWithIdentifier:@"setting2main" sender: @"settingViewController"];
        [scrollView setContentOffset:CGPointMake(0, 0)];
        NSLog(@"gg");
    }

}*/
- (IBAction)switchAlarm:(id)sender {
    [self editSwitch:self.alarmSwitch.on];
    appDelegate.alarmOn = self.alarmSwitch.on;
    NSLog(@"in switch");
}

- (void)editSwitch:(BOOL) isOn {
    self.alarmMsgText.editable = isOn;
    self.alarmMinText.enabled = isOn;
    self.alarmHourText.enabled = isOn;
    self.alarmHourStepper.enabled = isOn;
    self.alarmMinStepper.enabled = isOn;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    appDelegate.alarmMsg = [NSMutableString stringWithString:textView.text];
    NSLog(@"text = %@", textView.text);
}

- (IBAction)stepperValueChanged:(UIStepper*)sender {
    UITextField* label = nil;
    
    int value = sender.value;
    
    
    sender.value = 0.0;
    
    if (sender.tag == 2) {
        label = self.alarmHourText;
    } else if (sender.tag == 3){
        label = self.alarmMinText;
    } else {
        NSLog(@"undefined stepper");
        return;
    }
    

    value += [label.text intValue];
   
    //sender.value = value;
    [label setText:[NSString stringWithFormat:@"%d", (int)value]];
    [self alarmRangeCheck:label];
    

    
}

- (IBAction)alarmRangeCheck:(UITextField*)sender {
    NSString* text = [sender text];
    int number = [text intValue];
    NSLog(@"nubmer is %d", number);
    if (sender.tag == 0) {
        if (number > 23 || number < 0) {
            number = 0;
        }
        //self.alarmHourStepper.value = number;
        appDelegate.alarmHour = number;
        
    } else if (sender.tag == 1){
        if (number > 59 || number < 0) {
            number = 0;
        }
        //self.alarmMinStepper.value = number;
        appDelegate.alarmMin = number;
    } else {
        NSLog(@"undefined alarm time text field");
        return;
    }
    [sender setText:[NSString stringWithFormat:@"%d", number]];
    
    
}
- (void)hideKeyboardForTextField {
    [self.alarmHourText resignFirstResponder];
    [self.alarmMinText resignFirstResponder];
    [self.alarmMsgText resignFirstResponder];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
