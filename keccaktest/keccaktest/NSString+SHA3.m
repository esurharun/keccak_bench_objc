//
//  NSString+SHA3.m
//  keccaktest
//
//  Created by Marcus Frex on 4/3/13.
//  Copyright (c) 2013 Arneca Technologies. All rights reserved.
//

#import "NSString+SHA3.h"

@implementation NSString (NSString_SHA3)


-(NSString*) sha3{
    
    const char *data = [self cStringUsingEncoding:NSUTF8StringEncoding];
    unsigned char result[64];
    unsigned int x;
    
    memset(result, 0, sizeof result);
    

    
    
    size_t len = strlen(data);
    Hash(512, data, len * 8, result);
    
    unsigned int hash_length = sizeof(result);
    
    char *ret_buf = malloc(1024);
    
    for (x = 0; x < hash_length; x++) {
        if (x == 0)
        sprintf(ret_buf,"%02x", result[x]);
            else
        sprintf(ret_buf+ strlen(ret_buf),"%02x", result[x]);
    }
  
    
    return [[NSString alloc] initWithCString:ret_buf encoding:NSUTF8StringEncoding];
}

@end
