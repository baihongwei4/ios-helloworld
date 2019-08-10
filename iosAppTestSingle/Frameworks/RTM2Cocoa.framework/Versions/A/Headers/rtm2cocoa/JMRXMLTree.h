//
//  JMRXMLTree.h

/*

 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

 */

#import <Foundation/Foundation.h>
#include <CoreFoundation/CoreFoundation.h>
#import "JMRXMLNode.h"
#import "JMRTree.h"
#import "JMROutputStream.h"

@interface JMRXMLTree : JMRTree {
}

// init
-(CFXMLParserOptions)parserOptions;
-(id)initWithNewlyCreatedTreeRef:(CFTreeRef)treeRef;
-(id)initWithDataFromURL:(NSURL *)url;
-(id)initWithData:(NSData *)data;
-(id)initWithNode:(JMRXMLNode *)node;
-(id)initWithName:(NSString *)tagName;

/*
+(JMRXMLTree *)treeWithDataFromURL:(NSURL *)url;
+(JMRXMLTree *)treeWithData:(NSData *)data;
+(JMRXMLTree *)treeWithCFXMLTreeRef:(CFXMLTreeRef)treeRef;
+(JMRXMLTree *)treeWithCdata:(NSString *)cdata;
 */

-(NSData *)data;
+(JMRTree *)createTree;
-(JMRTree *)createTree;
-(JMRXMLTree *)copyTree;
-(JMRXMLNode *)getNode;
-(NSString *)getTag;
+(NSString *)getUnqualifiedName:(NSString *)name;
-(NSString *)getUnqualifiedTag;
-(NSString *)getNamespace;
-(JMRXMLTree *)childWithTag:(NSString *)tagName;
-(JMRXMLTree *)childWithTag:(NSString *)tag atIndex:(int)index;
-(JMRXMLTree *)nextTwin;
-(JMRXMLTree *)lastTwin;
-(NSString *)getAttributeForKey:(NSString *)key;
-(void)setAttribute:(NSString *)value forKey:(NSString *)key;
-(BOOL)isCdata;
-(BOOL)cdataNode;
-(BOOL)textNode;
-(BOOL)isText;
-(BOOL)hasText;
-(NSString *)nodeString;
-(NSString *)getText;
-(void)setText:(NSString *)text isCdata:(BOOL)isCdata;
-(void)setText:(NSString *)text;
-(void)setCdata:(NSString *)text;
-(NSString *)description;
-(NSString *)descriptionWithEncoding:(NSStringEncoding)encoding;
-(void)print;
-(void)printWithIndent:(NSString *)indentation;
-(NSString *)formattedString;
-(void)writeToFile:(NSString *)path;
-(void)printToStream:(JMROutputStream *)stream;
-(BOOL)hasChildren;
-(void)printStartTagToStream:(JMROutputStream *)stream;
-(NSString *)endTag;
-(void)printToStream:(JMROutputStream *)stream withIndent:(NSString *)indent;
-(JMRXMLTree *)root;
@end
