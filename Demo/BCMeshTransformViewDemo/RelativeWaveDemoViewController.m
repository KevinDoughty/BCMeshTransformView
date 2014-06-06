//
//  RelativeWaveDemoViewController.m
//  BCMeshTransformViewDemo
//
//  Created by Kevin Doughty on 6/5/14.
//  Copyright (c) 2014 Kevin Doughty. All rights reserved.
//

#import "RelativeWaveDemoViewController.h"
#import "BCMeshTransformView.h"
#import "RelativeMeshTransformAnimation.h"
#import "BCMeshTransform.h"
#import "BCMutableMeshTransform+Relative.m"

@interface RelativeWaveDemoViewController ()
@property (assign) CGFloat scale;
@end

@implementation RelativeWaveDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"picture.jpg"]];
    imageView.center = CGPointMake(CGRectGetMidX(self.transformView.contentView.bounds),
                                   CGRectGetMidY(self.transformView.contentView.bounds));
    
    [self.transformView.contentView addSubview:imageView];
    
    // we don't want any shading on this one
    self.transformView.diffuseLightFactor = 0.0;
    
    //[self meshBuldgeAtPoint:imageView.center];
    self.scale = 3;
    
        self.transformView.diffuseLightFactor = 0.5;
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0/2000.0;
    self.transformView.supplementaryTransform = perspective;
    
    [self identityMesh];
    
    RelativeMeshTransformAnimation *animation = [RelativeMeshTransformAnimation animation];
    animation.meshBlock = ^(double progress) {
        BCMutableMeshTransform *mesh = [BCMutableMeshTransform identityMeshTransformWithNumberOfRows:50 numberOfColumns:50];
        [mesh mapVerticesUsingBlock:^BCMeshVertex(BCMeshVertex vertex, NSUInteger vertexIndex) {
            CGFloat waves = 4;
            float nz = sinf((vertex.from.y + progress) * waves * M_PI * 2);
            vertex.to.z = 0.5 + nz * 0.25;
            vertex.to.x = (vertex.from.x *.9) + .05;
            return vertex;
        }];
        
        // This should but cannot be handled automatically by RelativeMeshTransformAnimation, identity mesh is not known:
        BCMutableMeshTransform *identity = [BCMutableMeshTransform identityMeshTransformWithNumberOfRows:50 numberOfColumns:50];
        [mesh subtractMesh:identity];
        return mesh;
    };
    animation.duration = 5.0;
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = NO;
    [self.transformView addMeshAnimation:animation forKey:@"explicit"];
    
    UIPinchGestureRecognizer *pinchGestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    [self.view addGestureRecognizer:pinchGestureRecognizer];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.transformView removeMeshAnimationForKey:@"explicit"];
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)gestureRecognizer
{
    self.scale = [gestureRecognizer scale];
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) [self identityMesh];
    else [self meshAtPoint:[gestureRecognizer locationInView:self.view]];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event]; // ugly
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.transformView];
    
    [self meshAtPoint:point];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self identityMesh];
}
-(void)identityMesh {
    self.transformView.meshTransform = [BCMutableMeshTransform identityMeshTransformWithNumberOfRows:50 numberOfColumns:50];
}


- (void)meshAtPoint:(CGPoint)point {
    
    const CGFloat Bulginess = self.scale/10;
    CGFloat radius = 300;
    CGSize size = self.transformView.bounds.size;
    
    BCMutableMeshTransform *transform = [BCMutableMeshTransform identityMeshTransformWithNumberOfRows:50 numberOfColumns:50];
    
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
        
        CGFloat scale = -1 * Bulginess*(cos(t * M_PI) + 1.0);
        
        v.to.x += dx * scale;
        v.to.y += dy * scale / yScale;
        //v.to.z = scale * 0.2;
        [transform replaceVertexAtIndex:i withVertex:v];
    }
    self.transformView.meshTransform = transform;
}


@end
