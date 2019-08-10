//
//  JMRXMLTree.m

/*

 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

 */

#import "JMRXMLTree.h"

@implementation JMRXMLTree

-(CFXMLParserOptions)parserOptions {
    return kCFXMLParserSkipWhitespace;
}

-(id)initWithNewlyCreatedTreeRef:(CFTreeRef)treeRef {
    id newTree = [self initWithTreeRef:treeRef];

    if (newTree)
        CFRelease(treeRef);

    return newTree;
}

-(id)initWithDataFromURL:(NSURL *)url {
    return [self initWithNewlyCreatedTreeRef:CFXMLTreeCreateWithDataFromURL(kCFAllocatorDefault,
                                                                            (CFURLRef)url,
                                                                            [self parserOptions],
                                                                            kCFXMLNodeCurrentVersion)];
}

-(id)initWithData:(NSData *)data {
    return [self initWithNewlyCreatedTreeRef:CFXMLTreeCreateFromData(kCFAllocatorDefault,
                                                                     (CFDataRef)data,
                                                                     NULL,
                                                                     [self parserOptions],
                                                                     kCFXMLNodeCurrentVersion)];
}

-(id)initWithNode:(JMRXMLNode *)node {
    return [self initWithNewlyCreatedTreeRef:CFXMLTreeCreateWithNode(kCFAllocatorDefault,
                                                                     [node nodeRef])];
}

-(id)initWithName:(NSString *)tagName {
    return [self initWithNode:[JMRXMLNode nodeWithName:tagName]];
}

/*
+(JMRXMLTree *)treeWithDataFromURL:(NSURL *)url {
    return [[[self createTree] initWithDataFromURL:url] autorelease];
}

+(JMRXMLTree *)treeWithData:(NSData *)data {
    return [[[self createTree] initWithData:data] autorelease];
}

+(JMRXMLTree *)treeWithCFXMLTreeRef:(CFXMLTreeRef)treeRef {
    return [[[self createTree] initWithTreeRef:treeRef] autorelease];
}

+(JMRXMLTree *)treeWithCdata:(NSString *)cdata {
    return [[[self createTree] initWithNode:[JMRXMLNode nodeWithCdata:cdata]] autorelease];
}
 */

-(NSData *)data {
    return (NSData *)CFXMLTreeCreateXMLData(kCFAllocatorDefault, [self getTree]);
}

-(JMRXMLTree *)copyTree {
    return [[(JMRXMLTree *)[self createTree] initWithData:[self data]] root];
}


-(id)copyWithZone:(NSZone *)zone {
    return [self copyTree];
}

+(JMRTree *)createTree {
    return [JMRXMLTree alloc];
}

-(JMRTree *)createTree {
    return [JMRXMLTree alloc];
}

-(JMRXMLNode *)getNode {
    CFXMLNodeRef nodeRef = CFXMLTreeGetNode(_tree);
    return [JMRXMLNode nodeWithCFXMLNodeRef:nodeRef];
}

-(NSString *)getTag {
    // return [[self getNode] getString];
    return [self nodeString];
}

+(NSString *)getUnqualifiedName:(NSString *)name {
    int i;

    for (i=0; i<[name length]; i++) 
        if ([name characterAtIndex:i]==':')
            return [name substringFromIndex:i+1];
    
    return name;
}

// tag name excluding name space prefix
-(NSString *)getUnqualifiedTag {
    /* NSString *tag = [self getTag];
    int i;

    for (i=0; i<[tag length]; i++) 
        if ([tag characterAtIndex:i]==':')
            return [tag substringFromIndex:i+1];
    
    return tag; */
    return [JMRXMLTree getUnqualifiedName:[self getTag]];
}

// return namespace prefix
-(NSString *)getNamespace {
    NSString *tag = [self getTag];
    int i;
    
    for (i=0; i<[tag length]; i++) 
        if ([tag characterAtIndex:i]==':')
            return [tag substringToIndex:i];
    
    return nil;
}

// return the first child with name tag
-(JMRXMLTree *)childWithTag:(NSString *)tag {
    return [self childWithTag:tag atIndex:0];
}

// return the indexth child with name tag
-(JMRXMLTree *)childWithTag:(NSString *)tag atIndex:(int)index {
    JMRXMLTree *child;
    int i, nth = 0;

    for (i=0; i<[self childCount]; i++) {
        child = (JMRXMLTree *)[self childAtIndex:i];
        
        // if ([[child getTag] isEqualToString:tag]) {
        if ([[child getUnqualifiedTag] isEqualToString:tag]) {
            if ((nth++)==index)
                return child;
        }
    }
    return nil;
}

-(JMRXMLTree *)nextTwin {
    NSString *tag = [self getTag];
    JMRXMLTree *sibling = self;

    while (sibling = (JMRXMLTree *)[sibling nextSibling])
        if ([tag isEqualToString:[sibling getTag]])
            return sibling;
    
    return nil;
}

-(JMRXMLTree *)lastTwin {
    JMRXMLTree *sibling = self;

    while (sibling = (JMRXMLTree *)[sibling nextTwin]);

    return sibling;
}

-(BOOL)textNode {
    return [[self getNode] isText];
}

-(BOOL)isCdata {
    return [self childCount]==1 && [(JMRXMLTree *)[self firstChild] cdataNode];
}

-(BOOL)cdataNode {
    return [[self getNode] isCdata];
}

// if not exactly one text child, this is not a text tree
-(BOOL)isText {
    return [self childCount]==1 && [(JMRXMLTree *)[self firstChild] textNode];
}

-(BOOL)hasText {
  int i;
  
  for (i=0; i<[self childCount]; i++)
    if ([(JMRXMLTree *)[self childAtIndex:i] textNode])
      return YES;
  return NO;
}

