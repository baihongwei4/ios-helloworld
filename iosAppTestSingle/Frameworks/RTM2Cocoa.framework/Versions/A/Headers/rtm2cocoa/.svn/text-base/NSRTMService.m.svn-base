/*
 *  NSRTMService.m
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

#import "NSRTMService.h"
#import "DebugLog.h"
#import "JMRMarshaller.h"
#import "JMRObjectMapping.h"
#import "XMLKeyValueElement.h"
#import "JMRMappingFactory.h"
#import "JMRMappingList.h"
#import "JMRMarshaller.h"
#import "NSRTMInvoker.h"

@implementation NSRTMService

-(id)initWithInvoker:(NSRTMInvoker *)inv {
	self = [super init];
	if (self != nil) {
		invoker = inv;
	}
	return self;
	
}

-(void)dealloc {
	[invoker release];
	[mainresponse release];
	[marshaller release];
    [personMapping release];
    [url release];
    [elt release];
	[super dealloc];
}

-(NSRTMResponse *)execute:(NSMutableArray *)params error:(NSError**)error {
	
	// In according with the RTM api documentation the sleep comand with 2 second will prevent to fast reqeusts
	sleep(1);
	NSURL *theURL = [invoker generateURL:params];
	NSBundle *bundle = [NSBundle bundleForClass:[self class]];
	url = [NSURL fileURLWithPath:[bundle pathForResource:@"RTMMapping" ofType:@"xml"]];
	DLog([url path]);
	
	JMRMappingList *mappingList = [JMRMappingList mappingListWithDataFromURL:url];
    JMRObjectMapping *poMapping = [mappingList mappingWithRootName:@"rsp"];
    marshaller = [JMRMarshaller marshallerWithObjectMapping:poMapping];
	
	elt = [XMLKeyValueElement elementWithDataFromURL:theURL];
    DLog(@"before: %@", [elt formattedString]);
    mainresponse = [marshaller unmarshal:elt];
	NSString *stat = [mainresponse getStat];
	if(stat != NULL && [stat caseInsensitiveCompare:@"fail"] == NSOrderedSame) {
		NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
		[errorDetail setValue:[[mainresponse getError] getMessage] forKey:NSLocalizedDescriptionKey];
		[errorDetail setValue:mainresponse forKey:@"kReceivedData"];
        
		*error = [NSRTMError initWithError:[mainresponse getError]];
		return nil;
	}
	
	return mainresponse;
}

-(BOOL)auth:(NSMutableArray *)params {
	
	NSURL *urlAuth = [invoker generateAuthURL:params];
	DLog(@"Ricevuta: %@",urlAuth);
	[[NSWorkspace alloc] openURL:urlAuth];
	return true;
}

-(NSRTMResponse *)getResponse {
	return mainresponse;
}

@end
