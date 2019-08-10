//
//  JMRScalarMappingType.h
//  Excelsior

/*
 
 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
 
 */

#import <Foundation/Foundation.h>
#import "JMRMappingType.h"

@interface JMRScalarMappingType : JMRMappingType {
    NSFormatter *_formatter;
    BOOL _isConstant;
    // use if _isConstant or value is null
    NSString *_defaultString; // nil or constant value
}

-(id)scalarValue:(NSString *)value;
-(NSString *)stringForValue:(id)object;
-(NSString *)defaultString;
-(void)setDefaultString:(NSString *)value;
-(NSFormatter *)formatter;
-(void)setFormatter:(NSFormatter *)value;
-(void)setFormat:(NSString *)value;
-(BOOL)isConstant;
+(void)setDefaultFormatter:(NSFormatter *)formatter;
+(NSFormatter *)defaultFormatter;
@end
