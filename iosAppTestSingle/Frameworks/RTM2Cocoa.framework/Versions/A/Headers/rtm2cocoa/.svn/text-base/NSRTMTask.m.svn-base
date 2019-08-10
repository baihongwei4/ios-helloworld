/*
*  NSRTMTask.m
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

#import "NSRTMTask.h"


@implementation NSRTMTask

-(NSString *)getId {
	return task_id;
}
-(NSDate *)getDue {
	return [NSDate dateFromISO8601:due];
}
-(NSString *)getHasDueTime {
	return has_due_time;
}
-(NSDate *)getAdded {
	return [NSDate dateFromISO8601:added];
}
-(NSDate *)getCompleted {
	return [NSDate dateFromISO8601:completed];
}
-(NSDate *)getDeleted {
	return [NSDate dateFromISO8601:deleted];
}
-(NSString *)getPriority {
	return priority;
}
-(NSString *)getPostponed {
	return postponed;
}
-(NSString *)getEstimate {
	return estimate;
}

@end
