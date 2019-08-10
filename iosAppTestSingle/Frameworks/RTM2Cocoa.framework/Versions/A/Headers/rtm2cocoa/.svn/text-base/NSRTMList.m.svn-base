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

#import "NSRTMList.h"


@implementation NSRTMList

+ (void)initialize
{
		// [self exposeBinding:@"name"];
}

-(NSMutableArray *)getTaskseries {
	return taskseries;
}

-(void)setTaskseries:(NSMutableArray *)array {
	[array retain];
	[taskseries release];
	taskseries = array;
}

-(void)addTaskSeries:(NSRTMTaskseries *)series {
	if (series != nil) {
		[taskseries addObject:series];
	}
}

-(void)updateTaskSeries:(NSRTMTaskseries *)series {
	NSRTMTaskseries *element;
	NSEnumerator * enumerator = [taskseries objectEnumerator];
	while(element = [enumerator nextObject])
	{
		NSInteger foundIndex = [taskseries indexOfObject:element];
		if(foundIndex != NSNotFound) {
			[taskseries replaceObjectAtIndex:foundIndex withObject:series];
		}
	}
}

-(NSString *)getListId {
	return listid;
}


-(NSString *)getName {
	
	return name;
}

-(NSString *)getDeleted {
	return deleted;
}
-(NSString *)getLocked {
	return locked;
}
-(NSString *)getArchived {
	return archived;
}
-(NSString *)getPosition {
	return position;
}
-(NSString *)getSmart {
	return smart;
}
-(NSString *)getSortOrder {
	return sort_order;
}

-(BOOL)isEqual:(id)object {
	BOOL isEqual = NO;
	if ([object isKindOfClass:[NSRTMList class]]) {
		NSString *objListId = [object getListId];
		if([listid isEqual:objListId]) {
			isEqual = YES;
		}
	}
	return isEqual;
}

@end
