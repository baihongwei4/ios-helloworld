/*
 *  DigestMd5.m
 *  RTMApiTest
 *
 *  Created by kkillian on 17/11/09.
 *  Copyright 2009 shufflecodebox. All rights reserved.
 *	This program is free software; you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation; either version 2 of the License, or
 *	(at your option) any later version.
 *
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with this program; if not, write to the Free Software
 *	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */


#import "DigestMd5.h"


@implementation DigestMd5

- (NSData *)digest
{
    if(clearText == nil) {
        return nil;
    }
	
    unsigned char outbuf[EVP_MAX_MD_SIZE];
    unsigned int templen, inlen;
    unsigned char *input=(unsigned char*)[clearText bytes];
    EVP_MD_CTX ctx;
    const EVP_MD *digest = NULL;
    
    inlen = [clearText length];
    
    if(inlen==0)
        return nil;
    
        digest=EVP_md5();
        if(!digest) {
            NSLog(@"cannot get digest with name %@",@"MD5");
            return nil;
        }
    
	
    EVP_MD_CTX_init(&ctx);
    EVP_DigestInit(&ctx,digest);
    if(!EVP_DigestUpdate(&ctx,input,inlen)) {
        NSLog(@"EVP_DigestUpdate() failed!");
        EVP_MD_CTX_cleanup(&ctx);
        return nil;			
    }
    if (!EVP_DigestFinal(&ctx, outbuf, &templen)) {
        NSLog(@"EVP_DigesttFinal() failed!");
        EVP_MD_CTX_cleanup(&ctx);
        return nil;
    }
    EVP_MD_CTX_cleanup(&ctx);
    
    return [NSData dataWithBytes:outbuf length:templen];
}

- (void)setClearTextWithString:(NSString *)c
{
	[clearText release];
	clearText = [[NSData alloc] initWithBytes:[c UTF8String] length:[c length]];
}

@end
