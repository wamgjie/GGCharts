//
//  GGCircle.m
//  GGCharts
//
//  Created by _ | Durex on 2017/9/23.
//  Copyright © 2017年 I really is a farmer. All rights reserved.
//

#import "GGCircle.h"

void GGPathAddCircle(CGMutablePathRef ref, GGCircle circle)
{
    CGPathAddEllipseInRect(ref, NULL, CGRectMake(circle.center.x - circle.radius, circle.center.y - circle.radius, circle.radius * 2, circle.radius * 2));
}

void GGPathAddCircles(CGMutablePathRef ref, CGPoint *center, CGFloat radius, size_t count)
{
    for (int i = 0; i < count; i++) {
        
        GGCircle circle = GGCirclePointMake(center[i], radius);
        GGPathAddCircle(ref, circle);
    }
}

void GGPathAddRangeCircles(CGMutablePathRef ref, CGPoint *center, CGFloat radius, int from, int to)
{
    for (int i = from; i < to; i++) {
        
        GGCircle circle = GGCirclePointMake(center[i], radius);
        GGPathAddCircle(ref, circle);
    }
}

NSArray * GGPathCirclesStretchAnimation(CGPoint * points, CGFloat radius, size_t size, CGFloat y)
{
    NSMutableArray * ary = [NSMutableArray array];
    
    for (NSInteger i = 0; i < size; i++) {
        
        CGPoint basePoints[size];
        
        for (NSInteger j = 0; j < size; j++) {
            
            basePoints[j] = CGPointMake(points[j].x, y);
        }
        
        for (NSInteger z = 0; z < i; z++) {
            
            basePoints[z] = CGPointMake(points[z].x, points[z].y);
        }
        
        CGMutablePathRef ref = CGPathCreateMutable();
        GGPathAddRangeCircles(ref, basePoints, radius, 0, (int)i);
        GGPathAddRangeCircles(ref, basePoints, 0, (int)i, (int)size);
        [ary addObject:(__bridge id)ref];
        CGPathRelease(ref);
    }
    
    CGMutablePathRef ref = CGPathCreateMutable();
    GGPathAddCircles(ref, points, radius, size);
    [ary addObject:(__bridge id)ref];
    CGPathRelease(ref);
    
    return ary;
}

NSArray * GGPathCirclesUpspringAnimation(CGPoint * points, CGFloat radius, size_t size, CGFloat y)
{
    NSMutableArray * ary = [NSMutableArray array];
    
    CGPoint basePoints[size];
    
    for (NSInteger i = 0; i < size; i++) {
        
        basePoints[i] = CGPointMake(points[i].x, y);
    }
    
    CGMutablePathRef ref = CGPathCreateMutable();
    GGPathAddCircles(ref, basePoints, 0, size);
    [ary addObject:(__bridge id)ref];
    CGPathRelease(ref);
    
    ref = CGPathCreateMutable();
    GGPathAddCircles(ref, points, radius, size);
    [ary addObject:(__bridge id)ref];
    CGPathRelease(ref);
    
    return ary;
}