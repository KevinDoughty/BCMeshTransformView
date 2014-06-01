//
//  RelativeMeshTransformAnimation.m
//  BCMeshTransformViewDemo
//
//  Created by Kevin Doughty on 5/15/14.
//  Copyright (c) 2014 Kevin Doughty. All rights reserved.
//

#import "RelativeMeshTransformAnimation.h"

@implementation RelativeMeshTransformAnimation
-(id)copyWithZone:(NSZone *)zone {
    RelativeMeshTransformAnimation *theCopy = [super copyWithZone:zone];
    theCopy.fromValue = self.fromValue;
    theCopy.timingBlock = self.timingBlock;
    return theCopy;
}
@end
