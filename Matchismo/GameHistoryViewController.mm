// Copyright (c) 2018 Lightricks. All rights reserved.
// Created by Nofar Erez.

#import "GameHistoryViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameHistoryViewController()

@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

@end

@implementation GameHistoryViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.historyTextView.attributedText = self.history;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.historyTextView.attributedText = self.history;
}

@end

NS_ASSUME_NONNULL_END
