/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "TiViewwrapperViewProxy.h"
#import "TiUtils.h"

@implementation TiViewwrapperViewProxy

-(void)add:(id)arg
{
	// allow either an array of arrays or an array of single proxy
	if ([arg isKindOfClass:[NSArray class]])
	{
		for (id a in arg)
		{
			[self add:a];
		}
		return;
	}
	
    
	if ([NSThread isMainThread])
	{
		pthread_rwlock_wrlock(&childrenLock);
		if (children==nil)
		{
			children = [[NSMutableArray alloc] initWithObjects:arg,nil];
		}
		else
		{
			[children addObject:arg];
		}
        //Turn on clipping because I have children
        [self view].clipsToBounds = YES;
        
		pthread_rwlock_unlock(&childrenLock);
		[arg setParent:self];
		[self contentsWillChange];
		if(parentVisible && !hidden)
		{
			[arg parentWillShow];
		}
		
		//If layout is non absolute push this into the layout queue
		//else just layout the child with current bounds
		if (!TiLayoutRuleIsAbsolute(layoutProperties.layoutStyle) ) {
			[self contentsWillChange];
		}
		else {
			[self layoutChild:arg optimize:NO withMeasuredBounds:[[self view] bounds]];
		}
	}
	else
	{
		[self rememberProxy:arg];
		if (windowOpened)
		{
			TiThreadPerformOnMainThread(^{[self add:arg];}, NO);
			return;
		}
		pthread_rwlock_wrlock(&childrenLock);
		if (pendingAdds==nil)
		{
			pendingAdds = [[NSMutableArray arrayWithObject:arg] retain];
		}
		else
		{
			[pendingAdds addObject:arg];
		}
		pthread_rwlock_unlock(&childrenLock);
		[arg setParent:self];
	}
}

@end
