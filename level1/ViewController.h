//
//  ViewController.h
//  level1
//
//  Created by Yi-De Lin on 6/4/15.
//  Copyright (c) 2015 Yi-De Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerSetting.h"

@interface ViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIPageControl *pageControlMain;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollViewMain;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UIButton *stopAlarm;
@property     ViewControllerSetting* setting;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeZoneLabel;

@end

