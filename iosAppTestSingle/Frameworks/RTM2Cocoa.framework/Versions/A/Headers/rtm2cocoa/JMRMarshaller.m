//
//  JMRMarshaller.m

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import "JMRMarshaller.h"

@implementation JMRMarshaller

-(id)initWithObjectMapping:(JMRObjectMapping *)objectMapping {
    [self setObjectMapping:objectMapping];

    
    dummy = 0;
    
    
    return self;
}

+(JMRMarshaller *)marshallerWithObjectMapping:(JMRObjectMapping *)objectMapping {
    return [[[JMRMarshaller alloc] initWithObjectMapping:objectMapping] autorelease];
}

/* -(XMLKeyValueElement *)marshal:(id)object {
    if (!object)
        return nil;
    return [self marshal:object withMapping:[self objectMapping]];
} */

-(XMLKeyValueElement *)marshal:(id)object {
    return [self marshal:object
             withMapping:[self objectMapping]];
    /* XMLKeyValueElement *element;

    element = [XMLKeyValueElement elementWithName:[objectMapping rootName]];
    [self marshal:object intoElement:element withMapping:objectMapping isTemplate:NO];

    return element; */
}

-(XMLKeyValueElement *)marshal:(id)object withMapping:(JMRObjectMapping *)objectMapping {
    return [self marshalAndReturn:object
                      withMapping:objectMapping
                      intoElement:[XMLKeyValueElement elementWithName:[[self objectMapping] rootName]]
                       isTemplate:NO];
}

-(XMLKeyValueElement *)marshal:(id)object intoTemplate:(XMLKeyValueElement *)templateElt {
    return [self marshal:object withMapping:[self objectMapping] intoTemplate:templateElt];
}

-(XMLKeyValueElement *)marshal:(id)object
                   withMapping:(JMRObjectMapping *)objectMapping
                  intoTemplate:(XMLKeyValueElement *)templateElt {
    return [self marshalAndReturn:object
                      withMapping:objectMapping
                      intoElement:(XMLKeyValueElement *)[templateElt copyTree]
                       isTemplate:YES];
}

-(XMLKeyValueElement *)marshalAndReturn:(id)object
                            withMapping:(JMRObjectMapping *)objectMapping
                            intoElement:(XMLKeyValueElement *)element
                             isTemplate:(BOOL)isTemplate {
    if (!object)
        return nil;
    
    [self marshal:object intoElement:element withMapping:objectMapping isTemplate:isTemplate];

    return element;
}

-(void)marshal:(id)object
   intoElement:(XMLKeyValueElement *)element
   withMapping:(JMRObjectMapping *)objectMapping
    isTemplate:(BOOL)isTemplate {
    NSEnumerator *mappingEnumerator, *valuesEnumerator;
    JMRMapping *mapping;
    NSString *xmlPath, *objectPath;
    id objectValue;
    XMLKeyValueElement *templateElt, *prev, *next;

    if (!object)
        return;

    mappingEnumerator = [[objectMapping mappings] objectEnumerator];

    while (mapping = [mappingEnumerator nextObject]) {
        xmlPath = [mapping xmlPath];
        objectPath = [mapping objectPath];
        templateElt = isTemplate ? [element elementForKeyPath:xmlPath] : nil;

        // constant
        if ([mapping isConstant])
            [element setValue:[mapping defaultString] forKeyPath:xmlPath];
        else {
            objectValue = [object valueForKeyPath:objectPath];

            if (!objectValue)
                continue;
            
            // list
            if ([mapping isList]) {
                prev = templateElt;
                
                valuesEnumerator = [(NSArray *)objectValue objectEnumerator];
                while (objectValue = [valuesEnumerator nextObject]) {
                    next = [self marshalValue:objectValue
                                  intoElement:element
                                  withMapping:mapping
                                 withTemplate:templateElt];
                    if (isTemplate) {
                        [prev insertSibling:next];
                        prev = next;
                    }
                }

                if (templateElt)
                    [templateElt detachFromParent];
            } else
                [self marshalValue:objectValue intoElement:element withMapping:mapping withTemplate:templateElt];
        }
    }
}

