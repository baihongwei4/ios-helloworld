/*
 *  NSRTM.m
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

/**
 * NSRTM is the main class of the Cocoa2RTM framework
 * Usage:
 * User Authentication
 * Generate a frob code
 * With the frob code generate a auth process and allow application in the user account. This process will generate a token code
 * Request the token code.
 * Now you are ready to work with RTM
 */
#import "NSRTM.h"
#import "DebugLog.h"
#import "NSRTMMethod.h"
#import "NSRTMInvoker.h"
#import "NSRTMService.h"
#import "NSRTMController.h"

// AUTH METHODS
#define RTM_AUTH_checkToken @"rtm.auth.checkToken"
#define RTM_AUTH_getFrob @"rtm.auth.getFrob"
#define RTM_AUTH_getToken @"rtm.auth.getToken"

// CONTACTS METHOD
#define RTM_CONTACTS_add @"rtm.contacts.add"
#define RTM_CONTACTS_delete @"rtm.contacts.delete"
#define RTM_CONTACTS_getList @"rtm.contacts.getList"

// GROUP METHODS
#define RTM_GROUPS_add @"rtm.groups.add"
#define RTM_GROUPS_addContact @"rtm.groups.addContact"
#define RTM_GROUPS_delete @"rtm.groups.delete"
#define RTM_GROUPS_getList @"rtm.groups.getList"
#define RTM_GROUPS_removeContact @"rtm.groups.removeContact"

//LISTS METHODS
#define RTM_LISTS_add @"rtm.lists.add"
#define RTM_LISTS_archive @"rtm.lists.archive"
#define RTM_LISTS_delete @"rtm.lists.delete"
#define RTM_LISTS_getList @"rtm.lists.getList"
#define RTM_LISTS_setDefaultList @"rtm.lists.setDefaultList"
#define RTM_LISTS_setName @"rtm.lists.setName"
#define RTM_LISTS_unarchive @"rtm.lists.unarchive"

// LOCATION METHOD
#define RTM_LOCATIONS_getList @"rtm.locations.getList"

// REFLECTION METHOD
#define RTM_REFLECTION_getMethodInfo @"rtm.reflection.getMethodInfo"
#define RTM_REFLECTION_getMethods @"rtm.reflection.getMethods"

// SETTINGS METHOD
#define RTM_SETTINGS_getList @"rtm.settings.getList"

// TASKS METHODS
#define RTM_TASKS_add @"rtm.tasks.add"
#define RTM_TASKS_addTags @"rtm.tasks.addTags"
#define RTM_TASKS_complete @"rtm.tasks.complete"
#define RTM_TASKS_delete @"rtm.tasks.delete"
#define RTM_TASKS_getList @"rtm.tasks.getList"
#define RTM_TASKS_movePriority @"rtm.tasks.movePriority"
#define RTM_TASKS_moveTo @"rtm.tasks.moveTo"
#define RTM_TASKS_notes_add @"rtm.tasks.notes.add"
#define RTM_TASKS_notes_delete @"rtm.tasks.notes.delete"
#define RTM_TASKS_notes_edit @"rtm.tasks.notes.edit"
#define RTM_TASKS_postpone @"rtm.tasks.postpone"
#define RTM_TASKS_removeTags @"rtm.tasks.removeTags"
#define RTM_TASKS_setDueDate @"rtm.tasks.setDueDate"
#define RTM_TASKS_seEstimate @"rtm.tasks.setEstimate"
#define RTM_TASKS_setLocation @"rtm.tasks.setLocation"
#define RTM_TASKS_setName @"rtm.tasks.setName"
#define RTM_TASKS_setPriority @"rtm.tasks.setPriority"
#define RTM_TASKS_setRecurrence @"rtm.tasks.setRecurrence"
#define RTM_TASKS_setTags @"rtm.tasks.setTags"
#define RTM_TASKS_setURL @"rtm.tasks.setURL"
#define RTM_TASKS_uncomplete @"rtm.tasks.uncomplete"

	// NOTE METHODS
