/*
 *  NSRTMTaskseries.m
 *  RTMApiTest
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

#import "NSRTMTaskseries.h"


@implementation NSRTMTaskseries

-(NSString *)getID {
	return task_id;
}

-(NSString *)getName {
	return name;
}

-(NSDate *)getCreated {
	return [NSDate dateFromISO8601:created];
}

-(NSDate *)getModified {
	return [NSDate dateFromISO8601:modified];
}
-(NSString *)getSource {
	return source;
}
-(NSString *)getUrl {
	return url;
}
-(NSString *)getLocationId {
	return location_id;
}

-(NSMutableArray *)getNotes {
	return notes;
}

-(NSMutableArray *)getTags {
	return tags;
}

-(NSMutableArray *)getTasks {
	return tasks;
}

-(NSRTMTask *)getMainTask {
	NSRTMTask *mainTask = nil;
	if(tasks != nil && [tasks count] > 0) {
		mainTask = [tasks objectAtIndex:0];
	}
	return mainTask;
}

-(NSDate *)getTaskDueDate {
	return [[self getMainTask] getDue];
}

-(NSDate *)getTaskCompletedDate {
	return [[self getMainTask] getCompleted];
}

-(NSDate *)getTaskDeletedDate {
	return [[self getMainTask] getDeleted];
}

-(NSString *)getTaskPriority {
	return [[self getMainTask] getPriority];
}

-(NSString *)getTaskPosponed {
	return [[self getMainTask] getPostponed];
}

-(NSString *)getTaskEstimate {
	return [[self getMainTask] getEstimate];
}

-(NSString *)description {
	return [NSString stringWithFormat:@"Id: %@ - %@ (TaskId: %@)",task_id,name,[[tasks objectAtIndex:0] getId]];
}
@end
