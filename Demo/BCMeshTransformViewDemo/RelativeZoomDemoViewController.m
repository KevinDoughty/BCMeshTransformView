//
//  RelativeZoomDemoViewController.m
//  BCMeshTransformViewDemo
//
//  Created by Kevin Doughty on 6/6/14.
//  Copyright (c) 2014 Kevin Doughty. All rights reserved.
//

#import "RelativeZoomDemoViewController.h"
#import "BCMeshTransformView.h"
#import "BCMeshTransform+DemoTransforms.h"

@interface RelativeZoomDemoViewController ()
@property (assign) CGFloat scale;
@end

@implementation RelativeZoomDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"picture.jpg"]];
    imageView.center = CGPointMake(CGRectGetMidX(self.transformView.contentView.bounds),
                                   CGRectGetMidY(self.transformView.contentView.bounds));
    
    [self.transformView.contentView addSubview:imageView];
    
    // we don't want any shading on this one
    self.transformView.diffuseLightFactor = 0.0;
    [self identityMesh];
    
    self.scale = 1;
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:pinchGestureRecognizer];
    
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer
{
    self.scale = [gestureRecognizer scale];
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) [self identityMesh];
    else [self meshBuldgeAtPoint:[gestureRecognizer locationInView:self.view]];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event]; // ugly
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.transformView];
    
    [self meshBuldgeAtPoint:point];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self identityMesh];
}
-(void)identityMesh {
    self.transformView.meshTransform = [BCMutableMeshTransform identityMeshTransformWithNumberOfRows:36 numberOfColumns:36];
    
}

- (void)meshBuldgeAtPoint:(CGPoint)point {
    
    const CGFloat Bulginess = 0.4;
    
    BCMutableMeshTransform *transform = [BCMutableMeshTransform identityMeshTransformWithNumberOfRows:36 numberOfColumns:36];
    
    CGFloat radius = self.scale * 100;
    CGSize size = self.transformView.bounds.size;
    
    CGFloat rMax = radius/size.width;
    
    CGFloat yScale = size.height/size.width;
    
    CGFloat x = point.x/size.width;
    CGFloat y = point.y/size.height;
    
    NSUInteger vertexCount = transform.vertexCount;
    
    for (int i = 0; i < vertexCount; i++) {
        BCMeshVertex v = [transform vertexAtIndex:i];
        
        CGFloat dx = v.to.x - x;
        CGFloat dy = (v.to.y - y) * yScale;
        
        CGFloat r = sqrt(dx*dx + dy*dy);
        
        if (r > rMax) {
            continue;
        }
        
        CGFloat t = r/rMax;
        
        CGFloat scale = Bulginess*(cos(t * M_PI) + 1.0);
        
        v.to.x += dx * scale;
        v.to.y += dy * scale / yScale;
        v.to.z = scale * 0.2;
        [transform replaceVertexAtIndex:i withVertex:v];
    }
    
    self.transformView.meshTransform = transform;
}

@end
