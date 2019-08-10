/*
 *  DebugLog.m
 *  DebugLog
 *
 *  Created by Karl Kraft on 3/22/09.
 *  Copyright 2009 Karl Kraft. All rights reserved.
 *
 */

#include "DebugLog.h"

void _DebugLog(const char *file, int lineNumber, const char *funcName, NSString *format,...) {
	va_list ap;
	
	va_start (ap, format);
	if (![format hasSuffix: @"\n"]) {
		format = [format stringByAppendingString: @"\n"];
	}
	NSString *body =  [[NSString alloc] initWithFormat: format arguments: ap];
	va_end (ap);
	const char *threadName = [[[NSThread currentThread] name] UTF8String];
	NSString *dateandtime = [[NSDate date] description];
	NSString *fileName=[[NSString stringWithUTF8String:file] lastPathComponent];
	if (threadName) {
		fprintf(stderr,"[%s] %s/%s (%s:%d) %s",[dateandtime UTF8String],threadName,funcName,[fileName UTF8String],lineNumber,[body UTF8String]);
	} else {
		fprintf(stderr,"[%s] %p/%s (%s:%d) %s",[dateandtime UTF8String],[NSThread currentThread],funcName,[fileName UTF8String],lineNumber,[body UTF8String]);
	}
	[body release];	
}

void _DebugLogE(const char *file, int lineNumber, const char *funcName, NSString *format,...) {
	va_list ap;
	
	va_start (ap, format);
	if (![format hasSuffix: @"\n"]) {
		format = [format stringByAppendingString: @"\n"];
	}
	NSString *body =  [[NSString alloc] initWithFormat: format arguments: ap];
	va_end (ap);
	const char *threadName = [[[NSThread currentThread] name] UTF8String];
	NSString *dateandtime = [[NSDate date] description];
	NSString *fileName=[[NSString stringWithUTF8String:file] lastPathComponent];
	if (threadName) {
		fprintf(stderr,"ERROR - [%s] %s/%s (%s:%d) %s",[dateandtime UTF8String],threadName,funcName,[fileName UTF8String],lineNumber,[body UTF8String]);
	} else {
		fprintf(stderr,"ERROR - [%s] %p/%s (%s:%d) %s",[dateandtime UTF8String],[NSThread currentThread],funcName,[fileName UTF8String],lineNumber,[body UTF8String]);
	}
	[body release];	
}

