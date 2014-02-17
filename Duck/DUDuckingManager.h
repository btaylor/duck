//
//  DUDuckingManager.h
//  Duck
//
//  Created by Brad Taylor on 2/17/14.
//  Copyright (c) 2014 Brad Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DUDuckingManager : NSObject

+ (instancetype)sharedManager;

@property (nonatomic, readonly) BOOL isRunning;

- (void)startWithTimeInterval:(NSTimeInterval)timeInterval;
- (void)stop;

@end
