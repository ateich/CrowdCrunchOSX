//
//  PathTransformer.m
//  CrowdCrunch
//
//  Created by HackReactor on 11/10/14.
//  Copyright (c) 2014 HackReactor. All rights reserved.
//

#import "PathTransformer.h"

@implementation PathTransformer

+ (Class)transformedValueClass
{
    return [NSString self];
}

+ (BOOL)allowsReverseTransformation
{
    return NO;
}

- (id)transformedValue:(id)beforeObject
{
    if (beforeObject == nil) return nil;
    id resourcePath = [[NSBundle mainBundle] resourcePath];
    return [resourcePath stringByAppendingPathComponent:beforeObject];
}

@end
