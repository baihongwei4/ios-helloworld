//
//  JMRDateMappingType.m
//  Excelsior
//

/*
 
 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
 
 */

#import "JMRDateMappingType.h"

static NSFormatter *_defaultFormatter;

@implementation JMRDateMappingType

+(NSDateFormatter *)formatterWithFormat:(NSString *)format {
    return [[NSDateFormatter alloc] initWithDateFormat:format allowNaturalLanguage:NO];
}

+(void)setDefaultFormat:(NSString *)format {
    [_defaultFormatter release];
    _defaultFormatter = [JMRDateMappingType formatterWithFormat:format];
}

-(void)setFormat:(NSString *)value {
    [self setFormatter:[JMRDateMappingType formatterWithFormat:value]];
}

@end
