/*
*  NSRTMParamsCriteria.h
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

#import <Cocoa/Cocoa.h>
#import "NSRTMCriteria.h"

typedef enum _NSRTMStatusOptions {
    NSRTMTaskStatusCompleted = 1,
    NSRTMTaskStatusInCompleted = 0
} NSRTMStatusOptions;

typedef enum _NSRTMPosponedFilter{
    NSRTMPosponedEqual= 0,
    NSRTMPosponedGreater= 1,
    NSRTMPosponedLower= -1
} NSRTMPosponedFilter;

@interface NSRTMParamsCriteria : NSRTMCriteria {

}

+(NSRTMParamsCriteria *)criteriaWithListName:(NSString *)value;
+(NSRTMParamsCriteria *)criteriaWithTaskName:(NSString *)value;
+(NSRTMParamsCriteria *)criteriaWithNote:(NSString *)value;
+(NSRTMParamsCriteria *)criteriaWithNoted:(BOOL)value;
+(NSRTMParamsCriteria *)criteriaWithPriority:(NSInteger *)value;
+(NSRTMParamsCriteria *)criteriaWithStatus:(NSRTMStatusOptions)value;
+(NSRTMParamsCriteria *)criteriaWithEstimeteTime:(NSString *)value;
+(NSRTMParamsCriteria *)criteriaWithPosponedNum:(NSInteger*)value option:(NSRTMPosponedFilter)filter;
@end
