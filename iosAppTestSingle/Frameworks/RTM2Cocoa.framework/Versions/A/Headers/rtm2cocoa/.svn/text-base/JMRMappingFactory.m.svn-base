//
//  JMRMappingFactory.m

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import "JMRMappingFactory.h"

#define NO_MAPPING -1
#define STRING_MAPPING 0
#define NUMBER_MAPPING 1
#define DATE_MAPPING 2
#define CONSTANT_MAPPING 3
#define OBJECT_MAPPING 4
#define SWITCH_MAPPING 5

static JMRObjectMapping *_mappingFactoryObjectMapping;
static NSMutableArray *_types;

@implementation JMRMappingFactory

+(void)initialize {
    _types = [[NSMutableArray arrayWithObjects:@"string", @"number", @"date", @"constant", @"object", @"switch", nil] retain];
}

-(int)typeIndex {
    int index = 0;
    NSString *typeString;
    NSEnumerator *typesEnumerator = [_types objectEnumerator];

    while (typeString=[typesEnumerator nextObject]) {
        if ([typeString isEqualToString:[self type]])
            return index;
        else
            index++;
    }
    
    return -1;
}

-(JMRMapping *)makeMappingWithMappingList:(JMRMappingList *)mappingList {
    JMRMapping *mapping;
    JMRObjectMapping *objectMapping;
    NSEnumerator *childEnumerator;
    JMRMappingFactory *child;
    NSMutableArray *children;
    // JMRMappingType *mappingType;
    
    if ([self ref] && mappingList) {
        /* mappingType = [mappingList mappingTypeWithName:[self ref]];
        mapping = [JMRMapping mappingWithXmlPath:[self xmlPath]
                                      objectPath:[self objectPath]
                                     mappingType:mappingType]; */
        mapping = [mappingList mappingWithMappingFactory:self];
    } else switch ([self typeIndex]) {
        case STRING_MAPPING:
            mapping = [JMRStringMapping mappingWithXmlPath:[self xmlPath]
                                                objectPath:[self objectPath]];
            break;
        case NUMBER_MAPPING:
            mapping = [JMRNumberMapping mappingWithXmlPath:[self xmlPath]
                                                objectPath:[self objectPath]
                                                    format:[self format]];
            break;
        case DATE_MAPPING:
            mapping = [JMRDateMapping mappingWithXmlPath:[self xmlPath]
                                              objectPath:[self objectPath]
                                                  format:[self format]];
            break;
        case CONSTANT_MAPPING:
            mapping = [JMRMapping constantMappingWithXmlPath:[self xmlPath] value:[self defaultString]];
            break;
        case OBJECT_MAPPING:
        case SWITCH_MAPPING:
            children = [NSMutableArray array];
            childEnumerator = [[self childMappings] objectEnumerator];
            while (child = [childEnumerator nextObject])
                [children addObject:[child makeMappingWithMappingList:mappingList]];

            if ([self typeIndex]==OBJECT_MAPPING)
                objectMapping = [JMRObjectMapping mappingWithClass:NSClassFromString([self className])
                                                          mappings:children
                                                          rootName:[self rootName]];
            else
                objectMapping = [JMRSwitchMappingType mappingWithMappings:children];
            
            mapping = [JMRMapping mappingWithXmlPath:[self xmlPath]
                                          objectPath:[self objectPath]
                                       objectMapping:objectMapping];
            break;
        default:
            NSLog(@"Invalid type: %d", [self type]);
            return nil;
    }
    if ([mapping isScalar] && ![mapping isConstant])
        [mapping setDefaultString:[self defaultString]];
    [mapping setIsList:[self isList]];

    // register this by name if necessary
    if (mappingList) {
        if ([self name])
            // [mappingList addMapping:objectMapping forName:[self name]];
            [mappingList addMappingType:[mapping mappingType] forName:[self name]];
        if ([self rootName])
            [mappingList addMapping:objectMapping forRootName:[self rootName]];
    }
    
    return mapping;
}

