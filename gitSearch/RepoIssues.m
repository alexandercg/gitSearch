//
//  RepoIsuues.m
//  gitSearch
//
//  Created by Alexander Camacho Gámez on 31/07/16.
//  Copyright © 2016 Alexander Camacho Gámez. All rights reserved.
//

#import "RepoIssues.h"

@implementation RepoIssues

@synthesize issueTitle, createdBy, url, number, coments;

- (id)initWithTitle:(NSString*)title
                 by:(NSString*)user
                url:(NSString*)issueUrl
             number:(int)issueNumber
            coments:(int)numberComments{
    
    if( self = [super init] )
    {
        self.issueTitle = title;
        self.createdBy = user;
        self.url = issueUrl;
        self.number = issueNumber;
        self.coments = numberComments;
        
    }
    
    return self;
}

@end
