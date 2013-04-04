//
//  NSString+SHA3.h
//  keccaktest
//
//  Created by Marcus Frex on 4/3/13.
//  Copyright (c) 2013 Arneca Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KeccakNISTInterface.h"

// -- CATEGORY:INTERFACE
@interface NSString (NSString_SHA3)

-(NSString*) sha3;
@end
