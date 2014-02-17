//
//  DUMainViewController.m
//  Duck
//
//  Created by Brad Taylor on 2/16/14.
//  Copyright (c) 2014 Brad Taylor. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "DUMainViewController.h"
#import "DUMainView.h"
#import "DUDuckingManager.h"

const static CGFloat kPanGestureJiffies = 80.0f;

typedef NS_ENUM(NSUInteger, DUMainViewControllerState) {
    DUMainViewControllerStateWaiting = 0,
    DUMainViewControllerStateStarted
};

@interface DUMainViewController ()

@property (nonatomic, readwrite) DUMainViewControllerState state;

@property (nonatomic, readwrite) NSTimeInterval interval;

@property (nonatomic, readwrite) NSTimeInterval remainingTime;
@property (nonatomic, readwrite, strong) NSTimer *countdownTimer;

@property (nonatomic, readwrite, strong) DUMainView *mainView;
@property (nonatomic, readwrite, strong) UIPanGestureRecognizer *panGesture;

@end

@implementation DUMainViewController

- (void)loadView
{
    self.mainView = [[DUMainView alloc] initWithFrame:CGRectZero];
    self.view = self.mainView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mainView.startStopButton addTarget:self
                                      action:@selector(onStartStopButtonTouchUpInside)
                            forControlEvents:UIControlEventTouchUpInside];
    
    self.panGesture = [[UIPanGestureRecognizer alloc]
                       initWithTarget:self
                       action:@selector(handlePanGesture:)];

    self.state = DUMainViewControllerStateWaiting;
    
    self.interval = 30;
    [self updateTimeWithInterval:self.interval];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.state == DUMainViewControllerStateWaiting ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

- (void)updateTimeWithInterval:(NSTimeInterval)interval
{
    self.mainView.timePosition = MAX(MIN(interval / 90.0f, 1), 0);
    self.mainView.timeLabel.text = [NSString stringWithFormat:@"%.0f seconds", interval];
    
    [self.mainView setNeedsLayout];
    if (self.interval != interval) {
        [UIView animateWithDuration:0.2f animations:^{
            [self.mainView layoutIfNeeded];
        }];
    }
        
    if (self.state == DUMainViewControllerStateWaiting) {
        self.interval = interval;
    } else {
        self.remainingTime = interval;
    }
}

- (void)onStartStopButtonTouchUpInside
{
    if (self.state == DUMainViewControllerStateWaiting) {
        self.state = DUMainViewControllerStateStarted;
    } else {
        self.state = DUMainViewControllerStateWaiting;
    }
}

- (void)setState:(DUMainViewControllerState)state
{
    _state = state;
    if (self.state == DUMainViewControllerStateWaiting) {
        [UIView animateWithDuration:0.3f animations:^{
            [self.mainView.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
            [self.mainView.backgroundView setAlpha:0.4f];
            [self setNeedsStatusBarAppearanceUpdate];
        }];
        
        [self.mainView addGestureRecognizer:self.panGesture];
        
        [[DUDuckingManager sharedManager] stop];
        [self.countdownTimer invalidate];
        self.countdownTimer = nil;
        
        [self updateTimeWithInterval:self.interval];
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            [self.mainView.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
            [self.mainView.backgroundView setAlpha:1.0f];
            [self setNeedsStatusBarAppearanceUpdate];
        }];

        [self.mainView removeGestureRecognizer:self.panGesture];
        
        [[DUDuckingManager sharedManager] startWithTimeInterval:self.interval];
        self.countdownTimer = [NSTimer
                               scheduledTimerWithTimeInterval:1
                               target:self
                               selector:@selector(handleCountdownTimer)
                               userInfo:Nil
                               repeats:YES];
        
        self.remainingTime = self.interval;
        [self updateTimeWithInterval:self.remainingTime];
    }
}

- (void)handleCountdownTimer
{
    NSTimeInterval remainingTime = self.remainingTime - 1;
    if (remainingTime <= 0) {
        remainingTime = self.interval;
    }
    
    [self updateTimeWithInterval:remainingTime];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    if (self.state != DUMainViewControllerStateWaiting) {
        return;
    }
    
    CGFloat change = [recognizer translationInView:self.mainView].y / self.mainView.frame.size.height;
    
    NSTimeInterval interval = self.interval + (change * kPanGestureJiffies);
    [self updateTimeWithInterval:MAX(MIN(interval, 90), 0)];
    
    [recognizer setTranslation:CGPointZero inView:self.mainView];
}

@end
