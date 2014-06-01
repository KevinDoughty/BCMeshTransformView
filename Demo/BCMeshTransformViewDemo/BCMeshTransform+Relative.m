//
//  BCMeshTransform+Relative.m
//  BCMeshTransformViewDemo
//
//  Created by Kevin Doughty on 5/16/14.
//  Copyright (c) 2014 Kevin Doughty. All rights reserved.
//

#import "BCMeshTransform+Relative.h"
#import "BCMutableMeshTransform+Convenience.h"
#import "BCMeshTransform+Interpolation.h"

@implementation BCMeshTransform (Relative)

- (BCMeshTransform *)relativeInterpolate:(double)progress {
    
    BCMutableMeshTransform *resultTransform = [self mutableCopy];
    progress *= -1;
    for (int i = 0; i < self.vertexCount; i++) {
        BCMeshVertex oldVertex = [self vertexAtIndex:i];
        BCMeshVertex newVertex;
        
        newVertex.from.x = oldVertex.from.x + (oldVertex.from.x * progress);
        newVertex.from.y = oldVertex.from.y + (oldVertex.from.y * progress);
        
        newVertex.to.x = oldVertex.to.x + (oldVertex.to.x * progress);
        newVertex.to.y = oldVertex.to.y + (oldVertex.to.y * progress);
        newVertex.to.z = oldVertex.to.z + (oldVertex.to.z * progress);
        
        [resultTransform replaceVertexAtIndex:i withVertex:newVertex];
    }
    
    return resultTransform;
}

@end
