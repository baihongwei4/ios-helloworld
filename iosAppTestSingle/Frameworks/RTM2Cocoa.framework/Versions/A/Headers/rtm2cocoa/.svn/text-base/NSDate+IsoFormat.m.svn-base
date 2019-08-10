/*
*  NSDate+IsoFormat.m
*  ApiTest
*
*  Created by kkillian on 17/11/09.
*  Copyright 2009 shufflecodebox. All rights reserved.
*	This program is free software; you can redistribute it and/or modify
*	it under the terms of the GNU General Public License as published by
*	the Free Software Foundation; either version 2 of the License, or
*	(at your option) any later version.
*
*	This program is distributed in the hope that it will be useful,
*	but WITHOUT ANY WARRANTY; without even the implied warranty of
*	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*	GNU General Public License for more details.
*
*	You should have received a copy of the GNU General Public License
*	along with this program; if not, write to the Free Software
*	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

#import "NSDate+IsoFormat.h"

#define ISO_TIMEZONE_UTC_FORMAT @"Z"
#define ISO_TIMEZONE_OFFSET_FORMAT @"+%f:%f"

@implementation NSDate (IsoFormat)

+(NSString *) strFromISO8601:(NSDate *) date {
    static NSDateFormatter* sISO8601 = nil;
	date = [NSDate moveDateToZTimezone:date];
    if (!sISO8601) {
        sISO8601 = [[NSDateFormatter alloc] init];
        NSMutableString *strFormat = [NSMutableString stringWithString:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        [sISO8601 setDateFormat:strFormat];
    }
    return [sISO8601 stringFromDate:date];
} 

+(NSDate *) dateFromISO8601:(NSString *) str {
    static NSDateFormatter* sISO8601 = nil;
	
    if (!sISO8601) {
        sISO8601 = [[NSDateFormatter alloc] init];
        [sISO8601 setTimeStyle:NSDateFormatterFullStyle];
        [sISO8601 setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    }
    if ([str hasSuffix:@"Z"]) {
        str = [str stringByReplacingOccurrencesOfString:@"Z" withString:@"-0000"];
    }
	
    NSDate *d = [sISO8601 dateFromString:str];
    return d;
	
}

+(NSDate *)moveDateToZTimezone:(NSDate *)sourceDate {
	
	NSTimeZone* sourceTimeZone = [NSTimeZone systemTimeZone];
	NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
	NSTimeInterval interval = - sourceGMTOffset;
	
	return [[[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate] autorelease];

}
@end
