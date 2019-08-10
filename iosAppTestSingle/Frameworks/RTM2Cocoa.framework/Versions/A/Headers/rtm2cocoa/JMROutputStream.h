//
//  JMROutputStream.h
//  Excelsior

/*
 
 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
 
 */

#import <Foundation/Foundation.h>


@interface JMROutputStream : NSObject {
    NSOutputStream *_stream;
}

+(JMROutputStream *)outputStreamToFileAtPath:(NSString *)path;
+(JMROutputStream *)outputStreamToMemory;
-(id)initToFileAtPath:(NSString *)path;
-(void)writeString:(NSString *)string;
-(void)writeLine:(NSString *)string;
-(NSString *)stringValue;
@end
