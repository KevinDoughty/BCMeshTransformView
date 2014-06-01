//
//  BCMutableMeshTransform+Relative.h
//  BCMeshTransformViewDemo
//
//  Created by Kevin Doughty on 5/15/14.
//  Copyright (c) 2014 Kevin Doughty. All rights reserved.
//

#import "BCMeshTransform.h"

@interface BCMutableMeshTransform (Relative)

-(void)addMesh:(BCMeshTransform*)mesh;
-(void)subtractMesh:(BCMeshTransform*)mesh;

@end
