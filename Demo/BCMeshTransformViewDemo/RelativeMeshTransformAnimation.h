//
//  RelativeMeshTransformAnimation.h
//  BCMeshTransformViewDemo
//
//  Created by Kevin Doughty on 5/15/14.
//  Copyright (c) 2014 Kevin Doughty. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@class BCMeshTransform;

@interface RelativeMeshTransformAnimation : CABasicAnimation
@property (copy) double (^timingBlock)(double);
@property (copy) BCMeshTransform*(^meshBlock)(double);
@end
