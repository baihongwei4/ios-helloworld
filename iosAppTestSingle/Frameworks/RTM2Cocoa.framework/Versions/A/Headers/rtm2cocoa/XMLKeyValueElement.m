//
//  XMLKeyValueElement.m

/*

 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

 */

#import "XMLKeyValueElement.h"

static NSString *DELIMITER = @"/";
static NSString *ATTRIBUTE_DELIMITER = @"@";
static NSString *SELF_KEY_PATH = @".";
static NSString *PARENT_KEY_PATH = @"..";

static int DONT_CREATE = 0;
static int CREATE = 1;
static int ADD = 2;
static int DUPLICATE = 3;

@implementation XMLKeyValueElement

// we are only interested in the root element and throw everything else away
+(XMLKeyValueElement *)rootElement:(XMLKeyValueElement *)element {
    XMLKeyValueElement *root = (XMLKeyValueElement *)[element root];

    if (root!=element)
        [element release];

    return root;
}

+(XMLKeyValueElement *)elementWithName:(NSString *)name {
    return [[[self createTree] initWithName:name] autorelease];
}

+(XMLKeyValueElement *)elementWithDataFromURL:(NSURL *)url {
    return [self rootElement:[[self createTree] initWithDataFromURL:url]];
}

+(XMLKeyValueElement *)elementWithData:(NSData *)data {
    return [self rootElement:[[self createTree] initWithData:data]];
}

-(XMLKeyValueElement *)elementForKeyPath:(NSArray *)components
                                   index:(unsigned int)index
                             createFlag:(unsigned int)createFlag {
    NSString *key = [components objectAtIndex:index];
    XMLKeyValueElement *next;
    int nth = 0, numberStart, openBracket, endBracket;

    if ((index+1)==[components count] && [@"cdata()" isEqualToString:key]) {
        if (![self isCdata])
            [self setCdata:@""];
        return self;
    }
        
    // check for pattern key[n], e.g. tr[2]
    openBracket = [self indexOfCharacter:'[' inString:key];
    if (openBracket!=-1) {
        numberStart = openBracket + 1;
        endBracket = [self indexOfCharacter:']' inString:key];
        nth = [[key substringWithRange:NSMakeRange(numberStart, endBracket-numberStart)] intValue];
        key = [key substringToIndex:openBracket];
    }

    next = (XMLKeyValueElement *)[self childWithTag:key atIndex:nth];

    if (createFlag>=ADD && ((index+1)==[components count])) {
        if (createFlag==DUPLICATE)
            next = (XMLKeyValueElement *)[next copyTree];
        else
            next = [XMLKeyValueElement elementWithName:[components lastObject]];
        [self addChild:next];
        return next;
    }
    if (!next)
        if (createFlag>=CREATE) {
            next = [XMLKeyValueElement elementWithName:key];
            [self addChild:next];
        } else
            return nil;
    return (++index==[components count]) ? next :
        [next elementForKeyPath:components index:index createFlag:createFlag];
}

-(XMLKeyValueElement *)elementForKeyPath:(NSString *)keyPath
                            attributeKey:(NSString **)attributeKey
                             createNodes:(BOOL)createNodes
                                     add:(BOOL)add {
    int flag = add ? ADD : (createNodes ? CREATE : DONT_CREATE);

    return [self elementForKeyPath:keyPath attributeKey:attributeKey createFlag:flag];
}
    
-(XMLKeyValueElement *)elementForKeyPath:(NSString *)keyPath
                            attributeKey:(NSString **)attributeKey
                             createNodes:(BOOL)createNodes {
    // check for special "current" and "parent keys
    if ([SELF_KEY_PATH isEqualToString:keyPath])
        return self;
    else if ([PARENT_KEY_PATH isEqualToString:keyPath])
        return [self parent];
    return [self elementForKeyPath:keyPath attributeKey:attributeKey createNodes:createNodes add:NO];
}

