//
//  JMRSwitchMappingType.h
//  Excelsior
//
//  Created by Jim Rankin on Fri Apr 09 2004.
//  Copyright (c) 2004 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMRMapping.h"
#import "JMRObjectMapping.h"
#import "XMLKeyValueElement.h"

@interface JMRSwitchMappingType : JMRObjectMapping {
    // map by xmlPath
    NSMutableDictionary *_xmlMappingsDict;    
    // map by class
    NSMutableDictionary *_classMappingsDict;    
}

// constructors and initializers

+(JMRSwitchMappingType *)mappingWithMappings:(NSMutableArray *)mappings;
-(id)initWithMappings:(NSMutableArray *)mappings;

// accessors

-(NSMutableDictionary *)xmlMappingsDict;
-(void)setXmlMappingsDict:(NSMutableDictionary *)value;
-(NSMutableDictionary *)classMappingsDict;
-(void)setClassMappingsDict:(NSMutableDictionary *)value;

-(JMRMapping *)mappingForXmlTag:(NSString *)tag;
-(JMRMapping *)mappingForClass:(Class *)c;
-(NSString *)xmlPathForObject:(id)o;
-(JMRObjectMapping *)objectMappingForObject:(id)o;
-(JMRObjectMapping *)objectMappingForElement:(XMLKeyValueElement *)elt;

@end
