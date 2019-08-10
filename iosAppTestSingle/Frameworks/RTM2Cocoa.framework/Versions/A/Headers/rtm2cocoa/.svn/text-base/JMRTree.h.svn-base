//
//  JMRTree.h

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import <Foundation/Foundation.h>


@interface JMRTree : NSObject {
    CFTreeRef _tree;
}


// init
-(id)initWithTreeRef:(CFTreeRef)treeRef;
-(id)initWithObject:(NSObject *)object;

+(JMRTree *)treeWithTreeRef:(CFTreeRef)treeRef;
+(JMRTree *)treeWithObject:(NSObject *)object;

-(CFTreeRef)getTree;
-(JMRTree *)createTree;
-(int)childCount;
-(JMRTree *)childAtIndex:(int)index;
-(JMRTree *)firstChild;
-(JMRTree *)nextSibling;
-(JMRTree *)parent;
-(void)addChild:(JMRTree *)child;
-(void)addChild:(JMRTree *)child afterChild:(JMRTree *)sibling;
-(void)prependChild:(JMRTree *)child;
-(void)insertSibling:(JMRTree *)sibling;
-(void)removeChild:(JMRTree *)child;
-(void)removeAllChildren;
-(void)detachFromParent;
-(CFTreeContext)context;
-(NSObject *)object;
-(void)setObject:(NSObject *)value;
-(void)dealloc;
@end
