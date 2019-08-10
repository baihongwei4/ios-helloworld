//
//  JMRStringMappingType.m
//  Excelsior

/*
 
 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
 
 */

#import "JMRStringMappingType.h"


@implementation JMRStringMappingType

-(id)scalarValue:(NSString *)value {
    return value;
}

-(NSString *)stringForValue:(id)object {
    if (!object)
        return _defaultString;
    return [object description];
}

@end
