//
//  DUDuckingManager.m
//  Duck
//
//  Created by Brad Taylor on 2/17/14.
//  Copyright (c) 2014 Brad Taylor. All rights reserved.
//

#import "DUDuckingManager.h"
#import <AVFoundation/AVFoundation.h>

static DUDuckingManager * _sharedManager = nil;

@interface DUDuckingManager()

@property (nonatomic, readwrite, strong) NSTimer *timer;

@end

@implementation DUDuckingManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[DUDuckingManager alloc] init];
    });
    return _sharedManager;
}

- (id)init
{
    if (self = [super init]) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback
                                         withOptions:AVAudioSessionCategoryOptionDuckOthers
                                               error:nil];

    }
    return self;
}

- (BOOL)isRunning
{
    return self.timer == nil;
}

- (void)startWithTimeInterval:(NSTimeInterval)timeInterval
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                                  target:self
                                                selector:@selector(firstDuck)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)stop
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)firstDuck
{
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [self performSelector:@selector(firstUnduck) withObject:nil afterDelay:0.1f];
}

- (void)firstUnduck
{
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
    [self performSelector:@selector(secondDuck) withObject:nil afterDelay:0.1f];
}

- (void)secondDuck
{
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    [self performSelector:@selector(secondUnduck) withObject:nil afterDelay:0.1f];
}

- (void)secondUnduck
{
    [[AVAudioSession sharedInstance] setActive:NO error:nil];
}

@end
