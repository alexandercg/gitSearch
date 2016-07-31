//
//  Repository.m
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import "Repository.h"

@implementation Repository

@synthesize fullName, repoDescription, repoURL, starCount, issuesCount;

- (id)initWithFullName:(NSString*)name
           description:(NSString*)description
                   url:(NSString*)url
                 stars:(int)stars
                issues:(int)issues{
    
    if( self = [super init] )
    {
        self.fullName = name;
        self.repoDescription = description;
        self.repoURL = url;
        self.starCount = stars;
        self.issuesCount = issues;
        
    }
    
    return self;
}

@end