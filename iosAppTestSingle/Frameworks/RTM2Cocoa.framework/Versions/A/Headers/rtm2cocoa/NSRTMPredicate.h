/*
*  NSRTMPredicate.h
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
#import "NSRTMCriteria.h"

typedef enum _NSRTMPredicateAggregator {
    NSRTMPredicateAND = 0,
    NSRTMPredicateOR = 1
} NSRTMPredicateAggregator;

@interface NSRTMPredicate : NSObject {
	NSString *predicate;
}

-(id)initWithCriteria:(NSRTMCriteria *)criteria;
-(id)initWithCriterias:(NSMutableArray *)array;
-(id)initWithCriterias:(NSMutableArray *)array with:(NSRTMPredicateAggregator)option;

-(id)initWithQuery:(NSString *)query;

-(void)addCriteria:(NSRTMCriteria *)criteria;
-(void)addCriteria:(NSRTMCriteria *)criteria options:(NSRTMPredicateAggregator)option;
-(void)addCriterias:(NSMutableArray *)array grouppedWith:(NSRTMPredicateAggregator)option;

-(NSString *)formattedPredicate;

@end