#define RTM_NOTE_add @"rtm.tasks.notes.add"
#define RTM_NOTE_delete @"rtm.tasks.notes.delete"
#define RTM_NOTE_edit @"rtm.tasks.note.edit"
// TEST METHODS
#define RTM_TEST_echo @"rtm.test.echo"
#define RTM_TEST_login @"rtm.test.login"

// TIME METHODS
#define RTM_TIME_convert @"rtm.time.convert"
#define RTM_TIME_parse @"rtm.time.parse"

// OTHERS
#define RTM_TIMELINES_create @"rtm.timelines.create"

#define RTM_TIMEZONES_getList @"rtm.timezones.getList"

#define RTM_TRANSACTIONS_undo @"rtm.transactions.undo"

#define RTMPrefSavedToken @"rtm.cocoa.token.pref"
#define RTMPrefSavedFrob @"rtm.cocoa.frob.pref"

@implementation NSRTM

/**
 * Inizialize the RTM controller
 * @param apikey the apikey for all the methos
 * @param sicretvalue the sicret given with the apikey
 */
#pragma mark Inizialize
-(id)initWithApikey:(NSString *)apikey andSicret:(NSString *)sicretvalue {
	self = [super init];
	if(![self loadMyNibFile]) {
		NSException *exception = [NSException exceptionWithName:@"ComponenteException" reason:@"Unable to load the bundle"  userInfo:nil];
		@throw exception;
	}
	if (self != nil) {
		api_key = apikey;
		sicret = sicretvalue;
		if(api_key != nil && sicret != nil) {
			mainInvoker = [[NSRTMInvoker alloc] initWithApiKey:api_key andSicret:sicret];
			if(mainInvoker != nil) {
				mainService = [[NSRTMService alloc] initWithInvoker:mainInvoker];
			}
		}
		defaults = [NSUserDefaults standardUserDefaults];
		
		if([defaults stringForKey:RTMPrefSavedToken] != NULL) {
			token = [defaults stringForKey:RTMPrefSavedToken];
		}
	} else {
		NSException *exception = [NSException exceptionWithName:@"InitException" reason:@"apikey and sicretValue can't be nil"  userInfo:nil];
		@throw exception;
	}
	return self;
}

- (BOOL)loadMyNibFile {
    // The myNib file must be in the bundle that defines self's class.
	dialogController = [[NSRTMController alloc] init];
	[dialogController setDelegate:self];
    if (![NSBundle loadNibNamed:@"rtm" owner:dialogController]) {
        DLog(@"Warning! Could not load myNib file.\n");
        return NO;
    }
    return YES;
	
}

-(void)dealloc {
	[mainInvoker release];
	[mainService release];	
	[dialogController release];
	[super dealloc];
}

#pragma mark -

#pragma mark Delegate

-(void)setDelegate:(id)val {
	rtmDelegate = val;
}
-(id)delegate {
	return rtmDelegate;
}

- (void)manageError:(NSRTMError *)error {
    if ([rtmDelegate respondsToSelector:@selector(manageRTMError:)]) {
        [rtmDelegate manageRTMError:error];
    } else {
		[NSApp presentError:error];
			// [NSException raise:NSInternalInconsistencyException format:@"Delegate doesn't respond to manageRTMError"];
    }
}
#pragma mark -

#pragma mark Extra
-(NSMutableArray *)getFullTaskLists {
	NSMutableArray *lists = [self getLists];
	if(lists != nil && [lists count] > 0) {
		NSMutableArray *fullists = [self getTaskList];
		NSEnumerator * enumerator = [lists objectEnumerator];
		NSRTMList *element;	
		while(element = [enumerator nextObject])
		{
			NSInteger foundIndex = [fullists indexOfObject:element];
			if(foundIndex != NSNotFound) {
				NSRTMList *fullList = [fullists objectAtIndex:foundIndex];
				[element setTaskseries:[fullList getTaskseries]];
			}
		}
	}
	return lists;
}
#pragma mark -