-(NSString *)nodeString {
    return [[self getNode] getString];
}

-(NSString *)getText {
    if ([self isText] || [self isCdata])
        return [(JMRXMLTree *)[self firstChild] nodeString];
    if ([self textNode] || [self cdataNode])
      return [self nodeString];

    return nil;
}

-(void)setText:(NSString *)text isCdata:(BOOL)isCdata {
    JMRXMLTree *textTree;
    JMRXMLNode *node = isCdata ? [JMRXMLNode nodeWithCdata:text] : [JMRXMLNode nodeWithText:text];

    // create new tree containing new text node containing text
    textTree = [[(JMRXMLTree *)[self createTree] initWithNode:node] autorelease];
    // remove existing child
    [self removeAllChildren];
    // add new tree as child
    [self addChild:textTree];
}

-(void)setText:(NSString *)text {
    [self setText:text isCdata:[self isCdata]];
}

-(void)setCdata:(NSString *)text {
    [self setText:text isCdata:YES];
}

-(NSString *)getAttributeForKey:(NSString *)key {
    return [[self getNode] getAttributeForKey:key];
}

-(void)setAttribute:(NSString *)value forKey:(NSString *)key {
    [[self getNode] setAttribute:value forKey:key];
}

-(NSString *)description {
    // what encoding to use ???
    return [self descriptionWithEncoding:[NSString defaultCStringEncoding]];
}

-(NSString *)descriptionWithEncoding:(NSStringEncoding)encoding {
    return [[[NSString alloc] initWithData:[self data] encoding:encoding] autorelease];
}

-(void)print {
    [self printWithIndent:[[[NSString alloc] init] autorelease]];
}

// print the current node in ooutline format
-(void)printWithIndent:(NSString *)indentation {
    int childCount, index;
    NSString *text = [self getText];
    NSString *nodeStr = [self getTag];

    // comment
    if ([[self getNode] isComment])
        NSLog(@"%s",[NSString stringWithFormat:@"%@<!-- %@ -->", indentation, nodeStr]);
    // processing instruction
    else if ([[self getNode] isProcessingInstruction])
        NSLog(@"%s",[NSString stringWithFormat:@"%@<? %@ ?>", indentation, nodeStr]);
    // text element (single #PCDATA child)
    else if (text)
        NSLog(@"%s",[NSString stringWithFormat:@"%@<%@>%@</%@>", indentation, nodeStr, text, nodeStr]);
    else {
        NSLog(@"%s",[NSString stringWithFormat:@"%@<%@>", indentation, nodeStr]);
        childCount = [self childCount];
        for (index = 0; index < childCount; index++)
            [(JMRXMLTree *)[self childAtIndex:index] printWithIndent:[@"\t" stringByAppendingString:indentation]];
        NSLog(@"%s",[NSString stringWithFormat:@"%@</%@>", indentation, nodeStr]);
    }
}

-(NSString *)formattedString {
    JMROutputStream *stream = [JMROutputStream outputStreamToMemory];
    
    [self printToStream:stream];
    
    return [stream stringValue];
}

-(void)writeToFile:(NSString *)path {
    JMROutputStream *stream = [JMROutputStream outputStreamToFileAtPath:path];
    
    [self printToStream:stream];
}

-(void)printToStream:(JMROutputStream *)stream {
    // [self printToStream:stream withIndent:@""];
    [self printToStream:stream withIndent:@""];
}

-(BOOL)hasChildren {
    return [self childCount]>0;
}

-(void)printStartTagToStream:(JMROutputStream *)stream {
    NSEnumerator *attributeKeys = [[[self getNode] getAttributeOrder] objectEnumerator];
    NSString *key;
    
    [stream writeString:@"<"];
    [stream writeString:[self getTag]];
    while (key = [attributeKeys nextObject])
        [stream writeString:[NSString stringWithFormat:@" %@=\"%@\"", key, [self getAttributeForKey:key]]];
    [stream writeString:([self hasChildren] ? @">" : @"/>")];
}

-(NSString *)endTag {
    return [NSString stringWithFormat:@"</%@>", [self getTag]];
}

-(void)printToStream:(JMROutputStream *)stream withIndent:(NSString *)indent {
    int childCount, index;
    NSString *nextIndent = nil;
    JMRXMLTree *child;
    BOOL doIndent;
    
    if (![[self getNode] isElement]) {
        // indent everything but text nodes
        if (![self textNode])
            [stream writeString:indent];
        [stream writeString:[self description]];
    } else {
        [stream writeString:indent];
        [self printStartTagToStream:stream];
        childCount = [self childCount];
        if (childCount!=0) {
	    // [stream writeString:@">"];
	    doIndent = ![self hasText];
	    if (doIndent) {
                if ([indent length]==0)
                    indent = @"\n";
                nextIndent = [indent stringByAppendingString:@"    "];
	    }
            for (index=0; index<childCount; index++) {
  	        child = (JMRXMLTree *)[self childAtIndex:index];
		if (doIndent)
                    [child printToStream:stream withIndent:nextIndent];
		else
                    [stream writeString:[child description]];
	    }
            if (doIndent)
                [stream writeString:indent];
            [stream writeString:[self endTag]];
        }
    }
}

// skip non-element nodes to find root element node
-(JMRXMLTree *)root {
    int childCount, i;
    JMRXMLTree *child;

    if ([[self getNode] isElement])
        return self;
    childCount = [self childCount];
    for (i=0; i<childCount; i++) {
        child = (JMRXMLTree *)[self childAtIndex:i];
        if ([[child getNode] isElement])
            return child;
    }
    return nil;
}
@end
