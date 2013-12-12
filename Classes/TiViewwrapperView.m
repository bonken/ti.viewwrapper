/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiViewwrapperView.h"
#import "TiViewwrapperViewProxy.h"
#import "TiUtils.h"

@implementation TiViewwrapperView

- (void)setWrap_:(id)viewProxy {
    NSLog(@"[INFO] view class: %@", NSStringFromClass([[viewProxy view] class]));
    [self addSubview:(UIView*)[viewProxy view]];
}



@end