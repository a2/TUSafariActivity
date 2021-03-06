//
//  TUSafariActivity.h
//
//  Created by David Beck on 11/30/12.
//  Copyright (c) 2012 ThinkUltimate. All rights reserved.
//
//  http://github.com/davbeck/TUSafariActivity
//
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//
//  - Redistributions of source code must retain the above copyright notice,
//    this list of conditions and the following disclaimer.
//  - Redistributions in binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
//  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
//  INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
//  BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//  DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
//  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
//  OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import "TUSafariActivity.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@implementation TUSafariActivity
{
	NSURL *_URL;
}

+ (NSBundle *)bundle
{
	NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"TUSafariActivity" withExtension:@"bundle"];
	if (bundleURL) {
		return [NSBundle bundleWithURL:bundleURL];
	} else {
		return [NSBundle mainBundle];
	}
}

- (NSString *)activityType
{
	return NSStringFromClass([self class]);
}

- (NSString *)activityTitle
{
	return NSLocalizedStringFromTableInBundle(@"Open in Safari", @"TUSafariActivity", [TUSafariActivity bundle], nil);
}

- (UIImage *)activityImage
{
	NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"TUSafariActivity" withExtension:@"bundle"];
	NSString *imageName = [NSString stringWithFormat:@"%@Safari%@", bundleURL ? @"TUSafariActivity.bundle/" : @"", SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0") ? @"7" : @""];
	return [UIImage imageNamed:imageName];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
	for (id activityItem in activityItems) {
		if ([activityItem isKindOfClass:[NSURL class]] && [[UIApplication sharedApplication] canOpenURL:activityItem]) {
			return YES;
		}
	}
	
	return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
	for (id activityItem in activityItems) {
		if ([activityItem isKindOfClass:[NSURL class]]) {
			_URL = activityItem;
		}
	}
}

- (void)performActivity
{
	BOOL completed = [[UIApplication sharedApplication] openURL:_URL];
	
	[self activityDidFinish:completed];
}

@end
