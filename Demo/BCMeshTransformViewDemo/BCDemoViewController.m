//
//  BCDemoViewController.m
//  BCMeshTransformViewDemo
//
//  Created by Bartosz Ciechanowski on 11/05/14.
//  Copyright (c) 2014 Bartosz Ciechanowski. All rights reserved.
//

#import "BCDemoViewController.h"
#import "BCMeshTransformView.h"
#import "RelativeMeshTransformAnimation.h"

@interface BCDemoViewController ()

@end

@implementation BCDemoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _transformView = [[BCMeshTransformView alloc] initWithFrame:self.view.bounds];
    _transformView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:_transformView];
    
    
    // Implicit mesh animation, only duration and timing block are respected, added by Kevin Doughty:
    NSMutableDictionary *actions = self.transformView.layer.actions.mutableCopy;
    if (actions == nil) actions = [NSMutableDictionary dictionary];
    RelativeMeshTransformAnimation *animation = [RelativeMeshTransformAnimation animation];
    animation.duration = 1.5;
    animation.timingBlock = ^(double progress) {
        double omega = 20.0;
        double zeta = 0.25;
        double beta = sqrt(1.0 - zeta * zeta);
        progress = 1.0 / beta * expf(-zeta * omega * progress) * sinf(beta * omega * progress + atanf(beta / zeta));
        return 1-progress;
    };
    [actions setObject:animation forKey:@"relativeMeshAnimation"];
    self.transformView.layer.actions = actions;
}



@end