-(JMRMapping *)makeMapping {
    return [self makeMappingWithMappingList:nil];
}

+(JMRObjectMapping *)mappingFactoryObjectMapping {
    JMRMapping *selfMapping;
    NSMutableArray *mappingsList;
    
    if (!_mappingFactoryObjectMapping) {
        selfMapping = [JMRMapping mappingWithXmlPath:@"Mapping" objectPath:@"childMappings"];
        mappingsList = [NSMutableArray arrayWithObjects:
            [JMRStringMapping mappingWithXmlPath:@"@rootName" objectPath:@"rootName"],
            [JMRStringMapping mappingWithXmlPath:@"@ref" objectPath:@"ref"],
            [JMRStringMapping mappingWithXmlPath:@"@type" objectPath:@"type"],
            [JMRStringMapping mappingWithXmlPath:@"@class" objectPath:@"className"],
            [JMRStringMapping mappingWithXmlPath:@"@format" objectPath:@"format"],
            [JMRStringMapping mappingWithXmlPath:@"@default" objectPath:@"defaultValue"],
            [JMRBooleanMapping mappingWithXmlPath:@"@isList" objectPath:@"isList"],
            [JMRStringMapping mappingWithXmlPath:@"@xmlPath" objectPath:@"xmlPath"],
            [JMRStringMapping mappingWithXmlPath:@"@objectPath" objectPath:@"objectPath"],
            // added 2003-11-06
            [JMRStringMapping mappingWithXmlPath:@"@name" objectPath:@"name"],
            [JMRStringMapping mappingWithXmlPath:@"@ref" objectPath:@"ref"],
            selfMapping, nil];
        
        _mappingFactoryObjectMapping = [JMRObjectMapping mappingWithClass:[JMRMappingFactory class]
                                                                 mappings:mappingsList];
        
        [selfMapping setObjectMapping:_mappingFactoryObjectMapping];
        [selfMapping setIsList:YES];
    }

    return _mappingFactoryObjectMapping;
}

+(JMRMapping *)mappingWithElement:(XMLKeyValueElement *)elt mappingList:(JMRMappingList *)list {
    JMRMarshaller *marshaller = [JMRMarshaller marshallerWithObjectMapping:[JMRMappingFactory mappingFactoryObjectMapping]];
    JMRMappingFactory *factory = (JMRMappingFactory *)[marshaller unmarshal:elt];
    
    return [factory makeMappingWithMappingList:list];
}

+(JMRMapping *)mappingWithDataFromUrl:(NSURL *)url {
    return [JMRMappingFactory mappingWithElement:[XMLKeyValueElement elementWithDataFromURL:url] mappingList:nil];
}

// accessors

-(NSString *)type {
    return _type;
}
-(void)setType:(NSString *)value {
    [value retain];
    [_type release];
    _type = value;
}

-(NSString *)rootName {
    return _rootName;
}
-(void)setRootName:(NSString *)value {
    [value retain];
    [_rootName release];
    _rootName = value;
}

-(NSString *)ref {
    return _ref;
}
-(void)setRef:(NSString *)value {
    [value retain];
    [_ref release];
    _ref = value;
}

-(NSString *)name {
    return _name;
}
-(void)setName:(NSString *)value {
    [value retain];
    [_name release];
    _name = value;
}

-(NSString *)format {
    return _format;
}
-(void)setFormat:(NSString *)value {
    [value retain];
    [_format release];
    _format = value;
}

-(NSString *)className {
    return _className;
}
-(void)setClassName:(NSString *)value {
    [value retain];
    [_className release];
    _className = value;
}

-(NSMutableArray *)childMappings {
    if (!_childMappings)
        _childMappings = [[NSMutableArray alloc] init];
    return _childMappings;
}
-(void)setChildMappings:(NSMutableArray *)value {
    [value retain];
    [_childMappings release];
    _childMappings = value;
}

-(void)setIsListNumber:(NSNumber *)value {
    [self setIsList:[value boolValue]];
}

@end
