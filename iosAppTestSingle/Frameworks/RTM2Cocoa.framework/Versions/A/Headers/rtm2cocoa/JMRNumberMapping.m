//
//  JMRNumberMapping.m

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import "JMRNumberMapping.h"

@implementation JMRNumberMapping

-(JMRScalarMappingType *)defaultScalarType {
    return [JMRNumberMappingType alloc];
}

+(id)mappingWithXmlPath:(NSString *)xmlPath objectPath:(NSString *)objectPath format:(NSString *)format {
    return [[[JMRNumberMapping alloc] initWithXmlPath:xmlPath
                                           objectPath:objectPath
                                               format:format] autorelease];
}

@end
