/*
 *  DebugLog.h
 *  DebugLog
 *
 *  Created by Karl Kraft on 3/22/09.
 *  Copyright 2009 Karl Kraft. All rights reserved.
 *
 */

#ifdef DEBUG
#define DLog(args...) _DebugLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#define ELog(args...) _DebugLogE(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#else
#define DLog(x...)
#define ELog(args...)
#endif

void _DebugLog(const char *file, int lineNumber, const char *funcName, NSString *format,...);
void _DebugLogE(const char *file, int lineNumber, const char *funcName, NSString *format,...);
