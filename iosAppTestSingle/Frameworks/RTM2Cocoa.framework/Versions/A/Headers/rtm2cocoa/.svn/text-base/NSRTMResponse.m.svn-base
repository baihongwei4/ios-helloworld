/*
 *  NSRTMResponse.m
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

#import "NSRTMResponse.h"


@implementation NSRTMResponse

-(NSString *)getApi_key {
	return api_key;
}
-(NSString *)getStat{
	return stat;
}
-(NSString *)getFrob{
	return frob;
}
-(void)setStat:(NSString *)statv {
	stat = statv;
}
-(void)setApi_key:(NSString *)apikey {
	api_key = apikey;
}
-(NSMutableArray *)getLists {
	return lists;
}

-(NSMutableArray *)getListsTasks {
	return listsTasks;
}

-(NSMutableArray *)getContacts {
	return contacts;
}

-(NSMutableArray *)getTimezones {
	return timezones;
}
-(NSMutableArray *)getLocations {
	return locations;
}

-(NSMutableArray *)getNotes {
	return notes;
}

-(NSRTMNote *)getNote {
	return note;
}

-(NSRTMSettings *)getSettings {
	return settings;
}

-(NSRTMError *)getError {
	return error;
}

-(NSRTMAuth *)getAuth{
	return auth;
}
-(NSRTMList *)getList {
	return list;
}

-(NSRTMTimeline *)getTimeline {
	return timeline;
}
-(NSRTMTransaction *)getTransaction {
	return transaction;
}

-(NSRTMContact *)getContact {
	return contact;
}

-(void)dealloc {
	[error release];
	[auth release];
	[user release];
	[timeline release];
	[transaction release];
	[contact release];
	[list release];
	[lists release];
	[contacts release];
	[super dealloc];
}

@end
