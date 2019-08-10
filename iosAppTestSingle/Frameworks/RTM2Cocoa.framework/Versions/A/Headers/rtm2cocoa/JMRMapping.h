//
//  JMRMapping.h

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import <Foundation/Foundation.h>
#import "JMRScalarMappingType.h"
#import "JMRConstantMappingType.h"

@class JMRObjectMapping;
@class JMRSwitchMappingType;

@interface JMRMapping : NSObject {
    // delimiters: / for path, @ for attribute
    NSString *_xmlPath;
    NSString *_objectPath;

    BOOL _isList;

    JMRScalarMappingType *_scalarType;
    
    // if isObject
    JMRObjectMapping *_objectMapping;
}

-(id)scalarValue:(NSString *)value;
-(NSString *)stringForValue:(id)object;
-(void)assignValue:(id)value toObject:(id)object;
-(BOOL)isConstant;
-(BOOL)isScalar;
-(BOOL)isSwitch;
-(BOOL)isObject;
-(BOOL)isList;

// initializers
-(id)initWithXmlPath:(NSString *)xmlPath objectPath:(NSString *)objectPath;

-(id)initWithXmlPath:(NSString *)xmlPath
          objectPath:(NSString *)objectPath
           formatter:(NSFormatter *)formatter;

-(id)initWithXmlPath:(NSString *)xmlPath
          objectPath:(NSString *)objectPath
              format:(NSString *)format;

-(id)initWithXmlPath:(NSString *)xmlPath
          objectPath:(NSString *)objectPath
           formatter:(NSFormatter *)formatter
        defaultString:(NSString *)defaultString;

-(id)initWithXmlPath:(NSString *)xmlPath
       constantValue:(NSString *)constantValue;

-(id)initWithXmlPath:(NSString *)xmlPath
          objectPath:(NSString *)objectPath
       objectMapping:(JMRObjectMapping *)objectMapping;

-(id)initWithXmlPath:(NSString *)xmlPath
          objectPath:(NSString *)objectPath
         mappingType:(JMRMappingType *)mappingType;
// accessors

-(JMRScalarMappingType *)defaultScalarType;
-(JMRScalarMappingType *)scalarType;
-(void)setScalarType:(JMRScalarMappingType *)value;

-(JMRMappingType *)mappingType;
-(void)setMappingType:(JMRMappingType *)value;

-(NSString *)xmlPath;
-(void)setXmlPath:(NSString *)value;
-(NSString *)objectPath;
-(void)setObjectPath:(NSString *)value;
-(JMRObjectMapping *)objectMapping;
-(void)setObjectMapping:(JMRObjectMapping *)value;
-(NSString *)defaultString;
-(void)setDefaultString:(NSString *)value;
-(NSFormatter *)formatter;
-(void)setFormatter:(NSFormatter *)value;
-(BOOL)isList;
-(void)setIsList:(BOOL)value;
-(JMRObjectMapping *)objectMapping;
-(void)setObjectMapping:(JMRObjectMapping *)value;
-(void)setFormat:(NSString *)value;
-(void)dealloc;

+(void)setDefaultFormatter:(NSFormatter *)formatter;

+(JMRMapping *)mappingWithXmlPath:(NSString *)xmlPath
                       objectPath:(NSString *)objectPath;
    
+(JMRMapping *)mappingWithXmlPath:(NSString *)xmlPath
                       objectPath:(NSString *)objectPath
                        formatter:(NSFormatter *)formatter;

+(JMRMapping *)listMappingWithXmlPath:(NSString *)xmlPath
                           objectPath:(NSString *)objectPath
                            formatter:(NSFormatter *)formatter;

+(JMRMapping *)mappingWithXmlPath:(NSString *)xmlPath
                       objectPath:(NSString *)objectPath
                        formatter:(NSFormatter *)formatter
                    defaultString:(NSString *)defaultString;

+(JMRMapping *)listMappingWithXmlPath:(NSString *)xmlPath
                           objectPath:(NSString *)objectPath
                            formatter:(NSFormatter *)formatter
                        defaultString:(NSString *)defaultString;

+(JMRMapping *)constantMappingWithXmlPath:(NSString *)xmlPath
                                    value:(NSString *)value;

+(JMRMapping *)mappingWithXmlPath:(NSString *)xmlPath
                       objectPath:(NSString *)objectPath
                    objectMapping:(JMRObjectMapping *)objectMapping;

+(JMRMapping *)listMappingWithXmlPath:(NSString *)xmlPath
                           objectPath:(NSString *)objectPath
                        objectMapping:(JMRObjectMapping *)objectMapping;

+(JMRMapping *)mappingWithXmlPath:(NSString *)xmlPath
                       objectPath:(NSString *)objectPath
                      mappingType:(JMRMappingType *)mappingType;
@end
