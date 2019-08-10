/*
 *  NSRTM.h
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
#import "RTMDelegate.h"
#import "NSRTMResponse.h"
#import "NSRTMTimeline.h"
#import "NSRTMCriteria.h"
#import "NSRTMPredicate.h"
#import "NSRTMRecurrence.h"
#import "NSRTMLocation.h"
#import "NSRTMNote.h"
#import "NSRTMSettings.h"
#import "NSRTMLocator.h"

#define RTMAuthDelete @"delete"
#define RTMAuthRead @"read"
#define RTMAuthWrite @"write"

typedef enum _NSRTMPriorityDirection{
    NSRTMDirectionUp = 1,
    NSRTMDirectionDown = 0
} NSRTMPriorityDirection;

typedef enum _NSRTMPriority{
    NSRTMPriorityN = 0,
    NSRTMPriorityOne = 1,
    NSRTMPriorityTwo = 2,
    NSRTMPriorityTree = 3
} NSRTMPriority;

@class NSRTMInvoker,NSRTMService,NSRTMController;
@interface NSRTM : NSObject {
	NSRTMInvoker *mainInvoker;
	NSRTMService *mainService;
	NSString *api_key;
	NSString *sicret;
	NSString *frob;
	NSString *token;
	NSString *lastTimeline;
	
	NSRTMController *dialogController;
	NSUserDefaults *defaults;
	
	id<RTMDelegate,NSObject> rtmDelegate;
}

-(id)initWithApikey:(NSString *)apikey andSicret:(NSString *)sicretvalue;
- (BOOL)loadMyNibFile;

-(NSRTMResponse *)getMethods;

-(void)setDelegate:(id)val;
-(id)delegate;
-(void)manageError:(NSRTMError *)error;

-(BOOL)isRegistrated;
-(void)authenticate:(NSString *)level;
-(BOOL)saveToken;

-(NSString *)testEcho:(NSMutableArray *)params;

-(NSString *)generateFrob;
-(BOOL)checkToken;
-(NSString *)getToken;
#pragma mark -

#pragma mark Extra
-(NSMutableArray *)getFullTaskLists;
#pragma mark -
#pragma mark MethodsContacts
-(NSString *)addContact:(NSString *)contact;
-(BOOL)deleteContact:(NSString *)contactId;
-(NSMutableArray *)getContactsList;
#pragma mark -

#pragma mark Timeline
-(NSString *)createTimeline;
-(NSString *)getLastTimeline;
-(BOOL)undo:(NSString *)transactionid;
#pragma mark -

#pragma mark ListMethods
-(NSRTMList *)addList:(NSString *)name filter:(NSRTMPredicate *)predicate; // *timeline
-(BOOL)archiveList:(NSInteger)listId; // *timeline
-(BOOL)unarchiveList:(NSInteger)listId; // *timeline
-(BOOL)deleteList:(NSInteger)listId; // *timeline
-(NSMutableArray *)getLists;
-(BOOL)setDefaultList:(NSInteger)listId; // *timeline
-(NSRTMList *)setListName:(NSString *)name withId:(NSInteger)listId; // *timeline
#pragma mark -

#pragma mark LocationMethods
-(NSMutableArray *)getLocationsList;
-(NSRTMSettings *)getSettingsList;
-(NSMutableArray *)getTinmezones;
#pragma mark -

#pragma mark TaskMethods
-(NSRTMList *)addNewTask:(NSString *)name atList:(NSInteger)listId parse:(BOOL)option; // *timeline
-(NSRTMList *)addTags:(NSMutableArray *)tags withLocator:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)completeTask:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)deleteTask:(NSRTMLocator *)locator; // *timeline
-(NSMutableArray *)getTaskList;
-(NSMutableArray *)getTaskListWithId:(NSInteger)listId;
-(NSMutableArray *)getTaskListWithId:(NSInteger)listId filter:(NSRTMPredicate *)predicate lastSync:(NSDate *)time;
-(NSRTMList *)movePriority:(NSRTMPriorityDirection)direction withLocator:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)moveToList:(NSInteger)fromId withLocator:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)posponeTask:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)removeTags:(NSMutableArray *)tags withLocator:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)setDueDate:(NSDate *)date withLocator:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)setDueDateWithString:(NSString *)date withLocator:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)removeDueDate:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)setEstimate:(NSInteger)time withLocator:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)removeEstimate:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)setLocation:(NSRTMLocation *)location withLocator:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)setName:(NSString *)name withLocator:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)setPriority:(NSRTMPriority)priority withLocator:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)removePriority:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)setRecurrence:(NSRTMRecurrence *)recurrence withLocator:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)setTags:(NSMutableArray *)tags withLocator:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)setUrl:(NSURL *)url withLocator:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)removeUrl:(NSRTMLocator *)locator; // *timeline
-(NSRTMList *)uncompleteTask:(NSRTMLocator *)locator; // *timeline
#pragma mark -

#pragma mark NoteMethods
-(NSRTMNote *)addNoteWithTitle:(NSString *)title andText:(NSString *)text withLocator:(NSRTMLocator *)locator; // *timeline
-(BOOL)removeNote:(NSInteger)noteId; // *timeline
-(NSRTMNote *)editNote:(NSInteger)noteId title:(NSString *)titlevalue andText:(NSString *)text; // *timeline
#pragma mark -

@end
