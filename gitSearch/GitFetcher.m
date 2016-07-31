//
//  GitFetcher.m
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import "GitFetcher.h"

#define ApiURL  @"https://api.github.com"

@implementation GitFetcher

@synthesize languageSearch, itemsFound;

+(id)sharedInstance {
    static GitFetcher *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

@end
