//
//  ApiTestAppDelegate.m
//  ApiTest
//
//  Created by kkillian on 08/11/2009.
//  Copyright 2009 shufflecodebox. All rights reserved.
//

#import "ApiTestAppDelegate.h"
#import "DebugLog.h"

@implementation ApiTestAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
		// You have to insert your ApiKay and Secret
	NSString *apikay = @"";
	NSString *secret = @"";
		// Inizialize the RTMController with the api_key and the sicret code
	rtmController = [[NSRTM alloc] initWithApikey:apikay andSicret:secret];
	
	if([rtmController isRegistrated]) {
		NSLog(@"RTM Registred");
		[isAuthField setStringValue:@"YES"];
		[self getLists:nil];
	} else {
		NSLog(@"RTM NOT Registred");
		[isAuthField setStringValue:@"NO"];
		[rtmController authenticate:RTMAuthDelete];
	}
	
}

-(IBAction)getLists:(id)sender {
	NSMutableArray *lists = [rtmController getFullTaskLists];		
	[listArrayController addObjects:lists];
}

-(IBAction)getTasks:(id)sender {	
	NSMutableArray *lists = [rtmController getTaskList];
	NSLog(@"Tasks Lists : %@",[lists description]);
	NSEnumerator * enumerator = [lists objectEnumerator];
	NSRTMList *element;	
	while(element = [enumerator nextObject])
	{
			// Do your thing with the object.
		NSMutableArray *taskSeries = [element getTaskseries];
		NSLog(@"Tasks Info = %@",[taskSeries description]); 
	}
}

-(IBAction)addNewTask:(id)sender {	
	if([[listArrayController selectedObjects] count] > 0) {
		NSRTMList *currentList = [[listArrayController selectedObjects] objectAtIndex:0];
		NSInteger listid = [[currentList getListId] integerValue];
		NSLog(@"Current list id = %d",listid);
		NSRTMList *resultList = [rtmController addNewTask:[newtaskField stringValue] atList:listid parse:NO];
		NSLog(@"Result List %@",resultList);
	} else {
		NSLog(@"NOT LIST SELECTED");
		[NSApp presentError:[[NSError alloc] initWithDomain:@"NO LIST SELECTE" code:999 userInfo:nil]];
	}
}

-(IBAction)getTaskInfo:(id)sender {
	if([[listArrayController selectedObjects] count] > 0) {
		NSRTMList *currentList = [[listArrayController selectedObjects] objectAtIndex:0];
		NSLog(@"LIST DESK TASKSERIES %@",[[currentList getTaskseries] description]);
	}
	NSLog(@"TASKARRAY %@",[taskseriesArrayController description]);
	if([[taskseriesArrayController arrangedObjects] count] > 0) {
		NSRTMTaskseries *taskseries = [[taskseriesArrayController arrangedObjects] objectAtIndex:0];

		NSLog(@"TEST: %@",[taskseries getCreated]);
		[dateExampleField setStringValue:[[taskseries getCreated] description]];
	}
	
}
@end
