//
//  JMRBooleanMapping.m

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import "JMRBooleanMapping.h"

@implementation JMRBooleanMapping

-(JMRScalarMappingType *)defaultScalarType {
    return [JMRBooleanMappingType alloc];
}

+(id)mappingWithXmlPath:(NSString *)xmlPath objectPath:(NSString *)objectPath {
    return [[[JMRBooleanMapping alloc] initWithXmlPath:xmlPath objectPath:objectPath] autorelease];
}

@end
