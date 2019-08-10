//
//  JMRDateMapping.m

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import "JMRDateMapping.h"

@implementation JMRDateMapping

+(NSDateFormatter *)formatterWithFormat:(NSString *)format {
    return [JMRDateMappingType formatterWithFormat:format]; 
}

+(void)setDefaultFormat:(NSString *)format {
    [JMRDateMappingType setDefaultFormat:format]; 
}

-(JMRScalarMappingType *)defaultScalarType {
    return [JMRDateMappingType alloc];
}

+(id)mappingWithXmlPath:(NSString *)xmlPath objectPath:(NSString *)objectPath {
    return [[[JMRDateMapping alloc] initWithXmlPath:xmlPath
                                         objectPath:objectPath
                                          formatter:[JMRDateMappingType defaultFormatter]] autorelease];
}

+(id)mappingWithXmlPath:(NSString *)xmlPath objectPath:(NSString *)objectPath format:(NSString *)format {
    return [[[JMRDateMapping alloc] initWithXmlPath:xmlPath
                                         objectPath:objectPath
                                             format:format] autorelease];
}

@end
