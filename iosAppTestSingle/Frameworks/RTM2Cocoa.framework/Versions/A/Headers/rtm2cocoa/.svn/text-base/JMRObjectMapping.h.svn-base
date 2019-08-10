//
//  JMRObjectMapping.h
//  Mapper

/*

This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.

*/

#import <Foundation/Foundation.h>
#import "JMRMapping.h"
#import "JMRMappingType.h"

@interface JMRObjectMapping : JMRMappingType {
    Class _class;
    NSMutableArray *_mappings;
    // map by xmlPath
    NSMutableDictionary *_mappingsDict;
    NSString *_rootName;
}

-(id)objectValue;

// init
-(id)initWithClass:(Class)c mappings:(NSMutableArray *)mappings;
-(id)initWithClass:(Class)c mappings:(NSMutableArray *)mappings rootName:(NSString *)rootName;

+(JMRObjectMapping *)mappingWithClass:(Class)c mappings:(NSMutableArray *)mappings;
+(JMRObjectMapping *)mappingWithClass:(Class)c mappings:(NSMutableArray *)mappings rootName:(NSString *)rootName;

// accessors
-(Class)getClass;
-(void)setClass:(Class)value;
-(NSMutableArray *)mappings;
-(void)setMappings:(NSMutableArray *)value;
-(NSMutableDictionary *)mappingsDict;
-(void)setMappingsDict:(NSMutableDictionary *)value;
-(NSString *)rootName;
-(void)setRootName:(NSString *)value;
-(void)dealloc;
@end
