//
//  JMRMappingList.h
//  Excelsior

/*
 
 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
 
 */

#import <Foundation/Foundation.h>
#import "JMRMappingFactory.h"

@interface JMRMappingList : NSObject {
    NSMutableDictionary *_namedMappings;
    NSMutableDictionary *_rootNamedMappings;
    // need to store mutable arrays indexed by typeRef here until referenced type is added to list
    NSMutableDictionary *_waitingList;
}

// constructor

+(JMRMappingList *)mappingListWithDataFromURL:(NSURL *)url;

// accessors

-(NSMutableDictionary *)namedMappings;
-(NSMutableDictionary *)rootNamedMappings;
-(NSMutableDictionary *)waitingList;

// public interface

-(void)addToWaitingList:(JMRMapping *)mapping withRef:(NSString *)ref;
-(void)updateMappingsWaitingForRef:(NSString *)ref withType:(JMRMappingType *)type;
-(void)addMappingType:(JMRMappingType *)value forName:(NSString *)name;
-(JMRMappingType *)mappingTypeWithName:(NSString *)name;
-(void)addMapping:(JMRObjectMapping *)value forRootName:(NSString *)rootName;
-(JMRObjectMapping *)mappingWithRootName:(NSString *)rootName;
-(JMRMapping *)mappingWithMappingFactory:(JMRMappingFactory *)factory;

@end
