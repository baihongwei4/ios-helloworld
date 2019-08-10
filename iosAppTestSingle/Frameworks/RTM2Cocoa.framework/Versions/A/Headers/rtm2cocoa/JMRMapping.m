//
//  JMRMapping.m

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import "JMRMapping.h"
#import "JMRObjectMapping.h"
#import "JMRSwitchMappingType.h"

@implementation JMRMapping

+(void)setDefaultFormatter:(NSFormatter *)formatter {
    // define in subclass
}

+(JMRMapping *)mappingWithXmlPath:(NSString *)xmlPath
                       objectPath:(NSString *)objectPath {
    return [[[JMRMapping alloc] initWithXmlPath:xmlPath
                                     objectPath:objectPath] autorelease];
}

+(JMRMapping *)mappingWithXmlPath:(NSString *)xmlPath
                       objectPath:(NSString *)objectPath
                        formatter:(NSFormatter *)formatter {
    return [[[JMRMapping alloc] initWithXmlPath:xmlPath
                                     objectPath:objectPath
                                      formatter:formatter] autorelease];
}

+(JMRMapping *)listMappingWithXmlPath:(NSString *)xmlPath
                           objectPath:(NSString *)objectPath
                            formatter:(NSFormatter *)formatter {
    JMRMapping *mapping = [[JMRMapping alloc] initWithXmlPath:xmlPath
                                                   objectPath:objectPath
                                                    formatter:formatter];

    [mapping setIsList:YES];
    return [mapping autorelease];
}

+(JMRMapping *)mappingWithXmlPath:(NSString *)xmlPath
                       objectPath:(NSString *)objectPath
                        formatter:(NSFormatter *)formatter
                    defaultString:(NSString *)defaultString {
    return [[[JMRMapping alloc] initWithXmlPath:xmlPath
                                     objectPath:objectPath
                                      formatter:formatter
                                  defaultString:defaultString] autorelease];
}

+(JMRMapping *)listMappingWithXmlPath:(NSString *)xmlPath
                           objectPath:(NSString *)objectPath
                            formatter:(NSFormatter *)formatter
                        defaultString:(NSString *)defaultString {
    JMRMapping *mapping = [[JMRMapping alloc] initWithXmlPath:xmlPath
                                                   objectPath:objectPath
                                                    formatter:formatter
                                                defaultString:defaultString];

    [mapping setIsList:YES];
    return [mapping autorelease];
}

+(JMRMapping *)constantMappingWithXmlPath:(NSString *)xmlPath
                                    value:(NSString *)value {
    return [[[JMRMapping alloc] initWithXmlPath:xmlPath
                                  constantValue:value] autorelease];
}

+(JMRMapping *)mappingWithXmlPath:(NSString *)xmlPath
                       objectPath:(NSString *)objectPath
                    objectMapping:(JMRObjectMapping *)objectMapping {
    return [[[JMRMapping alloc] initWithXmlPath:xmlPath
                                     objectPath:objectPath
                                  objectMapping:objectMapping] autorelease];
}

+(JMRMapping *)mappingWithXmlPath:(NSString *)xmlPath
                       objectPath:(NSString *)objectPath
                      mappingType:(JMRMappingType *)mappingType {
    
    return [[[JMRMapping alloc] initWithXmlPath:xmlPath
                                     objectPath:objectPath
                                    mappingType:mappingType] autorelease];
}


+(JMRMapping *)listMappingWithXmlPath:(NSString *)xmlPath
                           objectPath:(NSString *)objectPath
                        objectMapping:(JMRObjectMapping *)objectMapping {
    JMRMapping *mapping = [[JMRMapping alloc] initWithXmlPath:xmlPath
                                                   objectPath:objectPath
                                                objectMapping:objectMapping];
    [mapping setIsList:YES];
    return [mapping autorelease];
    
}

-(id)initWithXmlPath:(NSString *)xmlPath objectPath:(NSString *)objectPath {
    [self setXmlPath:xmlPath];
    [self setObjectPath:objectPath];

    return self;
}

-(id)initWithXmlPath:(NSString *)xmlPath
          objectPath:(NSString *)objectPath
           formatter:(NSFormatter *)formatter {
    [self initWithXmlPath:xmlPath objectPath:objectPath];
    // scalar fields
    [self setFormatter:formatter];
    // object fields
    [self setObjectMapping:nil];

    return self;
}

-(id)initWithXmlPath:(NSString *)xmlPath objectPath:(NSString *)objectPath format:(NSString *)format {
    [self initWithXmlPath:xmlPath objectPath:objectPath];
    [self setFormat:format];

    return self;
}

