//
//  JMRDateMapping.h

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import <Foundation/Foundation.h>
#import "JMRMapping.h"
#import "JMRDateMappingType.h"

@interface JMRDateMapping : JMRMapping {

}

+(NSDateFormatter *)formatterWithFormat:(NSString *)format;
+(void)setDefaultFormat:(NSString *)format;
+(id)mappingWithXmlPath:(NSString *)xmlPath objectPath:(NSString *)objectPath format:(NSString *)format;
@end