#pragma mark MainMethods

/**
 * Method can be called without authenticate
 * return a list of all the available api methods
 * @return NSRTMResponse
 */
-(NSRTMResponse *)getMethods {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_REFLECTION_getMethods]];
	if([mainService execute:params error:&error]) {
		return [mainService getResponse];
	} else {
		[self manageError:error];
		return nil;
	}
}

#pragma mark -

#pragma mark Authenticate
-(BOOL)isRegistrated {
	BOOL isRegistrated = NO;
	if([defaults stringForKey:RTMPrefSavedToken] != NULL) {
		token = [defaults stringForKey:RTMPrefSavedToken];
		if([self checkToken]) {
			isRegistrated = YES;
		}		
	}
	return isRegistrated;	
}

/**
 * This method generate the process for the authentication
 * @param level the level of authentication
 * @see generateFrob
 */
-(void)authenticate:(NSString *)level {
		
	frob = [self generateFrob];
	DLog(@"My Frob: %@",frob);
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"perms" value:level]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"frob" value:frob]];
	if([mainService auth:params]) {
		[dialogController openDialog:self];
	}
}

/**
 * Generate Frob
 * with this method send a request for generate frob string
 * @return NSRTMResponse
 */
-(NSString *)generateFrob {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_AUTH_getFrob]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if (error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getFrob];
	}
}

/**
 * Generate the auth token
 */
-(NSString *)getToken {
	NSRTMError *error = nil;
	if(frob != NULL) {	
		NSMutableArray *params = [[NSMutableArray alloc] init];
		[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_AUTH_getToken]];
		[params addObject:[[NSRTMParam alloc] initWithKey:@"frob" value:frob]];
		NSRTMResponse *response = [mainService execute:params error:&error];
		if(error) {
			[self manageError:error];
			return nil;
		} else {
			return [[response getAuth] getToken];
		}
	} else {
		return nil;
	}
}

/**
 * Check the auth token
 */
-(BOOL)checkToken {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_AUTH_checkToken]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	
	[mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return NO;
	} else {
		return YES;
	}
}

/**
 * This method save the auth token in the preferencies
 */
-(BOOL)saveToken {
	BOOL isSaved = NO;
	if(frob != NULL) {		
		NSString *theToken = [self getToken];
		DLog(@"theToken: %@",theToken);
		if(theToken != NULL) {
			[defaults setObject:theToken forKey:RTMPrefSavedToken];
			isSaved = YES;
		}			
	}
	return isSaved;
}
#pragma mark -

#pragma mark Methos

/**
 * Test method can be called without any api key
 * if you send some parameters it will respont with an acho of that parameters
 * @param params the listo of parameters to sent in the interface request
 * @return NSRTMResponse
 */
-(NSString *)testEcho:(NSMutableArray *)params {
	NSRTMError *error = nil;
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TEST_echo]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response description];
	}
}
#pragma mark -

#pragma mark MethodsContacts

-(NSString *)addContact:(NSString *)contact {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_CONTACTS_add]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"contact" value:contact]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [[response getContact] getContact_id];
	}
	
}

-(BOOL)deleteContact:(NSString *)contactId {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_CONTACTS_delete]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"contact_id" value:contactId]];	
	
	[mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return NO;
	} else {
		return YES;
	}
	
}

-(NSMutableArray *)getContactsList {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_CONTACTS_getList]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getContacts];
	}
	
}

#pragma mark -

#pragma mark Timeline

-(NSString *)createTimeline {
	NSRTMError *error = nil;
	NSString *timelineString = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TIMELINES_create]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];	
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		NSRTMTimeline *timeline = [response getTimeline];
		timelineString = [NSString stringWithString:[timeline getValue]];
		lastTimeline = timelineString;
	}
	return timelineString;	
}

-(NSString *)getLastTimeline {
	return lastTimeline;
}

