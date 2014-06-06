//
//  BCMutableMeshTransform+Relative.m
//  BCMeshTransformViewDemo
//
//  Created by Kevin Doughty on 5/15/14.
//  Copyright (c) 2014 Kevin Doughty. All rights reserved.
//

#import "BCMutableMeshTransform+Relative.h"
#import "BCMeshTransform.h"

@implementation BCMutableMeshTransform (Relative)

-(void)addMesh:(BCMeshTransform*)mesh {
    NSAssert(mesh.vertexCount == self.vertexCount, @"Numbers of vertices in interpolated mesh transforms do not match");
    for (int i = 0; i < self.vertexCount; i++) {
        BCMeshVertex oldVertex = [self vertexAtIndex:i];
        BCMeshVertex newVertex = [mesh vertexAtIndex:i];
        BCMeshVertex finalVertex;
        finalVertex.from.x = oldVertex.from.x + newVertex.from.x;
        finalVertex.from.y = oldVertex.from.y + newVertex.from.y;
        finalVertex.to.x = oldVertex.to.x + newVertex.to.x;
        finalVertex.to.y = oldVertex.to.y + newVertex.to.y;
        finalVertex.to.z = oldVertex.to.z + newVertex.to.z;
        [self replaceVertexAtIndex:i withVertex:finalVertex];
    }
}
-(void)subtractMesh:(BCMeshTransform*)mesh {
    NSAssert(mesh.vertexCount == self.vertexCount, @"Numbers of vertices in interpolated mesh transforms do not match");
    for (int i = 0; i < self.vertexCount; i++) {
        BCMeshVertex oldVertex = [self vertexAtIndex:i];
        BCMeshVertex newVertex = [mesh vertexAtIndex:i];
        BCMeshVertex finalVertex;
        finalVertex.from.x = oldVertex.from.x - newVertex.from.x;
        finalVertex.from.y = oldVertex.from.y - newVertex.from.y;
        finalVertex.to.x = oldVertex.to.x - newVertex.to.x;
        finalVertex.to.y = oldVertex.to.y - newVertex.to.y;
        finalVertex.to.z = oldVertex.to.z - newVertex.to.z;
        [self replaceVertexAtIndex:i withVertex:finalVertex];
    }
}
@end
