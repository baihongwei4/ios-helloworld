/*
 *  NSRTMList.h
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
#import "NSRTMTaskseries.h"
#import "NSRTMObject.h"

@interface NSRTMList : NSRTMObject {
	NSString *listid;
	NSString *name;
	NSString *deleted;
	NSString *locked;
	NSString *archived;
	NSString *position;
	NSString *smart;
	NSString *sort_order;
	NSMutableArray *taskseries;
}

-(NSString *)getListId;
-(NSString *)getName;
-(NSString *)getDeleted;
-(NSString *)getLocked;
-(NSString *)getArchived;
-(NSString *)getPosition;
-(NSString *)getSmart;
-(NSString *)getSortOrder;

-(NSMutableArray *)getTaskseries;
-(void)setTaskseries:(NSMutableArray *)array;

-(void)addTaskSeries:(NSRTMTaskseries *)series;
-(void)updateTaskSeries:(NSRTMTaskseries *)series;

@end