-(BOOL)undo:(NSString *)transactionid {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TRANSACTIONS_undo]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:lastTimeline]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"transaction_id" value:transactionid]];
	[mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return NO;
	} else {
		return YES;
	}
	
}

#pragma mark -

#pragma mark ListMethods
-(NSRTMList *)addList:(NSString *)name filter:(NSRTMPredicate *)predicate {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_LISTS_add]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"name" value:name]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"filter" value:[predicate formattedPredicate]]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}	 
}

-(BOOL)archiveList:(NSInteger)listId {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_LISTS_archive]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[[NSNumber numberWithInteger:listId] stringValue]]];
	[mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return NO;
	} else {
		return YES;
	}	 	 
}

-(BOOL)unarchiveList:(NSInteger)listId{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_LISTS_unarchive]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[[NSNumber numberWithInteger:listId] stringValue]]];
	[mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return NO;
	} else {
		return YES;
	}	 	 	 
}

-(BOOL)deleteList:(NSInteger)listId{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_LISTS_delete]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[[NSNumber numberWithInteger:listId] stringValue]]];
	[mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return NO;
	} else {
		return YES;
	}		
}
	 
-(NSMutableArray *)getLists{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_LISTS_getList]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getLists];
	}	 	 
}

-(BOOL)setDefaultList:(NSInteger)listId{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_LISTS_setDefaultList]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[[NSNumber numberWithInteger:listId] stringValue]]];
	[mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return NO;
	} else {
		return YES;
	}	 
}
	 
-(NSRTMList *)setListName:(NSString *)name withId:(NSInteger)listId{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_LISTS_delete]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[[NSNumber numberWithInteger:listId] stringValue]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"name" value:name]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}
#pragma mark -

#pragma mark LocationMethods
-(NSMutableArray *)getLocationsList {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_LOCATIONS_getList]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getLocations];
	}
}
-(NSRTMSettings *)getSettingsList {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_SETTINGS_getList]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getSettings];
	}
}
-(NSMutableArray *)getTinmezones {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TIMEZONES_getList]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getTimezones];
	}
}
#pragma mark -

-(NSRTMList *)addNewTask:(NSString *)name atList:(NSInteger)listId parse:(BOOL)option {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_add]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[[NSNumber numberWithInteger:listId] stringValue]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"name" value:name]];
	if(option) [params addObject:[[NSRTMParam alloc] initWithKey:@"parse" value:@"1"]];

	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}

-(NSRTMList *)addTags:(NSMutableArray *)tags withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_add]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"tags" value:[tags componentsJoinedByString:@","]]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}
	 
-(NSRTMList *)completeTask:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_complete]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];

	 NSRTMResponse *response = [mainService execute:params error:&error];
	 if(error) {
		 [self manageError:error];
		 return nil;
	 } else {
		 return [response getList];
	 }
}
	 
-(NSRTMList *)deleteTask:(NSRTMLocator *)locator {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_delete]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}

-(NSMutableArray *)getTaskList {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_getList]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getListsTasks];
	}
}
-(NSMutableArray *)getTaskListWithId:(NSInteger)listId {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_getList]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[[NSNumber numberWithInteger:listId] stringValue]]];
	
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getListsTasks];
	}
	
}
-(NSMutableArray *)getTaskListWithId:(NSInteger)listId filter:(NSRTMPredicate *)predicate lastSync:(NSDate *)time {
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_getList]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[[NSNumber numberWithInteger:listId] stringValue]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"filter" value:[predicate formattedPredicate]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"last_sync" value:[time description]]];
	
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getListsTasks];
	}
}

-(NSRTMList *)movePriority:(NSRTMPriorityDirection)direction withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_movePriority]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	if(direction == NSRTMDirectionUp) {
		[params addObject:[[NSRTMParam alloc] initWithKey:@"direction" value:@"up"]];
	} else {
		[params addObject:[[NSRTMParam alloc] initWithKey:@"direction" value:@"down"]];
	}
	
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
	
}
-(NSRTMList *)moveToList:(NSInteger)fromId withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_moveTo]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"to_list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"from_task_id" value:[[NSNumber numberWithInt:fromId] stringValue]]];
	
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
	
}

