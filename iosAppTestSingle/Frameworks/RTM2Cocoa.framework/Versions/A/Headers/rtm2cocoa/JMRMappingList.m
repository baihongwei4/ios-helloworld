//
//  JMRMappingList.m
//  Excelsior

/*
 
 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
 
 */

#import "JMRMappingList.h"

@implementation JMRMappingList

+(JMRMappingList *)mappingListWithDataFromURL:(NSURL *)url {
    XMLKeyValueElement *mappingXml = [[XMLKeyValueElement elementWithDataFromURL:url] elementForKeyPath:@"Mapping"];
    JMRMappingList *mappingList = [[JMRMappingList alloc] init];
    
    while (mappingXml) {
        [JMRMappingFactory mappingWithElement:mappingXml mappingList:mappingList];
        mappingXml = (XMLKeyValueElement *)[mappingXml nextTwin];
    }
    
    return mappingList;
}

-(void)addMappingType:(JMRMappingType *)value forName:(NSString *)name{
    
    if  (name) {
        [[self namedMappings] setObject:value forKey:name];
        // need to check for mappings "waiting" for this type
        [self updateMappingsWaitingForRef:name withType:value];
    }
}

-(JMRMappingType *)mappingTypeWithName:(NSString *)name{
    return [[self namedMappings] objectForKey:name];
}

-(void)addMapping:(JMRObjectMapping *)value forRootName:(NSString *)rootName {
    if  (rootName)
        [[self rootNamedMappings] setObject:value forKey:rootName];
}

-(JMRObjectMapping *)mappingWithRootName:(NSString *)rootName {
    return [[self rootNamedMappings] objectForKey:rootName];
}

// accessors

-(NSMutableDictionary *)namedMappings {
    if (!_namedMappings)
        _namedMappings = [[NSMutableDictionary alloc] init];
    return _namedMappings;
}

-(NSMutableDictionary *)rootNamedMappings {
    if (!_rootNamedMappings)
        _rootNamedMappings = [[NSMutableDictionary alloc] init];
    return _rootNamedMappings;
}

-(NSMutableDictionary *)waitingList {
    if (!_waitingList)
        _waitingList = [[NSMutableDictionary alloc] init];
    return _waitingList;
}

-(void)addToWaitingList:(JMRMapping *)mapping withRef:(NSString *)ref {
    NSMutableArray *mappingsForRef = [[self waitingList] objectForKey:ref];

    if (!mappingsForRef) {
        mappingsForRef = [NSMutableArray array];
        [[self waitingList] setObject:mappingsForRef forKey:ref];
    }
    [mappingsForRef addObject:mapping];
}

-(void)updateMappingsWaitingForRef:(NSString *)ref withType:(JMRMappingType *)type {
    NSMutableArray *mappingsWaitingForType;
    NSEnumerator *enumerator;
    JMRMapping *mapping;

    mappingsWaitingForType = [[self waitingList] objectForKey:ref];
    if (mappingsWaitingForType) {
        enumerator = [mappingsWaitingForType objectEnumerator];
        while (mapping = [enumerator nextObject])
            [mapping setMappingType:type];
    }
}

-(JMRMapping *)mappingWithMappingFactory:(JMRMappingFactory *)factory {
    JMRMappingType *mappingType;
    JMRMapping *mapping;
    
    mapping = [JMRMapping mappingWithXmlPath:[factory xmlPath] objectPath:[factory objectPath]];
    mappingType = [self mappingTypeWithName:[factory ref]];
    if (mappingType)
        [mapping setMappingType:mappingType];
    else
        [self addToWaitingList:mapping withRef:[factory ref]];
    
    return mapping;
}

-(void)dealloc {
    [_namedMappings release];
    [_rootNamedMappings release];
    
    [super dealloc];
}

@end
