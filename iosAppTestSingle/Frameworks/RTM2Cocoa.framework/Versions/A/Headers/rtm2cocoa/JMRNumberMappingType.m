//
//  JMRNumberMappingType.m
//  Excelsior

/*
 
 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
 
 */

#import "JMRNumberMappingType.h"

static NSNumberFormatter *_defaultFormatter;

@implementation JMRNumberMappingType

+(void)setDefaultFormat:(NSString *)format {
    if (!_defaultFormatter)
        _defaultFormatter = [[NSNumberFormatter alloc] init];
    [_defaultFormatter setFormat:format];
}

-(void)setFormat:(NSString *)value {
    if (![self formatter])
        [self setFormatter:[[[NSNumberFormatter alloc] init] autorelease]];
    [(NSNumberFormatter *)[self formatter] setFormat:value];
}

@end
