//
//  JMRXMLNode.m

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import "JMRXMLNode.h"

@implementation JMRXMLNode

-(id)initWithCFXMLNodeRef:(CFXMLNodeRef)nodeRef {
    [super init];
    if (nodeRef) {
      CFRetain(nodeRef);
      _xmlNode = nodeRef;
      return self;
    }
    
    return nil;
}

-(id)initWithString:(NSString *)string type:(int)type info:(CFXMLElementInfo *)info {
    CFXMLNodeRef ref = CFXMLNodeCreate(kCFAllocatorDefault,
                                       type, (CFStringRef)string, info,
                                       kCFXMLNodeCurrentVersion);
    return [self initWithCFXMLNodeRef:ref];
}

-(id)initWithName:(NSString *)tagName {
    CFXMLElementInfo *info = (CFXMLElementInfo *)malloc(sizeof(CFXMLElementInfo));

    // keep references to these
    info->attributes = (CFDictionaryRef)[self getAttributes];
    info->attributeOrder = (CFArrayRef)[self getAttributeOrder];
    info->isEmpty = NO;
    
    return [self initWithString:tagName type:kCFXMLNodeTypeElement info:info];
}

-(id)initWithText:(NSString *)text {
    return [self initWithString:text type:kCFXMLNodeTypeText info:NULL];
}

-(id)initWithWhitespace:(NSString *)text {
    return [self initWithString:text type:kCFXMLNodeTypeWhitespace info:NULL];
}

-(id)initWithCdata:(NSString *)cdata {
    return [self initWithString:cdata type:kCFXMLNodeTypeCDATASection info:NULL];
}

+(JMRXMLNode *)nodeWithCFXMLNodeRef:(CFXMLNodeRef)nodeRef {
    return [[[JMRXMLNode alloc] initWithCFXMLNodeRef:nodeRef] autorelease];
}

+(JMRXMLNode *)nodeWithName:(NSString *)tagName {
    return [[[JMRXMLNode alloc] initWithName:tagName] autorelease];
}

+(JMRXMLNode *)nodeWithText:(NSString *)text {
    return [[[JMRXMLNode alloc] initWithText:text] autorelease];
}

+(JMRXMLNode *)nodeWithCdata:(NSString *)cdata {
    return [[[JMRXMLNode alloc] initWithText:cdata] autorelease];
}

-(CFXMLNodeRef)nodeRef {
    return _xmlNode;
}

-(CFXMLElementInfo *)info {
    if (_xmlNode)
        return (CFXMLElementInfo *)CFXMLNodeGetInfoPtr(_xmlNode);
    return nil;
}

-(NSMutableDictionary *)getAttributes {
    CFXMLElementInfo *info;

    if (_xmlNode && ![self isElement])
        return nil;
    if (!_attributes) {
        info = [self info];
        [self setAttributes:((info && info->attributes) ?
                             [NSMutableDictionary dictionaryWithDictionary:(NSDictionary *)info->attributes] :
                             [NSMutableDictionary dictionary])];
        // need to allocate attribute order, too
        [self getAttributeOrder];
    }
    return _attributes;
}
-(void)setAttributes:(NSMutableDictionary *)value {
    CFXMLElementInfo *info = [self info];

    [value retain];
    [_attributes release];
    _attributes = value;
    if (info)
        info->attributes = (CFDictionaryRef)_attributes;
}

-(NSMutableArray *)getAttributeOrder {
    CFXMLElementInfo *info;

    if (_xmlNode && ![self isElement])
        return nil;
    if (!_attributeOrder) {
        info = [self info];
        [self setAttributeOrder:((info && info->attributeOrder) ?
                                 [NSMutableArray arrayWithArray:(NSArray *)info->attributeOrder] :
                                 [NSMutableArray array])];
    }
    return _attributeOrder;
}
-(void)setAttributeOrder:(NSMutableArray *)value {
    CFXMLElementInfo *info = [self info];
    
    [value retain];
    [_attributeOrder release];
    _attributeOrder = value;
    if (info)
        info->attributeOrder = (CFArrayRef)_attributeOrder;
}

-(NSString *)getAttributeForKey:(NSString *)key {
    return [[self getAttributes] objectForKey:key];
}

-(void)setAttribute:(NSString *)value forKey:(NSString *)key {
    if (!value) {
        [[self getAttributeOrder] removeObject:key];
        [[self getAttributes] removeObjectForKey:key];
    } else {
        if (![[self getAttributeOrder] containsObject:key])
            [[self getAttributeOrder] addObject:key];
        [[self getAttributes] setObject:value forKey:key];
    }
}

-(NSString *)getString {
    return (NSString *)CFXMLNodeGetString(_xmlNode);
}

-(BOOL)isType:(int)type {
    return _xmlNode && CFXMLNodeGetTypeCode(_xmlNode)==type;
}

-(BOOL)isElement {
    return [self isType:kCFXMLNodeTypeElement];
}

-(BOOL)isComment {
    return [self isType:kCFXMLNodeTypeComment];
}

-(BOOL)isProcessingInstruction {
    return [self isType:kCFXMLNodeTypeProcessingInstruction];
}

-(BOOL)isText {
    return [self isType:kCFXMLNodeTypeText];
}

-(BOOL)isCdata {
    return [self isType:kCFXMLNodeTypeCDATASection];
}

-(BOOL)isDocument {
    return [self isType:kCFXMLNodeTypeDocument];
}

-(void)dealloc {
    CFRelease(_xmlNode);
    [super dealloc];
}

@end
