//
//  customSegue.m
//  level1
//
//  Created by Yi-De Lin on 6/6/15.
//  Copyright (c) 2015 Yi-De Lin. All rights reserved.
//

#import "customSegue.h"
#import "ViewControllerSetting.h"
#import "ViewController.h"

@implementation customSegue


- (void) perform {
  //  UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
  //  rootViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
    ViewController* controller = [self sourceViewController];
    ViewControllerSetting* destController = [self destinationViewController];
    [controller presentViewController:destController animated:YES completion:nil];
}

@end
