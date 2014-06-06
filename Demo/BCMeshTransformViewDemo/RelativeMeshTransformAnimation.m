//
//  RelativeMeshTransformAnimation.m
//  BCMeshTransformViewDemo
//
//  Created by Kevin Doughty on 5/15/14.
//  Copyright (c) 2014 Kevin Doughty. All rights reserved.
//

#import "RelativeMeshTransformAnimation.h"
#import "BCMeshTransform.h"
#import "BCMutableMeshTransform+Relative.h"
#import "BCMeshTransform+Relative.h"

@implementation RelativeMeshTransformAnimation

-(id)copyWithZone:(NSZone *)zone {
    RelativeMeshTransformAnimation *theCopy = [super copyWithZone:zone];
    theCopy.timingBlock = self.timingBlock;
    theCopy.meshBlock = self.meshBlock;
    return theCopy;
}

- (BCMeshTransform *)relativeInterpolate:(NSTimeInterval)now { // Named the same as used BCMeshTransform+Relative method, but they take different arguments...
    double duration = self.duration;
    double start = self.beginTime;
    NSTimeInterval total = duration + (duration * (self.repeatCount)); // speed and timeOffset not supported
    NSTimeInterval elapsed = MIN(total, MAX(0.0, now-start));
    
    if (elapsed < total || self.removedOnCompletion == NO) {
        double time = (MIN(elapsed, total)) / duration;
        double progress = fmod(time, 1.0);
        if (self.autoreverses && ((NSUInteger)floor(elapsed/duration))%2) progress = 1-progress; // 2nd condition should use animation.repeatCount
        if (self.timingBlock) progress = self.timingBlock(progress); // timing function not supported
        
        if (self.meshBlock) {
            return self.meshBlock(progress);
            
            // FIXME: Cannot do this because identity mesh is not known.
            //BCMutableMeshTransform *mesh = [self.meshBlock(progress) mutableCopy];
            //BCMutableMeshTransform *identity = [BCMutableMeshTransform identityMeshTransformWithNumberOfRows:50 numberOfColumns:50];
            //[mesh subtractMesh:identity];
            //return mesh;
            
        } else {
            id fromValue = self.fromValue;
            if ([fromValue isKindOfClass:[BCMeshTransform class]]) {
                BCMeshTransform *fromMesh = (BCMeshTransform*)fromValue;
                return [fromMesh relativeInterpolate:progress];
            }
        }
    }
    return nil;
}

@end
