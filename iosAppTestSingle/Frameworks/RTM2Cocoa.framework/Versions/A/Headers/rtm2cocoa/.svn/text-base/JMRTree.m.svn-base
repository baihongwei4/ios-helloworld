//
//  JMRTree.m

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import "JMRTree.h"

@implementation JMRTree

-(id)init {
    return [self initWithObject:nil];
}

-(id)initWithTreeRef:(CFTreeRef)treeRef {
    [super init];
    if (treeRef) {
        CFRetain(treeRef);
	_tree = treeRef;
	return self;
    }

    return nil;
}

-(id)initWithObject:(NSObject *)object {
    CFTreeContext ctx;

    ctx.version = 0;
    ctx.info = object;
    ctx.retain = NULL;
    ctx.release = NULL;
    ctx.copyDescription = NULL;
    
    return [self initWithTreeRef:CFTreeCreate(kCFAllocatorDefault, &ctx)];
}

+(JMRTree *)treeWithTreeRef:(CFTreeRef)treeRef {
    return [[[JMRTree alloc] initWithTreeRef:treeRef] autorelease];
}

+(JMRTree *)treeWithObject:(NSObject *)object {
    return [[[JMRTree alloc] initWithObject:object] autorelease];
}

+(JMRTree *)createTree {
    return [JMRTree alloc];
}

-(JMRTree *)createTree {
    return [JMRTree alloc];
}

-(JMRTree *)createTreeWithTreeRef:(CFTreeRef)treeRef {
    return treeRef ? [[[self createTree] initWithTreeRef:treeRef] autorelease] : nil;
}

-(CFTreeRef)getTree {
    return _tree;
}

-(int)childCount {
    return CFTreeGetChildCount(_tree);
}

-(JMRTree *)childAtIndex:(int)index {
    return [self createTreeWithTreeRef:CFTreeGetChildAtIndex(_tree, index)];
}

-(JMRTree *)firstChild {
    return [self childAtIndex:0];
}

-(JMRTree *)nextSibling {
    return [self createTreeWithTreeRef:CFTreeGetNextSibling(_tree)];
}

-(JMRTree *)parent {
    return [self createTreeWithTreeRef:CFTreeGetParent(_tree)];
}

-(void)addChild:(JMRTree *)child {
    if (child)
        CFTreeAppendChild([self getTree], [child getTree]);
}

-(void)addChild:(JMRTree *)child afterChild:(JMRTree *)sibling {
    if (child && sibling)
        [sibling insertSibling:child];
}

-(void)prependChild:(JMRTree *)child {
    if (child)
        CFTreePrependChild([self getTree], [child getTree]);
}

-(void)insertSibling:(JMRTree *)sibling {
    if (sibling)
        CFTreeInsertSibling([self getTree], [sibling getTree]);
}

-(void)removeChild:(JMRTree *)child {
    if (child && [child parent]==self)
        [child detachFromParent];
}

-(void)detachFromParent {
    CFTreeRemove([self getTree]);
}

-(void)removeAllChildren {
    CFTreeRemoveAllChildren([self getTree]);
}

-(CFTreeContext)context {
    CFTreeContext ctx;

    CFTreeGetContext([self getTree], &ctx);
    return ctx;
}

-(NSObject *)object {
    return (NSObject *)[self context].info;
}
-(void)setObject:(NSObject *)value {
    CFTreeContext ctx = [self context];

    ctx.info = value;
    CFTreeSetContext([self getTree], &ctx);
}

-(void)dealloc {
    CFRelease(_tree);
    [super dealloc];
}

@end
