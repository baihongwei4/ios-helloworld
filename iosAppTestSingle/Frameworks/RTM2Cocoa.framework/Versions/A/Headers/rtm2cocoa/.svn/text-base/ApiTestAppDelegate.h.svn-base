//
//  ApiTestAppDelegate.h
//  ApiTest
//
//  Created by kkillian on 08/11/2009.
//  Copyright 2009 shufflecodebox. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <RTM2Cocoa/NSRTM2Cocoa.h>
#import <BWToolkitFramework/BWToolkitFramework.h>

@interface ApiTestAppDelegate : NSObject {
    NSWindow *window;
	NSRTM *rtmController;
	IBOutlet BWStyledTextField *isAuthField;
	IBOutlet NSButton *authButton;
	IBOutlet NSTableView *listTableView;
	IBOutlet NSArrayController *listArrayController;
	IBOutlet NSArrayController *taskseriesArrayController;
	IBOutlet NSTextField *newtaskField;
	IBOutlet NSTextField *dateExampleField;
}

@property (assign) IBOutlet NSWindow *window;

-(IBAction)getLists:(id)sender;
-(IBAction)getTasks:(id)sender;
-(IBAction)addNewTask:(id)sender;
-(IBAction)getTaskInfo:(id)sender;
@end
