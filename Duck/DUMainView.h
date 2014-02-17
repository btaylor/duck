//
//  DUMainView.h
//  Duck
//
//  Created by Brad Taylor on 2/16/14.
//  Copyright (c) 2014 Brad Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DUMainView : UIView

@property (nonatomic, readwrite) UIEdgeInsets edgeInsets UI_APPEARANCE_SELECTOR;
@property (nonatomic, readwrite) CGFloat spacing UI_APPEARANCE_SELECTOR;
@property (nonatomic, readwrite) CGFloat buttonHeight UI_APPEARANCE_SELECTOR;

@property (nonatomic, readonly, strong) UIImageView *backgroundView;

@property (nonatomic, readwrite) CGFloat timePosition;
@property (nonatomic, readonly, strong) UILabel *timeLabel;

@property (nonatomic, readonly, strong) UIButton *startStopButton;

@end
