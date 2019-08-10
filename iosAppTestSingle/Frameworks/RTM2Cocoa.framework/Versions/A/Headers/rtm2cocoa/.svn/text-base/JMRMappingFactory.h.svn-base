//
//  JMRMappingFactory.h

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import <Foundation/Foundation.h>
#import "JMRStringMapping.h"
#import "JMRDateMapping.h"
#import "JMRNumberMapping.h"
#import "JMRSwitchMappingType.h"
#import "JMRBooleanMapping.h"
#import "JMRMarshaller.h"
#import "XMLKeyValueElement.h"

@class JMRMappingList;

@interface JMRMappingFactory : JMRMapping {
    NSString *_type;
    NSString *_ref;
    NSString *_name;

    NSString *_format;

    NSString *_className;
    NSMutableArray *_childMappings;
    NSString *_rootName;
}

-(JMRMapping *)makeMapping;
+(JMRObjectMapping *)mappingFactoryObjectMapping;
+(JMRMapping *)mappingWithDataFromUrl:(NSURL *)url;
+(JMRMapping *)mappingWithElement:(XMLKeyValueElement *)elt mappingList:(JMRMappingList *)list;

// accessors
-(NSString *)type;
-(void)setType:(NSString *)value;
-(NSString *)rootName;
-(void)setRootName:(NSString *)value;
-(NSString *)ref;
-(void)setRef:(NSString *)value;
-(NSString *)name;
-(void)setName:(NSString *)value;
-(NSString *)format;
-(void)setFormat:(NSString *)value;
-(NSString *)className;
-(void)setClassName:(NSString *)value;
-(NSMutableArray *)childMappings;
-(void)setChildMappings:(NSMutableArray *)value;
-(void)setIsListNumber:(NSNumber *)value;
@end