-(XMLKeyValueElement *)marshalValue:(id)value
        intoElement:(XMLKeyValueElement *)element
        withMapping:(JMRMapping *)mapping
       withTemplate:(XMLKeyValueElement *)templateElt {
    XMLKeyValueElement *elementForPath;
    NSString *xmlPath = [mapping xmlPath];
    NSString *attributeKey = nil;
    JMRObjectMapping *objectMapping;

    // simplest case
    if ([mapping isScalar] && ![mapping isList]) {
        [element setValue:[mapping stringForValue:value] forKeyPath:xmlPath];
        return nil;
    }

    // look up xmlPath if this is a switch mapping
    if ([mapping isSwitch])
        xmlPath = [(JMRSwitchMappingType *)[mapping objectMapping] xmlPathForObject:value];

    // otherwise a bit messier...
    if ([mapping isList])
        if (templateElt)
            elementForPath = (XMLKeyValueElement *)[templateElt copyTree];
        else
            elementForPath = [element addElementForKeyPath:xmlPath attributeKey:&attributeKey];
    else
        elementForPath = [element elementForKeyPath:xmlPath attributeKey:&attributeKey createNodes:YES];
    
    // scalar
    if ([mapping isScalar]) {
        if (attributeKey && [attributeKey length]>0)
            [elementForPath setAttribute:[mapping stringForValue:value] forKey:attributeKey];
        else
            [elementForPath setText:[mapping stringForValue:value]];
    // object
    } else {
        objectMapping = [mapping objectMapping];
        if ([mapping isSwitch])
            objectMapping = [(JMRSwitchMappingType *)objectMapping objectMappingForObject:value];
        
        [self marshal:value
          intoElement:elementForPath
          withMapping:objectMapping
           isTemplate:(templateElt!=nil)];
    }

    return elementForPath;
}

-(id)unmarshal:(XMLKeyValueElement *)element {
    if (!element)
        return nil;
    return [self unmarshal:element withMapping:[self objectMapping]];
}

-(id)unmarshal:(XMLKeyValueElement *)element withMapping:(JMRObjectMapping *)objectMapping {
    id result;

    if (!element || !objectMapping)
        return nil;
    result = [objectMapping objectValue];
    [self unmarshal:element intoObject:result withMapping:objectMapping];

    return result;
}

-(void)unmarshal:(XMLKeyValueElement *)element intoObject:(id)object withMapping:(JMRObjectMapping *)objectMapping {
    NSEnumerator *mappingEnumerator;
    JMRMapping *mapping;
    XMLKeyValueElement *elementForPath;
    id objectValue;
    NSMutableArray *values;
    NSString *attributeKey = nil;
    BOOL isPanther = [object respondsToSelector:@selector(mutableArrayValueForKey:)];
    
    if (!object)
        return;

    mappingEnumerator = [[objectMapping mappings] objectEnumerator];

    while (mapping = [mappingEnumerator nextObject]) {
        // if constant, do nothing
        if (![mapping isConstant]) {
            if ([mapping isSwitch])
                elementForPath = (XMLKeyValueElement *)[element firstChild];
            else
                elementForPath = [element elementForKeyPath:[mapping xmlPath] attributeKey:&attributeKey createNodes:NO];

            // list
            if ([mapping isList]) {
                if (![object valueForKeyPath:[mapping objectPath]])
                    [object setValue:[NSMutableArray array] forKeyPath:[mapping objectPath]];
                // *** CHECK FOR Panther
                if (isPanther)
                    values = [object mutableArrayValueForKeyPath:[mapping objectPath]];
                else
                    values = [object valueForKeyPath:[mapping objectPath]];

                while (elementForPath) {
                    // attributeKey = nil; WHY DID I DO THIS???
                    objectValue = [self valueForElement:elementForPath attributeKey:attributeKey withMapping:mapping];
                    if (objectValue)
                        [values addObject:objectValue];
                    elementForPath = (XMLKeyValueElement *)([mapping isSwitch] ? [elementForPath nextSibling] : [elementForPath nextTwin]);
                }
            } else {
                objectValue = [self valueForElement:elementForPath attributeKey:attributeKey withMapping:mapping];
                if (objectValue)
                    [object setValue:objectValue forKeyPath:[mapping objectPath]];
            }
        }
    }
}

-(id)valueForElement:(XMLKeyValueElement *)element attributeKey:(NSString *)attributeKey withMapping:(JMRMapping *)mapping {
    JMRObjectMapping *objectMapping;
    JMRSwitchMappingType *switchMapping;
    
    if (!element)
        return nil;
    // scalar
    if ([mapping isScalar])
        return [mapping scalarValue:(attributeKey ? [element getAttributeForKey:attributeKey] : [element getText])];
    // object
    else {
        objectMapping = [mapping objectMapping];
        // find first sibling of element that matches one of the switch xmlPath values
        if ([mapping isSwitch]) {
            switchMapping = (JMRSwitchMappingType *)objectMapping;

            while (element &&
                   !(objectMapping = [switchMapping objectMappingForElement:element]))
                element = (XMLKeyValueElement *)[element nextSibling];
            NSLog(@"\n");
        }

        return [self unmarshal:element withMapping:objectMapping];
    }
}

// accessors
-(JMRObjectMapping *)objectMapping {
    return _objectMapping;
}

-(void)setObjectMapping:(JMRObjectMapping *)value {
    [value retain];
    [_objectMapping release];
    _objectMapping = value;
}

-(void)dealloc {
    [self setObjectMapping:nil];
    [super dealloc];
}
@end
