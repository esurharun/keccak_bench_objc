//
//  ViewController.m
//  keccaktest
//
//  Created by Marcus Frex on 4/3/13.
//  Copyright (c) 2013 Arneca Technologies. All rights reserved.
//

#import "ViewController.h"
#import "NSString+SHA3.h"




@interface ViewController ()

@end

@implementation ViewController

- (NSString *) getRandString:(NSUInteger) len {
    NSString *alphabet  = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
    NSMutableString *s = [NSMutableString stringWithCapacity:len];
    for (NSUInteger i = 0U; i < len; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    
    return s;
}

- (void)viewDidAppear:(BOOL)animated {
    
    self.tv.text = @"Starting measurements..";
    
    NSOperationQueue *calc_queue = [[NSOperationQueue alloc] init];
    
    NSMutableArray *wordlist = [NSMutableArray arrayWithCapacity:1000];
    
    for (NSUInteger c = 0U; c< 1000; c++) {
        [wordlist addObject:[self getRandString:50]];
    }
    
    __block NSTimeInterval total = 0;
    
    [calc_queue addOperationWithBlock:^{


        for (NSUInteger i = 0U; i< 50; i++) {
            

            
            NSDate *methodStart = [NSDate date];
            
            for (NSUInteger c = 0U; c< 1000; c++) {
                NSString *s = [wordlist objectAtIndex:c];
                
                [s sha3];
            }
            
            NSDate *methodFinish = [NSDate date];
            __block NSTimeInterval executionTime = [methodFinish timeIntervalSinceDate:methodStart];

            [[NSOperationQueue  mainQueue] addOperationWithBlock:^{
                
                self.tv.text = [self.tv.text stringByAppendingFormat:@"\nIt took %fms",executionTime*1000];
                
                total += executionTime;
                
            }];
            
            
        }
        
        [[NSOperationQueue  mainQueue] addOperationWithBlock:^{
            
            self.tv.text = [self.tv.text stringByAppendingFormat:@"\nAverage %fms for 1000 hashing",(total*1000)/50];
            
            
            
        }];
        

    }];
    
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
       
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
