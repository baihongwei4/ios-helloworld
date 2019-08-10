//
//  JMRBooleanMappingType.m
//  Excelsior
//

/*
 
 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
 
 */

#import "JMRBooleanMappingType.h"


@implementation JMRBooleanMappingType

-(id)scalarValue:(NSString *)value {
    if ([@"YES" isEqualToString:value] || [@"true" isEqualToString:value])
        return [NSNumber numberWithBool:YES];
    return [NSNumber numberWithBool:NO];
}

-(NSString *)stringForValue:(id)object {
    return [object boolValue] ? @"YES" : @"NO";
}

@end
