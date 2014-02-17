//
//  DUMainView.m
//  Duck
//
//  Created by Brad Taylor on 2/16/14.
//  Copyright (c) 2014 Brad Taylor. All rights reserved.
//

#import "DUMainView.h"
#import <MTGeometry/MTGeometry.h>
#import <AVHexColor/AVHexColor.h>

@interface DUMainView()

@property (nonatomic, readwrite, strong) UIImageView *backgroundView;

@property (nonatomic, readwrite, strong) UILabel *timeLabel;

@property (nonatomic, readwrite, strong) UIButton *startStopButton;

@end

@implementation DUMainView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.edgeInsets = UIEdgeInsetsMake(20, 10, 10, 10);
        self.spacing = 20;
        self.buttonHeight = 45;
        
        self.backgroundColor = [UIColor blackColor];
        
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LaunchImage"]];
        [self.backgroundView setAlpha:0.3f];
        [self addSubview:self.backgroundView];
        
        self.timePosition = .5;
        
        self.timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.timeLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:32.0f]];
        [self.timeLabel setTextColor:[UIColor whiteColor]];
        [self.timeLabel setTextAlignment:NSTextAlignmentCenter];
        [self addSubview:self.timeLabel];
        
        self.startStopButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.startStopButton setBackgroundColor:[UIColor clearColor]];
        [self.startStopButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [self.startStopButton.layer setCornerRadius:10.0f];
        [self.startStopButton.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        [self.startStopButton.layer setBorderWidth:1.0f];

        [self addSubview:self.startStopButton];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = [self bounds];
    [self.backgroundView setFrame:bounds];
    
    CGRect insetBounds = UIEdgeInsetsInsetRect(bounds, self.edgeInsets);
    
    [self.startStopButton setFrame:CGRectMake(insetBounds.origin.x,
                                              CGRectGetMaxY(insetBounds) - self.buttonHeight,
                                              insetBounds.size.width,
                                              self.buttonHeight)];
    insetBounds = CGRectInsetEdge(insetBounds, CGRectMaxYEdge, -1 * (self.buttonHeight + self.spacing));
    
    CGSize timeSize = [self.timeLabel.text sizeWithFont:self.timeLabel.font];
    CGFloat y = insetBounds.origin.y + ((insetBounds.size.height - timeSize.height) * self.timePosition);
    
    [self.timeLabel setFrame:CGRectMake(insetBounds.origin.x,
                                        MAX(y, insetBounds.origin.y),
                                        insetBounds.size.width,
                                        timeSize.height)];
}

@end
