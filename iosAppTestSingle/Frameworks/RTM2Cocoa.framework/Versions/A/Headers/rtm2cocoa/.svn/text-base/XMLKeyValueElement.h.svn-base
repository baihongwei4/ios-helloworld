//
//  XMLKeyValueElement.h

/*

 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

 */

#import <Foundation/Foundation.h>
#import "JMRXMLTree.h"

@interface XMLKeyValueElement : JMRXMLTree {
}

// "public" interface

+(XMLKeyValueElement *)rootElement:(XMLKeyValueElement *)element;
+(XMLKeyValueElement *)elementWithName:(NSString *)name;
+(XMLKeyValueElement *)elementWithDataFromURL:(NSURL *)url;
+(XMLKeyValueElement *)elementWithData:(NSData *)data;

-(XMLKeyValueElement *)elementForKeyPath:(NSString *)keyPath;
-(XMLKeyValueElement *)addElementForKeyPath:(NSString *)keyPath;
-(XMLKeyValueElement *)addElementForKeyPath:(NSString *)keyPath attributeKey:(NSString **)attributeKey;

-(NSString *)valueForKeyPath:(NSString *)keyPath;
-(void)setValue:(NSString *)value forKeyPath:(NSString *)keyPath;

// use at your own risk!

-(XMLKeyValueElement *)elementForKeyPath:(NSString *)keyPath createNodes:(BOOL)createNodes;
-(XMLKeyValueElement *)elementForKeyPath:(NSString *)keyPath
                            attributeKey:(NSString **)attributeKey
                             createNodes:(BOOL)createNodes;
-(XMLKeyValueElement *)elementForKeyPath:(NSString *)keyPath
                            attributeKey:(NSString **)attributeKey
                             createNodes:(BOOL)createNodes
                                     add:(BOOL)add;
-(XMLKeyValueElement *)elementForKeyPath:(NSString *)keyPath
                            attributeKey:(NSString **)attributeKey
                              createFlag:(unsigned int)flag;
-(XMLKeyValueElement *)elementForKeyPath:(NSArray *)components
                                   index:(unsigned int)index
                              createFlag:(unsigned int)createFlag;
-(void)addElement:(XMLKeyValueElement *)element forKeyPath:(NSString *)keyPath;

-(int)indexOfCharacter:(char)c inString:(NSString *)string;
@end
