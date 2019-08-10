/*
 *  NSRTMTaskseries.h
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

#import <Cocoa/Cocoa.h>
#import "NSRTMObject.h"
#import "NSRTMTask.h"

@interface NSRTMTaskseries : NSRTMObject {
	NSString *task_id;
	NSString *name;
	NSString *created;
	NSString *modified;
	NSString *source;
	NSString *url;
	NSString *location_id;
	NSMutableArray *notes;
	NSMutableArray *tags;
	NSMutableArray *tasks;
}

-(NSString *)getID;
-(NSString *)getName;
-(NSDate *)getCreated;
-(NSDate *)getModified;
-(NSString *)getSource;
-(NSString *)getUrl;
-(NSString *)getLocationId;
-(NSMutableArray *)getNotes;
-(NSMutableArray *)getTags;
-(NSMutableArray *)getTasks;

#pragma mark Extra Methos
-(NSRTMTask *)getMainTask;
-(NSDate *)getTaskDueDate;
-(NSDate *)getTaskCompletedDate;
-(NSDate *)getTaskDeletedDate;
-(NSString *)getTaskPriority;
-(NSString *)getTaskPosponed;
-(NSString *)getTaskEstimate;

#pragma mark -
@end
