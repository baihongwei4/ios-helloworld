/*
 *  NSRTMInvoker.m
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

#import "NSRTMInvoker.h"
#import "DebugLog.h"
#import "NSRTMParam.h"
#import "NSDataMd5.h"
#import "DigestMd5.h"

#define SERVICE_REST @"http://api.rememberthemilk.com/services/rest/?"
#define SERVICE_AUTH @"http://www.rememberthemilk.com/services/auth/?"
#define API_STRING @"api_key"
#define SIGN_STRING @"api_sig"

@implementation NSRTMInvoker

-(id) init
{
	self = [super init];
	if (self != nil) {
		crypto = [[DigestMd5 alloc] init] ;
	}
	return self;
}

-(id)initWithApiKey:(NSString *)apikey andSicret:(NSString *)sicretvalue {
	self = [super init];
	if (self != nil) {
		crypto = [[DigestMd5 alloc] init] ;
		api_key = apikey;
		sicret = sicretvalue;
	}
	return self;
}

-(NSString *)generateSign:(NSMutableArray *)params {
	if(sicret !=nil) {
		NSString *digest = sicret;
		[params addObject:[[NSRTMParam alloc] initWithKey:API_STRING value:api_key]];
		NSArray *sortedParams = [params sortedArrayUsingSelector:@selector(compare:)];
		int count = [sortedParams count];
		int i = 0;
		for (i = 0; i < count; i++) {
			digest = [digest stringByAppendingString:[[sortedParams objectAtIndex:i] description]];
		}
		
		DLog(@"TEST %@", digest);
		
		[crypto setClearTextWithString:digest];
		
		DLog(@"MD5 %@",[[crypto digest] hexval]);
		return [[crypto digest] hexval];
	} else {
		return nil;
	}
}

-(NSURL *)generateURL:(NSMutableArray *)params {
	NSString * urlString = [NSString stringWithFormat:@"%@%@=%@",SERVICE_REST,API_STRING,api_key]; 
	
	int count = [params count];
	int i = 0;
	for (i = 0; i < count; i++) {
		urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&%@",[[params objectAtIndex:i] keyValueURLformat]]];
	}
	
	NSString *sign = [self generateSign:params];
	urlString = [urlString stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",SIGN_STRING,sign]];
	NSString *stringWithoutSpaces = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"\%20"];
	DLog(@"URL: %@",stringWithoutSpaces);
	return [NSURL URLWithString:stringWithoutSpaces];
}

-(NSURL *)generateAuthURL:(NSMutableArray *)params {
	NSString * urlStringAuth = [NSString stringWithFormat:@"%@%@=%@",SERVICE_AUTH,API_STRING,api_key]; 
	
	int count = [params count];
	int i = 0;
	for (i = 0; i < count; i++) {
		urlStringAuth = [urlStringAuth stringByAppendingString:[NSString stringWithFormat:@"&%@",[[params objectAtIndex:i] keyValueURLformat]]];
	}
	
	NSString *sign = [self generateSign:params];
	urlStringAuth = [urlStringAuth stringByAppendingString:[NSString stringWithFormat:@"&%@=%@",SIGN_STRING,sign]];
	DLog(@"URL: %@",urlStringAuth);
	DLog(@"URL: %@",[NSURL URLWithString:urlStringAuth]);
	return [NSURL URLWithString:urlStringAuth];
}


-(void)setSicret:(NSString *)value {
	sicret = value;
}


@end
