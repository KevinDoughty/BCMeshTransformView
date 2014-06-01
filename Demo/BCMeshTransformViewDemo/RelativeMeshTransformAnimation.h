//
//  RelativeMeshTransformAnimation.h
//  BCMeshTransformViewDemo
//
//  Created by Kevin Doughty on 5/15/14.
//  Copyright (c) 2014 Kevin Doughty. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface RelativeMeshTransformAnimation : CAAnimation
@property (copy) id fromValue;
@property (copy) double (^timingBlock)(double);
@end
