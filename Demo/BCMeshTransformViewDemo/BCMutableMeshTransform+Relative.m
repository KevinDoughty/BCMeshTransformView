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
        if (i == self.vertexCount-1) {
            //NSLog(@"add OLD from x:%f; y:%f; to x:%f; y:%f; z:%f; NEW from x:%f; y:%f; to x:%f; y:%f; z:%f; FINAL from x:%f; y:%f; to x:%f; y:%f; z:%f;",oldVertex.from.x, oldVertex.from.y, oldVertex.to.x, oldVertex.to.y, oldVertex.to.z   ,newVertex.from.x, newVertex.from.y, newVertex.to.x, newVertex.to.y, newVertex.to.z   ,finalVertex.from.x, finalVertex.from.y, finalVertex.to.x, finalVertex.to.y, finalVertex.to.z);
        }
    }
}
-(void)subtractMesh:(BCMeshTransform*)mesh {
    //NSLog(@"self:%@; count:%lu; mesh:%@; count:%lu;",self,self.vertexCount,mesh,mesh.vertexCount);
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
        if (i == self.vertexCount-1) {
            //NSLog(@"subtract OLD from x:%f; y:%f; to x:%f; y:%f; z:%f; NEW from x:%f; y:%f; to x:%f; y:%f; z:%f; FINAL from x:%f; y:%f; to x:%f; y:%f; z:%f;",oldVertex.from.x, oldVertex.from.y, oldVertex.to.x, oldVertex.to.y, oldVertex.to.z   ,newVertex.from.x, newVertex.from.y, newVertex.to.x, newVertex.to.y, newVertex.to.z   ,finalVertex.from.x, finalVertex.from.y, finalVertex.to.x, finalVertex.to.y, finalVertex.to.z);
        }
    }
}
@end
