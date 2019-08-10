//
//  JMRMarshaller.h

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import <Foundation/Foundation.h>
#import "JMRSwitchMappingType.h"
#import "XMLKeyValueElement.h"

@interface JMRMarshaller : NSObject {
    JMRObjectMapping *_objectMapping;
    BOOL _isTemplate;
    
    int dummy;
}

-(id)initWithObjectMapping:(JMRObjectMapping *)objectMapping;

+(JMRMarshaller *)marshallerWithObjectMapping:(JMRObjectMapping *)objectMapping;

// use these as public methods!!
-(XMLKeyValueElement *)marshal:(id)object;
-(XMLKeyValueElement *)marshal:(id)object intoTemplate:(XMLKeyValueElement *)templateElt;
-(id)unmarshal:(XMLKeyValueElement *)element;

// use and rely on these at your own risk!!
-(XMLKeyValueElement *)marshal:(id)object withMapping:(JMRObjectMapping *)objectMapping;
-(XMLKeyValueElement *)marshal:(id)object
                   withMapping:(JMRObjectMapping *)objectMapping
                  intoTemplate:(XMLKeyValueElement *)templateElt;
-(XMLKeyValueElement *)marshalAndReturn:(id)object
                            withMapping:(JMRObjectMapping *)objectMapping
                            intoElement:(XMLKeyValueElement *)element
                             isTemplate:(BOOL)isTemplate;
-(void)marshal:(id)object
   intoElement:(XMLKeyValueElement *)element
   withMapping:(JMRObjectMapping *)objectMapping
    isTemplate:(BOOL)isTemplate;
-(XMLKeyValueElement *)marshalValue:(id)value
                        intoElement:(XMLKeyValueElement *)element
                        withMapping:(JMRMapping *)mapping
                       withTemplate:(XMLKeyValueElement *)templateElt;

-(id)unmarshal:(XMLKeyValueElement *)element withMapping:(JMRObjectMapping *)objectMapping;
-(void)unmarshal:(XMLKeyValueElement *)element intoObject:(id)object withMapping:(JMRObjectMapping *)objectMapping;
-(id)valueForElement:(XMLKeyValueElement *)element attributeKey:(NSString *)attributeKey withMapping:(JMRMapping *)mapping;

// accessors

-(JMRObjectMapping *)objectMapping;
-(void)setObjectMapping:(JMRObjectMapping *)value;
@end
