//
//  JMRConstantMappingType.m
//  Excelsior
//

/*
 
 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
 
 */

#import "JMRConstantMappingType.h"

@implementation JMRConstantMappingType

-(BOOL)isConstant {
    return YES;
}

-(id)initWithDefaultString:(NSString *)value {
    if (self = [super init]) {
        [self setDefaultString:value];
        return self;
    }
    return nil;
}

+(JMRConstantMappingType *)constantMappingWithDefaultString:(NSString *)value {
    return [[[JMRConstantMappingType alloc] initWithDefaultString:value] autorelease];
}

@end