-(id)initWithXmlPath:(NSString *)xmlPath
          objectPath:(NSString *)objectPath
           formatter:(NSFormatter *)formatter
       defaultString:(NSString *)defaultString {
    [self initWithXmlPath:xmlPath objectPath:objectPath formatter:formatter];
    [self setDefaultString:defaultString];

    return self;
}

-(id)initWithXmlPath:(NSString *)xmlPath
       constantValue:(NSString *)constantValue {
    [self setXmlPath:xmlPath];
    [self setScalarType:[JMRConstantMappingType constantMappingWithDefaultString:constantValue]];

    return self;
}

-(id)initWithXmlPath:(NSString *)xmlPath
          objectPath:(NSString *)objectPath
       objectMapping:(JMRObjectMapping *)objectMapping {
    [self initWithXmlPath:xmlPath objectPath:objectPath];
    // object fields
    [self setObjectMapping:objectMapping];

    return self;
}

-(id)initWithXmlPath:(NSString *)xmlPath
          objectPath:(NSString *)objectPath
         mappingType:(JMRMappingType *)mappingType {
    [self initWithXmlPath:xmlPath objectPath:objectPath];
    // object fields
    [self setMappingType:mappingType];
    
    return self;
}

-(BOOL)isConstant {
    return [[self scalarType] isConstant];
}

-(BOOL)isScalar {
    return ([self scalarType]!=nil);
}

/* -(BOOL)isObject {
    return ![self isScalar];
} */

-(BOOL)isSwitch {
    return [[self mappingType] isKindOfClass:[JMRSwitchMappingType class]];
}

-(BOOL)isObject {
    return ![self isScalar] && ![self isSwitch];
}

-(BOOL)isList {
    return _isList;
}
-(void)setIsList:(BOOL)value {
    _isList = value;
}

-(id)scalarValue:(NSString *)value {
    return [[self scalarType] scalarValue:value];
}

-(NSString *)stringForValue:(id)object {
    return [[self scalarType] stringForValue:object];
}

-(void)assignValue:(id)value toObject:(id)object {
    [object setValue:value forKeyPath:[self objectPath]];
}

// accessors

-(JMRScalarMappingType *)defaultScalarType {
    return nil;
}

-(JMRScalarMappingType *)scalarType {
    JMRScalarMappingType *defaultValue;
    
    if (!_scalarType) {
        defaultValue = [self defaultScalarType];
        if (defaultValue)
            [self setScalarType:[[defaultValue init] autorelease]];
    }
    return _scalarType;
}
-(void)setScalarType:(JMRScalarMappingType *)value {
    [_scalarType release];
    [value retain];
    _scalarType = value;
    
    // can't have scalarType, objectMapping set at same time
    if (_scalarType)
        [self setObjectMapping:nil];
}

-(JMRMappingType *)mappingType {
    return [self isScalar] ? (JMRMappingType *)[self scalarType] : (JMRMappingType *)[self objectMapping];
}
-(void)setMappingType:(JMRMappingType *)value {
    if ([value isKindOfClass:[JMRScalarMappingType class]])
        [self setScalarType:(JMRScalarMappingType *)value];
    else if ([value isKindOfClass:[JMRObjectMapping class]])
        [self setObjectMapping:(JMRObjectMapping *)value];
}

-(NSString *)xmlPath {
    return _xmlPath;
}
-(void)setXmlPath:(NSString *)value {
    [value retain];
    [_xmlPath release];
    _xmlPath = value;
}

-(NSString *)objectPath {
    return _objectPath;
}
-(void)setObjectPath:(NSString *)value {
    [value retain];
    [_objectPath release];
    _objectPath = value;
}

-(NSString *)defaultString {
    return [[self scalarType] defaultString];
}
-(void)setDefaultString:(NSString *)value {
    [[self scalarType] setDefaultString:value];
}

-(JMRObjectMapping *)objectMapping {
    return _objectMapping;
}
-(void)setObjectMapping:(JMRObjectMapping *)value {
    [value retain];
    [_objectMapping release];
    _objectMapping = value;

    // can't have scalarType, objectMapping set at same time
    if (_objectMapping)
        [self setScalarType:nil];
}

-(NSFormatter *)formatter {
    return [[self scalarType] formatter];
}
-(void)setFormatter:(NSFormatter *)value {
    [[self scalarType] setFormatter:value];
}
-(void)setFormat:(NSString *)value {
    [[self scalarType] setFormat:value];
}

-(void)dealloc {
    [_objectPath release];
    [_xmlPath release];
    [_scalarType release];
    [_objectMapping release];
    [super dealloc];
}

@end
