//
//  JMRSwitchMappingType.m
//  Excelsior
//
//  Created by Jim Rankin on Fri Apr 09 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import "JMRSwitchMappingType.h"

@implementation JMRSwitchMappingType

+(JMRSwitchMappingType *)mappingWithMappings:(NSMutableArray *)mappings {
    return [[[self alloc] initWithMappings:mappings] autorelease];
}

-(id)initWithMappings:(NSMutableArray *)mappings {
    if (self = [super init])
        [self setMappings:mappings];
    
    return self;
}

-(void)_initializeDictionaries {
    JMRMapping *mapping;
    NSEnumerator *enumerator;
    
    [self setXmlMappingsDict:[NSMutableDictionary dictionary]];
    [self setClassMappingsDict:[NSMutableDictionary dictionary]];

    enumerator = [[self mappings] objectEnumerator];
    
    while (mapping = [enumerator nextObject]) {
        [_xmlMappingsDict setObject:mapping forKey:[mapping xmlPath]];
        [_classMappingsDict setObject:mapping forKey:[[mapping objectMapping] getClass]];
    }
}

-(NSMutableDictionary *)xmlMappingsDict {
    if (!_xmlMappingsDict && [self mappings])
        [self _initializeDictionaries];
    
    return _xmlMappingsDict;
}

-(void)setXmlMappingsDict:(NSMutableDictionary *)value {
    [value retain];
    [_xmlMappingsDict release];
    _xmlMappingsDict = value;
}

-(NSMutableDictionary *)classMappingsDict {
    if (!_classMappingsDict && [self mappings])
        [self _initializeDictionaries];
    
    return _classMappingsDict;
}

-(void)setClassMappingsDict:(NSMutableDictionary *)value {
    [value retain];
    [_classMappingsDict release];
    _classMappingsDict = value;
}

-(JMRMapping *)mappingForXmlTag:(NSString *)tag {
    NSLog(@"Found mapping %@ for tag %@", [[self xmlMappingsDict] objectForKey:tag], tag);
    return [[self xmlMappingsDict] objectForKey:tag];
}

-(JMRMapping *)mappingForClass:(Class *)c {
    return [[self classMappingsDict] objectForKey:c];
}

-(NSString *)xmlPathForObject:(id)o {
    return [[self mappingForClass:[o class]] xmlPath];
}

-(JMRObjectMapping *)objectMappingForObject:(id)o {
    return [[self mappingForClass:[o class]] objectMapping];
}

-(JMRObjectMapping *)objectMappingForElement:(XMLKeyValueElement *)elt {
    return [[self mappingForXmlTag:[elt getUnqualifiedTag]] objectMapping];
}

@end
