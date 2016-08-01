//
//  RepoContribuitor.m
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import "RepoContributor.h"

@implementation RepoContributor
@synthesize username, contributions;

-(id) initWithUsername:(NSString *)name contributions:(int)number{
    if( self = [super init] )
    {
        self.username = name;
        self.contributions = number;
    }
    
    return self;
}

@end
