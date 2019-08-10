//
//  JMRScalarMappingType.m
//  Excelsior

/*
 
 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
 
 */

#import "JMRScalarMappingType.h"

static NSFormatter *_defaultFormatter;

@implementation JMRScalarMappingType

+(void)setDefaultFormatter:(NSFormatter *)formatter {
    _defaultFormatter = formatter;
}
+(NSFormatter *)defaultFormatter {
    return _defaultFormatter;
}

-(id)scalarValue:(NSString *)value {
    id obj;
    NSString *err;
    
    if (![self formatter])
        return value;
    if ([[self formatter] getObjectValue:&obj
                               forString:value
                        errorDescription:&err])
    return obj;
    
    NSLog(@"scalarValue err = %@", err);
    return nil;
}

-(NSString *)stringForValue:(id)object {
    if ([self isConstant] || !object)
        return _defaultString;
    if (![self formatter])
        return [object description];
    return [[self formatter] stringForObjectValue:object];
}

-(NSString *)defaultString {
    return _defaultString;
}
-(void)setDefaultString:(NSString *)value {
    [value retain];
    [_defaultString release];
    _defaultString = value;
}

-(NSFormatter *)formatter {
    return _formatter;
}
-(void)setFormatter:(NSFormatter *)value {
    [value retain];
    [_formatter release];
    _formatter = value;
}
-(void)setFormat:(NSString *)value {
    /* override in subclass */
}

-(BOOL)isConstant {
    // default
    return NO;
}

-(void)dealloc {
    [self setFormatter:nil];
    [self setDefaultString:nil];
    
    [super dealloc];
}
@end
