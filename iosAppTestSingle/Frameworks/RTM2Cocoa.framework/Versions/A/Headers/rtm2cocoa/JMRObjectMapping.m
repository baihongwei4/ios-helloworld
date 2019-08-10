//
//  JMRObjectMapping.m
//  Mapper

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import "JMRObjectMapping.h"


@implementation JMRObjectMapping

-(id)initWithClass:(Class)c mappings:(NSMutableArray *)mappings {
    [super init];

    [self setClass:c];
    [self setMappings:mappings];

    return self;
}

-(id)initWithClass:(Class)c mappings:(NSMutableArray *)mappings rootName:(NSString *)rootName {
    [super init];

    [self initWithClass:c mappings:mappings];
    [self setRootName:rootName];

    return self;
}

+(JMRObjectMapping *)mappingWithClass:(Class)c mappings:(NSMutableArray *)mappings {
    return [[[JMRObjectMapping alloc] initWithClass:c mappings:mappings] autorelease];
}

+(JMRObjectMapping *)mappingWithClass:(Class)c mappings:(NSMutableArray *)mappings rootName:(NSString *)rootName {
    return [[[JMRObjectMapping alloc] initWithClass:c mappings:mappings rootName:rootName] autorelease];
}

-(Class)getClass {
    return _class;
}

-(void)setClass:(Class)value {
    _class = value;
}

-(NSMutableArray *)mappings {
    return _mappings;
}

-(void)setMappings:(NSMutableArray *)value {
    [value retain];
    [_mappings release];
    _mappings = value;
}

-(NSMutableDictionary *)mappingsDict {
    NSEnumerator *enumerator;
    JMRMapping *mapping;

    if (!_mappingsDict && [self mappings]) {
        [self setMappingsDict:[NSMutableDictionary dictionary]];
        enumerator = [[self mappings] objectEnumerator];

        while (mapping = [enumerator nextObject])
            [_mappingsDict setObject:mapping forKey:[mapping xmlPath]];
    }

    return _mappingsDict;
}

-(void)setMappingsDict:(NSMutableDictionary *)value {
    [value retain];
    [_mappingsDict release];
    _mappingsDict = value;
}

-(NSString *)rootName {
    return _rootName;
}
-(void)setRootName:(NSString *)value {
    [value retain];
    [_rootName release];
    _rootName = value;
}

-(void)dealloc {
    [self setClass:nil];
    [self setMappings:nil];
    [self setMappingsDict:nil];
    [self setRootName:nil];
    [super dealloc];
}

-(id)objectValue {
    return [[[_class alloc] init] autorelease];
}

@end
