//
//  JMRXMLNode.h

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import <Foundation/Foundation.h>
#include <CoreFoundation/CoreFoundation.h>

@interface JMRXMLNode : NSObject {
    CFXMLNodeRef _xmlNode;
    NSMutableDictionary *_attributes;
    NSMutableArray *_attributeOrder;
}

// accessors
-(NSMutableDictionary *)getAttributes;
-(void)setAttributes:(NSMutableDictionary *)value;
-(NSMutableArray *)getAttributeOrder;
-(void)setAttributeOrder:(NSMutableArray *)value;

-(id)initWithString:(NSString *)string type:(int)type info:(CFXMLElementInfo *)info;
-(id)initWithCFXMLNodeRef:(CFXMLNodeRef)nodeRef;
-(id)initWithName:(NSString *)tagName;
-(id)initWithText:(NSString *)text;
-(id)initWithCdata:(NSString *)cdata;

+(JMRXMLNode *)nodeWithCFXMLNodeRef:(CFXMLNodeRef)nodeRef;
+(JMRXMLNode *)nodeWithName:(NSString *)tagName;
+(JMRXMLNode *)nodeWithText:(NSString *)text;
+(JMRXMLNode *)nodeWithCdata:(NSString *)cdata;

-(CFXMLNodeRef)nodeRef;
-(NSString *)getString;
-(NSString *)getAttributeForKey:(NSString *)key;
-(void)setAttribute:(NSString *)value forKey:(NSString *)key;
-(BOOL)isType:(int)type;
-(BOOL)isElement;
-(BOOL)isComment;
-(BOOL)isProcessingInstruction;
-(BOOL)isText;
-(BOOL)isCdata;
-(BOOL)isDocument;
-(void)dealloc;
@end