-(NSRTMList *)posponeTask:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_postpone]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}	
}

-(NSRTMList *)removeTags:(NSMutableArray *)tags withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_removeTags]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"tags" value:[tags componentsJoinedByString:@","]]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}
#pragma mark Dasistemare
-(NSRTMList *)setDueDate:(NSDate *)date withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_setDueDate]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"due" value:[date description]]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}

-(NSRTMList *)setDueDateWithString:(NSString *)date withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_setDueDate]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"due" value:date]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}

-(NSRTMList *)removeDueDate:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_setDueDate]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
		// [params addObject:[[NSRTMParam alloc] initWithKey:@"due" value:date]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}
#pragma mark -

-(NSRTMList *)setEstimate:(NSInteger)time withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_seEstimate]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"estimate" value:[[NSNumber numberWithInt:time] stringValue]]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}
-(NSRTMList *)removeEstimate:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_seEstimate]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
		// [params addObject:[[NSRTMParam alloc] initWithKey:@"estimate" value:[[NSNumber numberWithInt:time] stringValue]]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}

-(NSRTMList *)setLocation:(NSRTMLocation *)location withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_setLocation]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"location_id" value:[location getLocationId]]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}
-(NSRTMList *)setName:(NSString *)name withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_setName]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"name" value:name]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}
-(NSRTMList *)setPriority:(NSRTMPriority)priority withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_setPriority]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	if(priority == NSRTMPriorityN) {
		[params addObject:[[NSRTMParam alloc] initWithKey:@"priority" value:@"N"]];
	} else {
		[params addObject:[[NSRTMParam alloc] initWithKey:@"priority" value:[[NSNumber numberWithInt:priority] stringValue]]];
	}
	
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}

-(NSRTMList *)removePriority:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_setPriority]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}

-(NSRTMList *)setRecurrence:(NSRTMRecurrence *)recurrence withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_setRecurrence]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"repeat" value:[recurrence getPeriod]]];
	
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}

-(NSRTMList *)setTags:(NSMutableArray *)tags withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_setTags]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"tags" value:[tags componentsJoinedByString:@","]]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}

-(NSRTMList *)setUrl:(NSURL *)url withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_setURL]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"url" value:[url host]]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
	
}

-(NSRTMList *)removeUrl:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_setURL]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
	
}
-(NSRTMList *)uncompleteTask:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_TASKS_uncomplete]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getList];
	}
}
#pragma mark -

#pragma mark NoteMethods
-(NSRTMNote *)addNoteWithTitle:(NSString *)title andText:(NSString *)text withLocator:(NSRTMLocator *)locator{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_NOTE_add]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"list_id" value:[locator getListId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"taskseries_id" value:[locator getTaskSeriesId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"task_id" value:[locator getTaskId]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"note_title" value:title]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"note_text" value:text]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getNote];
	}
}
-(BOOL)removeNote:(NSInteger)noteId{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_NOTE_delete]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"note_id" value:[[NSNumber numberWithInt:noteId] stringValue]]];
	[mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return NO;
	} else {
		return YES;
	}
}
-(NSRTMNote *)editNote:(NSInteger)noteId title:(NSString *)titlevalue andText:(NSString *)text{
	NSRTMError *error = nil;
	NSMutableArray *params = [[NSMutableArray alloc] init];
	[params addObject:[[NSRTMMethod alloc] initWithMethod:RTM_NOTE_edit]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"auth_token" value:token]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"timeline" value:[self createTimeline]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"note_id" value:[[NSNumber numberWithInt:noteId] stringValue]]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"note_title" value:titlevalue]];
	[params addObject:[[NSRTMParam alloc] initWithKey:@"note_text" value:text]];
	NSRTMResponse *response = [mainService execute:params error:&error];
	if(error) {
		[self manageError:error];
		return nil;
	} else {
		return [response getNote];
	}
}
#pragma mark -


@end
