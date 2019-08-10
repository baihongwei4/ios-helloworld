//
//  JMROutputStream.m
//  Excelsior

/*
 
 This work is licensed under the Creative Commons Attribution License. To view a copy of this license, visit http://creativecommons.org/licenses/by/1.0/ or send a letter to Creative Commons, 559 Nathan Abbott Way, Stanford, California 94305, USA.
 
 */

#import "JMROutputStream.h"


@implementation JMROutputStream

+(JMROutputStream *)outputStreamToFileAtPath:(NSString *)path {
    return [[[JMROutputStream alloc] initToFileAtPath:path] autorelease];
}

-(id)initToFileAtPath:(NSString *)path {
    if (self = [super init]) {
        _stream = [[NSOutputStream outputStreamToFileAtPath:path append:NO] retain];
        [_stream open];
    }
    
    return self;
}

+(JMROutputStream *)outputStreamToMemory {
    return [[[JMROutputStream alloc] initToMemory] autorelease];
}
-(id)initToMemory {
    if (self = [super init]) {
        _stream = [[NSOutputStream outputStreamToMemory] retain];
        [_stream open];
    }
    
    return self;
}

-(void)writeString:(NSString *)string {
    NSData *data;
    
    if (!string || [string length]==0)
        return;
    
    data = [string dataUsingEncoding:[NSString defaultCStringEncoding]];
    [_stream write:[data bytes] maxLength:[data length]];
}

-(void)writeLine:(NSString *)string {
    [self writeString:string];
    [self writeString:@"\n"];
}

-(NSString *)stringValue {
    NSData *data = (NSData *)[_stream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
    NSString *string = nil;
    
    if (data)
        string = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:[NSString defaultCStringEncoding]];

    return string;
}

-(void)dealloc {
    [_stream close];
    [_stream release];
    
    [super dealloc];
}

@end
