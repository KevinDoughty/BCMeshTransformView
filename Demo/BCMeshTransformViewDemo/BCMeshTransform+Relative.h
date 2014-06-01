//
//  BCMeshTransform+Relative.h
//  BCMeshTransformViewDemo
//
//  Created by Kevin Doughty on 5/16/14.
//  Copyright (c) 2014 Kevin Doughty. All rights reserved.
//

#import "BCMeshTransform.h"

@interface BCMeshTransform (Relative)
-(BCMeshTransform *)relativeInterpolate:(double)progress;
@end