// this should really be in a category of NSString
-(int)indexOfCharacter:(char)c inString:(NSString *)string {
    int i;

    for (i=0; i<[string length]; i++)
        if ([string characterAtIndex:i]==c)
            return i;

    return -1;
}

// find the element for path keyPath and also set the attribute key if it exists
-(XMLKeyValueElement *)elementForKeyPath:(NSString *)keyPath
                            attributeKey:(NSString **)attributeKey
                             createFlag:(unsigned int)flag {
    NSMutableArray *components = [NSMutableArray arrayWithArray:[keyPath componentsSeparatedByString:DELIMITER]];
    NSString *lastKey = [components lastObject];
    NSArray *attrComponents = [lastKey componentsSeparatedByString:ATTRIBUTE_DELIMITER];

    if ([attrComponents count]>1) {
        lastKey = [attrComponents objectAtIndex:0];

        if (attributeKey)
            *attributeKey = [attrComponents lastObject];

        if ([components count]==1 && [lastKey isEqualToString:@""])
            return self;

        [components replaceObjectAtIndex:[components count]-1
                              withObject:lastKey];
    } else
        *attributeKey = nil;
    
    return [self elementForKeyPath:components index:0 createFlag:flag];
}

-(XMLKeyValueElement *)elementForKeyPath:(NSString *)keyPath createNodes:(BOOL)createNodes {
    NSString *attributeKey = nil;
    
    return [self elementForKeyPath:keyPath
                      attributeKey:&attributeKey
                       createNodes:createNodes];
}

-(XMLKeyValueElement *)elementForKeyPath:(NSString *)keyPath {
    return [self elementForKeyPath:keyPath createNodes:NO];
}

-(XMLKeyValueElement *)addElementForKeyPath:(NSString *)keyPath {
    NSString *attributeKey;

    return [self addElementForKeyPath:keyPath
                         attributeKey:&attributeKey];
}

-(XMLKeyValueElement *)addElementForKeyPath:(NSString *)keyPath attributeKey:(NSString **)attributeKey {
    return [self elementForKeyPath:keyPath
                      attributeKey:attributeKey
                        createFlag:ADD];
}

-(void)addElement:(XMLKeyValueElement *)element forKeyPath:(NSString *)keyPath {
    NSString *attributeKey;
    XMLKeyValueElement *eltForKeyPath;

    if (!keyPath)
        return;

    eltForKeyPath = (XMLKeyValueElement *)[[self elementForKeyPath:keyPath attributeKey:&attributeKey createNodes:NO] lastTwin];

    [eltForKeyPath insertSibling:element];
}

-(XMLKeyValueElement *)duplicateElementForKeyPath:(NSString *)keyPath {
    NSString *attributeKey;

    return [self elementForKeyPath:keyPath
                      attributeKey:&attributeKey
                       createFlag:DUPLICATE];
}

-(NSString *)valueForKeyPath:(NSString *)keyPath {
    NSString *attributeKey = nil;
    XMLKeyValueElement *eltForKeyPath;

    if (!keyPath)
        return nil;

    eltForKeyPath = [self elementForKeyPath:keyPath attributeKey:&attributeKey createNodes:NO];
    return attributeKey ? [eltForKeyPath getAttributeForKey:attributeKey] : [eltForKeyPath getText];
}

-(void)setValue:(NSString *)value forKeyPath:(NSString *)keyPath {
    NSString *attributeKey;
    XMLKeyValueElement *eltForKeyPath;

    if (!keyPath)
        return;

    eltForKeyPath = [self elementForKeyPath:keyPath attributeKey:&attributeKey createNodes:YES];

    if (attributeKey && [attributeKey length]>0)
        [eltForKeyPath setAttribute:value forKey:attributeKey];
    else
        [eltForKeyPath setText:value];
}

+(JMRTree *)createTree {
    return [XMLKeyValueElement alloc];
}

-(JMRTree *)createTree {
    return [XMLKeyValueElement alloc];
}

@end
